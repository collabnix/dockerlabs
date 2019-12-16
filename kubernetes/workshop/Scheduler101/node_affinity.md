# What is node affinity ?

- In simple words this  allows you to tell Kubernetes to schedule pods only to specific subsets of nodes.
- The initial node affinity mechanism in early versions of Kubernetes was the nodeSelector field in the pod specification. The node had to include all the labels specified in that field to be eligible to become the target for the pod.
## nodeSelector
## Steps

```
git clone https://github.com/collabnix/dockerlabs
cd dockerlabs/kubernetes/workshop/Scheduler101
kubectl apply -f pod-nginx.yaml
```

- We have label on the node which having ssd  disk. 

## Viewing Your Pods

```
kubectl get pods --output=wide
```
```
[root@kube-master ~]# kubectl describe po nginx
Name:         nginx
Namespace:    default
Priority:     0
Node:         kube-slave1/10.91.224.249
Start Time:   Mon, 16 Dec 2019 05:27:21 +0000
Labels:       env=test
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"labels":{"env":"test"},"name":"nginx","namespace":"default"},"spec":{"contai...
Status:       Running
IP:           10.44.0.1
IPs:
  IP:  10.44.0.1
Containers:
  nginx:
    Container ID:   docker://a84f68354a54bbc3c04878f7c200167892d18cb92b015eb585687ce5d54b9051
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:922c815aa4df050d4df476e92daed4231f466acc8ee90e0e774951b0fd7195a4
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Mon, 16 Dec 2019 05:27:23 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-2672d (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-2672d:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-2672d
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  disktype=ssd
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason            Age                 From                  Message
  ----     ------            ----                ----                  -------
  Normal   Scheduled         <unknown>           default-scheduler     Successfully assigned default/nginx to kube-slave1
  Normal   Pulled            8m4s                kubelet, kube-slave1  Container image "nginx" already present on machine
  Normal   Created           8m4s                kubelet, kube-slave1  Created container nginx
  Normal   Started           8m3s                kubelet, kube-slave1  Started container nginx

```
- You can check in above output  Node-Selectors:  disktype=ssd

## Deleting the Pod
```
kubectl delete -f pod-nginx.yaml
pod "nginx" deleted
```


# Node affinity

- Node affinity is conceptually similar to nodeSelector – it allows you to constrain which nodes your pod is eligible to be scheduled on, based on labels on the node.

- There are currently two types of node affinity.
1. requiredDuringSchedulingIgnoredDuringExecution  (Preferred during scheduling, ignored during execution; we are also known as "hard" requirements)
2. preferredDuringSchedulingIgnoredDuringExecution  (Required during scheduling, ignored during execution; we are also known as "soft" requirements)

## Steps

```
git clone https://github.com/collabnix/dockerlabs
cd dockerlabs/kubernetes/workshop/Scheduler101
kubectl apply -f pod-with-node-affinity.yaml
```
 

## Viewing Your Pods

```
kubectl get pods --output=wide
NAME                 READY   STATUS    RESTARTS   AGE     IP          NODE          NOMINATED NODE   READINESS GATES
with-node-affinity   1/1     Running   0          9m46s   10.44.0.1   kube-slave1   <none>           <none>

```
```
[root@kube-master ~]# kubectl describe pods with-node-affinity
Name:         with-node-affinity
Namespace:    default
Priority:     0
Node:         kube-slave1/10.91.224.249
Start Time:   Mon, 16 Dec 2019 06:25:47 +0000
Labels:       <none>
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"name":"with-node-affinity","namespace":"default"},"spec":{"affinity":{"nodeA...
Status:       Running
IP:           10.44.0.1
IPs:
  IP:  10.44.0.1
Containers:
  nginx:
    Container ID:   docker://2e3a9df6d9f67c6ab420af06babe66f100c3cb1f0b81c793cbb87682be84dbd8
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:50cf965a6e08ec5784009d0fccb380fc479826b6e0e65684d9879170a9df8566
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Mon, 16 Dec 2019 06:25:51 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-2672d (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-2672d:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-2672d
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason            Age              From                  Message
  ----     ------            ----             ----                  -------
  Normal   Scheduled         <unknown>        default-scheduler     Successfully assigned default/with-node-affinity to kube-slave1
  Normal   Pulling           4s               kubelet, kube-slave1  Pulling image "nginx"
  Normal   Pulled            2s               kubelet, kube-slave1  Successfully pulled image "nginx"
  Normal   Created           2s               kubelet, kube-slave1  Created container nginx
  Normal   Started           1s               kubelet, kube-slave1  Started container nginx
```
## Step  Cleanup

Finally you can clean up the resources you created in your cluster:
```
kubectl delete -f pod-with-node-affinity.yaml
```