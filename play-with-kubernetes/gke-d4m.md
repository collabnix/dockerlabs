# Bootstrapping GKE Cluster using Docker for Mac

## Pre-requisite:

- Install [google-cloud-sdk](https://cloud.google.com/sdk/docs/quickstart-macos)
- Enable Google Cloud Engine API
- Authenticate Your Google Cloud using `gcloud auth`

## Creating GKE Cluster Node

```
Ajeets-MacBook-Air:~ ajeetraina$ gcloud container clusters create k8s-lab1 --disk-size 10 --zone asia-east1-a --machine-type n1-standard-2 --num-nodes 3 --scopes compute-rw
WARNING: The behavior of --scopes will change in a future gcloud release: service-control and service-management scopes will no longer be added to what is specified in --scopes. To use these scopes, add them explicitly to --scopes. To use the new behavior, set container/new_scopes_behavior property (gcloud config set container/new_scopes_behavior true).
WARNING: Starting in Kubernetes v1.10, new clusters will no longer get compute-rw and storage-ro scopes added to what is specified in --scopes (though the latter will remain included in the default --scopes). To use these scopes, add them explicitly to --scopes. To use the new behavior, set container/new_scopes_behavior property (gcloud config set container/new_scopes_behavior true).
Creating cluster k8s-lab1...done.
Created [https://container.googleapis.com/v1/projects/spheric-temple-187614/zones/asia-east1-a/clusters/k8s-lab1].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/asia-east1-a/k8s-lab1?project=spheric-temple-187614
kubeconfig entry generated for k8s-lab1.
NAME      LOCATION      MASTER_VERSION  MASTER_IP       MACHINE_TYPE   NODE_VERSION  NUM_NODES  STATUS
k8s-lab1  asia-east1-a  1.7.11-gke.1    35.201.215.156  n1-standard-2  1.7.11-gke.1  3          RUNNING
```

## Verify it on Google CLoud

```
Cluster

Master version	
1.7.11-gke.1 Upgrade available
Endpoint	
35.201.215.156 Show credentials
Client certificate	
Enabled
Kubernetes alpha features	
Disabled
Total size	
3
Master zone	
...
```

## Connecting to Your GKE Cluster 

You can connect to your cluster via command-line or using a dashboard.

```
Ajeets-MacBook-Air:~ ajeetraina$ gcloud container clusters get-credentials k8s-lab1 --zone asia-east1-a --project spheric-temple-187614
```

Fetching cluster endpoint and auth data.
kubeconfig entry generated for k8s-lab1.

## 

Ajeets-MacBook-Air:~ ajeetraina$ kubectl get nodes
NAME                                      STATUS    ROLES     AGE       VERSION
gke-k8s-lab1-default-pool-042d2598-591g   Ready     <none>    7m        v1.7.11-gke.1
gke-k8s-lab1-default-pool-042d2598-c633   Ready     <none>    7m        v1.7.11-gke.1
gke-k8s-lab1-default-pool-042d2598-q603   Ready     <none>    7m        v1.7.11-gke.1
  
