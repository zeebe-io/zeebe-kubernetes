# Exposing Zeebe Services using NGINX Ingress Controller

For most deployments an Ingress Controller + Ingress definitions will be used to provide a central point of access to the cluster from the outside world. 

A common scenario will include an NGINX Ingress Controller proxying requests to Kubernetes Services. If we want to expose our services out of the cluster, for example Operate and Kibana, we need to install an Ingress Controller and then deploy the Ingress definitions with the right routing rules. 

## Installing NGINX Ingress Controller with HELM

HELM is a popular Kubernetes Package manager that facilitate the packaging, release and installation of common services into Kubernetes. 
Each HELM package includes a set of Kubernetes Manifests (yaml files) with the description of the Kubernetes Resources needed to deploy each specific service or set of services. 

If you haven't installed HELM CLI please follow the instructions [here](https://helm.sh/docs/using_helm/#installing-helm)

Now you should be able to do: 
```
> helm version
```

If you haven't initialized HELM against your cluster you will need to create a ServiceAccount and a ClusterRoleBinding to enable HELM to install components in your cluster, you can do that by running: 

```
> kubectl apply -f helm-service-account-role.yaml
```

Once this is done you can initialize the server side component of HELM with:

```
> helm init --service-account helm --upgrade
```

Now you are ready to install HELM packages from the Kubernetes Stable reporitory. That means that in order to install the NGINX ingress controller you can do:

```
> helm install stable/nginx-ingress
```

Once the Ingress Controller is deployed, you can now deploy Ingress definitions, here are provided one for Operate and one for Kibana:
```
> kubectl apply -f kibana-ingress.yaml
> kubectl apply -f operate-ingress.yaml
```

These definitions will be picked up by the Ingress Controller and new routes will be added to the main entrypoint. 

If you have your Kubernetes cluster in GKE/GCP you should be able to see the external IP by running: 
```
> kubectl get services
```

You should see something like this: 
```
NAME                                           TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                                  AGE
cloying-beetle-nginx-ingress-controller        LoadBalancer   10.56.2.117    <X.X.X.X>     80:31103/TCP,443:31882/TCP               5s
cloying-beetle-nginx-ingress-default-backend   ClusterIP      10.56.13.253   <none>        80/TCP                                   5s
```

Where `<X.X.X.X>` is the external IP. Notice that depending on the Cloud Provider, it takes sometime to obtain the External IP so you will see the `<pending>` state while that happens. If for some reason you never get an External IP, you will need to check the specific configurations for your Cloud Provider. 

If you are running with Kubernetes KIND, LoadBalancers are not supported, that means that you will need to do `kubectl port-foward` to your Ingress Controller. This will reduce the amount of port forwards required to access to all the services. 

Also, notice that the Zeebe Cluster itself is not exposed via the Ingress Controller. The main reason for this is to avoid complex routing for GRCP and to make sure that we promote the use of in cluster workers when possible. If Workers are outside of the cluster, Kubernetes Resources can be used to make that communication happen. For Development purposes, you can always `kubectl port-foward` to the Zeebe Cluster. 

Once you have your External IP you will be able to access to the following URLs:
- http://`<X.X.X.X>`/ -> to access Operate
- http://`<X.X.X.X>`/logs -> to access Kibana


In order to get Kibana working behind a proxy (like NGINX) you will need to uncomment the following section in  your Kibana deployment descriptor:
```
# Uncomment for running behind a proxy / ingress controller
#        - name: SERVER_BASEPATH
#          value: /logs
#        - name: SERVER_REWRITEBASEPATH
#          value: "true"
```

You can do that before installing the Zeebe Cluster with the installation scripts or changing the deployment when it is running by executing: 
```
> kubectl edit deploy kibana
```

And add the previous environment variables under the following section: 
```
spec:
      containers:
      - name: kibana
        image: docker.elastic.co/kibana/kibana-oss:6.7.0
        env:
        - name: ELASTICSEARCH_URL
          value: http://elasticsearch.zeebe:9200
```

Make sure that you use the correct indentation, it is YAML after all :) 

