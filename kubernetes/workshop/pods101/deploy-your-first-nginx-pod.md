# Deploying Your First Nginx Pod

## Pre-requisite:


## Steps

```
git clone https://github.com/collabnix/dockerlabs
cd dockerlabs/kubernetes/workshop/pods101
kubectl apply -f pods01.yaml
```

## Viewing Your Pods

```
kubectl get pods
```

## Which Node Is This Pod Running On?

```
kubectl get pods -o wide
```

```
dockercaptain81@cloudshell:~/dockerlabs/kubernetes/workshop/pods101 (fresh-heuristic-260312)$ kubectl describe po webserver
Name:               webserver
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               gke-standard-cluster-1-default-pool-78257330-5hs8/10.128.0.3
Start Time:         Thu, 28 Nov 2019 13:02:19 +0530
Labels:             <none>
Annotations:        kubectl.kubernetes.io/last-applied-configuration:
                      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"name":"webserver","namespace":"default"},"spec":{"containers":[{"image":"ngi...
                    kubernetes.io/limit-ranger: LimitRanger plugin set: cpu request for container webserver
Status:             Running
IP:                 10.8.0.3
Containers:
  webserver:
    Container ID:   docker://ff06c3e6877724ec706485374936ac6163aff10822246a40093eb82b9113189c
    Image:          nginx:latest
    Image ID:       docker-pullable://nginx@sha256:189cce606b29fb2a33ebc2fcecfa8e33b0b99740da4737133cdbcee92f3aba0a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 28 Nov 2019 13:02:25 +0530
    Ready:          True
    Restart Count:  0
    Requests:
      cpu:        100m
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-mpxxg (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-mpxxg:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-mpxxg
    Optional:    false
QoS Class:       Burstable
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age    From                                                        Message
  ----    ------     ----   ----                                                        -------
  Normal  Scheduled  2m54s  default-scheduler                                           Successfully assigned default/webserver to gke-standard-cluster-1-default-pool-78257330-5hs8
  Normal  Pulling    2m53s  kubelet, gke-standard-cluster-1-default-pool-78257330-5hs8  pulling image "nginx:latest"
  Normal  Pulled     2m50s  kubelet, gke-standard-cluster-1-default-pool-78257330-5hs8  Successfully pulled image "nginx:latest"
  Normal  Created    2m48s  kubelet, gke-standard-cluster-1-default-pool-78257330-5hs8  Created container
  Normal  Started    2m48s  kubelet, gke-standard-cluster-1-default-pool-78257330-5hs8  Started container
  ```
