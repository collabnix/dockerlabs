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
  
 ## Output in JSON
 
 ```
 dockercaptain81@cloudshell:~/dockerlabs/kubernetes/workshop/pods101$ kubectl get pods -o json
{
    "apiVersion": "v1",
    "items": [
        {
            "apiVersion": "v1",
            "kind": "Pod",
            "metadata": {
                "annotations": {
                    "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Pod\",\"metadata\":{\"annotations\":{},\"name\":\"webserver\",\"namespace\":\"default\"},\"spec\":{\"con
tainers\":[{\"image\":\"nginx:latest\",\"name\":\"webserver\",\"ports\":[{\"containerPort\":80}]}]}}\n",
                    "kubernetes.io/limit-ranger": "LimitRanger plugin set: cpu request for container webserver"
                },
                "creationTimestamp": "2019-11-28T08:48:28Z",
                "name": "webserver",
                "namespace": "default",
                "resourceVersion": "20080",
                "selfLink": "/api/v1/namespaces/default/pods/webserver",
                "uid": "d8e0b56b-11bb-11ea-a1bf-42010a800006"
            },
            "spec": {
                "containers": [
                    {
                        "image": "nginx:latest",
                        "imagePullPolicy": "Always",
                        "name": "webserver",
                        "ports": [
                            {
                                "containerPort": 80,
                                "protocol": "TCP"
                            }
                        ],
                        "resources": {
                            "requests": {
                                "cpu": "100m"
                            }
                        },
                        "terminationMessagePath": "/dev/termination-log",
                        "terminationMessagePolicy": "File",
             ```
 
 
 
 ## Deleting the Pod
  
  ```
  dockercaptain81@cloudshell:~/dockerlabs/kubernetes/workshop/pods101 (fresh-heuristic-260312)$ kubectl delete -f pod01.yaml
pod "webserver" deleted

dockercaptain81@cloudshell:~/dockerlabs/kubernetes/workshop/pods101 (fresh-heuristic-260312)$ kubectl get po -o wide
No resources found.

```

## Executing Commands Against Pods

Let us re-create the Pod and try to execute command against the Pod

```
dockercaptain81@cloudshell:~/dockerlabs/kubernetes/workshop/pods101$ kubectl apply -f pod01.yaml
pod/webserver created
dockercaptain81@cloudshell:~/dockerlabs/kubernetes/workshop/pods101$ kubectl exec -it webserver -- /bin/bash
root@webserver:/#
root@webserver:/# cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux 10 (buster)"
NAME="Debian GNU/Linux"
VERSION_ID="10"
VERSION="10 (buster)"
VERSION_CODENAME=buster
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
root@webserver:/#
```


