```bash
kubectl apply -f 01_namespace.yml
kubectl apply -f 02_configmap_zeebe.yml
kubectl apply -f 03_storageclass_zeebe-desktop.yml
kubectl apply -f 04_service_zeebe-desktop.yml
kubectl apply -f 10_statefulset_zeebe.yml
kubectl apply -f 20_storageclass_elasticsearch-desktop.yml
kubectl apply -f 21_persistentvolumeclaim_elasticsearch.yml
kubectl apply -f 22_service_elasticsearch.yml
kubectl apply -f 25_deployment_elasticsearch.yml
kubectl apply -f 31_service_kibana.yml
kubectl apply -f 35_deployment_kibana.yml
kubectl apply -f 40_configmap_operate.yml
kubectl apply -f 41_service_operate.yml
kubectl apply -f 45_deployment_operate.yml

# Only need to do once
kubectl config set-context zeebe --cluster=docker-desktop --user=docker-desktop --namespace=zeebe
kubectl config use-context zeebe
```