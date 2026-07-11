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

## Listing the Nodes

```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl get nodes
NAME                                      STATUS    ROLES     AGE       VERSION
gke-k8s-lab1-default-pool-042d2598-591g   Ready     <none>    7m        v1.7.11-gke.1
gke-k8s-lab1-default-pool-042d2598-c633   Ready     <none>    7m        v1.7.11-gke.1
gke-k8s-lab1-default-pool-042d2598-q603   Ready     <none>    7m        v1.7.11-gke.1
  
```

## Deploy Nginx on GKE Cluster

This requires two commands. deploy and expose.

### Deploy nginx:

```
$ kubectl run nginx --image=nginx --replicas=3

deployment "nginx" created
```

This will create a replication controller to spin up 3 pods, each pod runs the nginx container.

## Step 2: Verify that the pods are running.

You can see the status of deployment by running:

```
kubectl get pods -owide
NAME                    READY     STATUS    RESTARTS   AGE       IP          NODE
nginx-7c87f569d-glczj   1/1       Running   0          8s        10.12.2.6   gke-k8s-lab1-default-pool-b2aaa29b-w904
nginx-7c87f569d-pll76   1/1       Running   0          8s        10.12.0.8   gke-k8s-lab1-default-pool-b2aaa29b-2gzh
nginx-7c87f569d-sf8z9   1/1       Running   0          8s        10.12.1.8   gke-k8s-lab1-default-pool-b2aaa29b-qpc7
```

Youcan see that each nginx pod is now running in a different node (virtual machine).

Once all pods have the Running status, you can then expose the nginx cluster as an external service.

## Step 3: Expose the nginx cluster as an external service.

```
$ kubectl expose deployment nginx --port=80 --target-port=80 \
--type=LoadBalancer

service "nginx" exposed
```

This command will create a network load balancer to load balance traffic to the three nginx instances.

## Step 4: Find the network load balancer address:

```
kubectl get service nginx
NAME      TYPE           CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE
nginx     LoadBalancer   10.15.247.8   <pending>     80:30253/TCP   12s
```

It may take several minutes to see the value of EXTERNAL_IP. If you don't see it the first time with the above command, retry every minute or so until the value of EXTERNAL_IP is displayed.

You can then visit http://EXTERNAL_IP/ to see the server being served through network load balancing.


## 
