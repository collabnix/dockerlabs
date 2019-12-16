# Anti-Node Affinity ?

- Some scenarios require that you don’t use one or more nodes except for particular pods. Think of the nodes that host your monitoring application.
- Those nodes shouldn’t have many resources due to the nature of their role. Thus, if other pods than those which have the monitoring app are scheduled to those nodes, they hurt monitoring and also degrades the application they are hosting.
- In such a case, you need to use node anti-affinity to keep pods away from a set of nodes.

## Steps
```
git clone https://github.com/collabnix/dockerlabs
cd dockerlabs/kubernetes/workshop/Scheduler101
kubectl apply -f pod-anti-node-affinity.yaml
```
## Viewing Your Pods

```
kubectl get pods --output=wide
NAME                 READY   STATUS    RESTARTS   AGE     IP          NODE          NOMINATED NODE   READINESS GATES
nginx                1/1     Running   0          3m27s   10.44.0.2   kube-slave1   <none>           <none>

```
## Get nodes label detail
```
kubectl get nodes --show-labels | grep disk
kube-slave1   Ready    worker   31d   v1.16.2  cpu=eight-cores,disktype=ssd,nodeName=best-node,role=testing
kube-slave2   Ready    worker   31d   v1.16.3   disktype=ssd,nodeName=foo-node,role=monitoring
```
## Get pod describe 
```
kubectl describe pods nginx
Name:         nginx
Namespace:    default
Priority:     0
Node:         kube-slave1/10.91.224.249
Start Time:   Mon, 16 Dec 2019 07:24:52 +0000
Labels:       <none>
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"name":"nginx","namespace":"default"},"spec":{"affinity":{"nodeAffinity":{"re...
Status:       Running
IP:           10.44.0.2
IPs:
  IP:  10.44.0.2
Containers:
  nginx:
    Container ID:   docker://d60b1e34783ef7be836f3a566d8bb18a964722e09de1b9c2b5b43c3159dd3c37
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:50cf965a6e08ec5784009d0fccb380fc479826b6e0e65684d9879170a9df8566
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Mon, 16 Dec 2019 07:24:55 +0000
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
  Type     Reason            Age                From                  Message
  ----     ------            ----               ----                  -------
  Normal   Scheduled         <unknown>          default-scheduler     Successfully assigned default/nginx to kube-slave1
  Normal   Pulling           29s                kubelet, kube-slave1  Pulling image "nginx"
  Normal   Pulled            27s                kubelet, kube-slave1  Successfully pulled image "nginx"
  Normal   Created           27s                kubelet, kube-slave1  Created container nginx
  Normal   Started           27s                kubelet, kube-slave1  Started container nginx

```


- Adding another key to the matchExpressions with the operator NotIn will avoid scheduling the nginx pods on any node labelled role=monitoring.


## Step  Cleanup

Finally you can clean up the resources you created in your cluster:
```
kubectl delete -f pod-anti-node-affinity.yaml
```
