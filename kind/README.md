# Running Zeebe on Kubernetes KIND
[KIND (Kubernetes in Docker)](https://github.com/kubernetes-sigs/kind) allows you to run a local and hermetic Kubernetes cluster only depending on Docker (No VMs are needed). 
KIND allows you to set up different cluster topologies to test what happens if a nodes goes down and it is currently used for testing Kubernetes itself. 

If you have docker installed, you can follow the [KIND installation instructions here](https://github.com/kubernetes-sigs/kind#installation-and-usage).

Before running Zeebe you will need to create a cluster with:

```
> kind create cluster
```

Alternatively you can create a 3 nodes cluster by running:

```
> kind create cluster --config kind/3-nodes-kind-cluster.yml
```

Once you have the cluster created you need to make sure that you can connect to the cluster with the `kubectl` command: 

```
> export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"
```

Once this is done you are ready to deploy Zeebe to the cluster by running:
```
> bash install-kind.sh
```

Notice that the only difference from GCP and Azure are the StorageClass,which for KIND we will use the default/local definition instead of the ones from the cloud providers. 

If you don't have an Ingress Controller installed in the cluster you can use port-forward to access the services, for example to access Camunda Operate: 

```
> kubectl port-forward svc/operate 8080:80
```

Then in your browser access [localhost:8080](http://localhost:8080), you can login with the following credentials (user/password): `demo/demo`

You can also access Kibana Dashboard by running the following port-forward, in a separate terminal: 
```
> kubectl port-forward svc/kibana 8081:80
```

And then accessing in your browser [localhost:8081](http://localhost:8081). 



