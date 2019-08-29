# Zeebe Kubernetes

This repository contains Kubernetes manifests to give you a starting point for creating your own Kubernetes deployment of Zeebe. There are many approaches you can take, and tools that you can use to manage Kubernetes. These files use `kubectl` only, to remain agnostic to configuration and deployment tools.

These configurations are based on [Per Arne Tollefson's Zeebe Kubernetes Deployment](https://github.com/perarnetol/zeebe-kubernetes-deployment), with additional contributions from the community.

The configuration in this repository will deploy a cluster of three Zeebe brokers using the embedded gateway (each broker runs a gateway and there is no separate standalone gateway). You will need to deploy your workers into the same Kubernetes cluster, or else configure your networking to allow an ingress for workers.

The configuration also deploys an Elastic Search container and a Camunda Operate container, to allow you to inspect your workflows.

Persistent storage configuration is provided for Azure and Google Cloud Platform. For other cloud providers you will need to write a Storage Class configuration. You can copy the `03_storageclass-*` files in this repository and modify them for your scenario.

Pull Requests are welcome!

## Getting Help

The [Zeebe forum](https://forum.zeebe.io/) and the [Zeebe Slack](https://zeebe-slack-invite.herokuapp.com/) are the best place to ask about Zeebe.
