#!/bin/bash

KUBECTL="kubectl apply -f"

$KUBECTL 01_namespace.yml
$KUBECTL 02_configmap_zeebe.yml
$KUBECTL 03_storageclass_zeebe-gcp.yml
$KUBECTL 04_service_zeebe.yml
$KUBECTL 10_statefulset_zeebe.yml
$KUBECTL 20_storageclass_elasticsearch-gcp.yaml
$KUBECTL 21_persistentvolumeclaim_elasticsearch.yml
$KUBECTL 22_service_elasticsearch.yml
$KUBECTL 25_deployment_elasticsearch.yml
$KUBECTL 31_service_kibana.yml
$KUBECTL 35_deployment_kibana.yml
$KUBECTL 40_configmap_operate.yml
$KUBECTL 41_service_operate.yml
$KUBECTL 45_deployment_operate.yml
