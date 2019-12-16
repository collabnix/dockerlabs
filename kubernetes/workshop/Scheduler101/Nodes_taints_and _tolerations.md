# What is Node taints and tolerations ?

- This Kubernetes feature allows users to mark a node (taint the node) so that no pods can be scheduled to it, unless a pod explicitly tolerates the taint.
- When you taint a node, it is automatically excluded from pod scheduling. When the schedule runs the predicate tests on a tainted node, they’ll fail unless the pod has toleration for that node. 

- Like last monitoring example: Let assume  new member joins the development team, writes a Deployment for her application, but forgets to exclude the monitoring nodes from the target nodes? Kubernetes administrators need a way to repel pods from nodes without having to modify every pod definition. 

## Steps

```
git clone https://github.com/collabnix/dockerlabs
cd dockerlabs/kubernetes/workshop/Scheduler101

kubectl taint nodes kube-slave1 role=monitoring:NoSchedule
node/kube-slave1 tainted

kubectl apply -f pod-taint-node.yaml
```

## Viewing Your Pods

```
kubectl get pods --output=wide
```

## Get nodes label detail

```
kubectl get nodes --show-labels|grep slave |grep role
kube-slave1   Ready    worker   31d   v1.16.2   disktype=ssd,nodeName=best-node,role=monitoring
kube-slave2   Ready    worker   31d   v1.16.3   disktype=ssd,nnodeName=foo-node,role=monitoring

```
## Get pod describe 
```
kubectl describe pods nginx
Name:         nginx
Namespace:    default
Priority:     0
Node:         kube-slave2/10.91.224.244
Start Time:   Mon, 16 Dec 2019 07:52:39 +0000
Labels:       <none>
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"name":"nginx","namespace":"default"},"spec":{"affinity":{"nodeAffinity":{"re...
Status:       Pending
IP:
IPs:          <none>
Containers:
  nginx:
    Container ID:
    Image:          nginx
    Image ID:
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-2672d (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             False
  ContainersReady   False
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
  Normal   Scheduled         <unknown>        default-scheduler     Successfully assigned default/nginx to kube-slave2

  Normal   Pulling           4s               kubelet, kube-slave2  Pulling image "nginx"
```
- Deployed pod on slave2.

## Step  Cleanup

Finally you can clean up the resources you created in your cluster:
```
kubectl delete -f pod-tain-node.yaml
```

## Tolerations 

- A toleration is a way of ignoring a taint during scheduling. Tolerations aren’t applied to nodes, but rather the pods. So, in the example above, if we apply a toleration to the PodSpec, we could “tolerate” the slow disks on that node and still use it.

## Steps

```
git clone https://github.com/collabnix/dockerlabs
cd dockerlabs/kubernetes/workshop/Scheduler101
kubectl apply -f pod-tolerations-node.yaml
```
## Viewing Your Pods

```
kubectl get pods --output=wide
```

## Which Node Is This Pod Running On?
```
kubectl describe pods nginx
Name:         nginx
Namespace:    default
Priority:     0
Start Time:   Mon, 16 Dec 2019 09:59:16 +0000
Labels:       env=test
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"labels":{"env":"test"},"name":"nginx","namespace":"default"},"spec":{"contai...
Status:       Running
IP:           10.47.0.2
IPs:
  IP:  10.47.0.2
Containers:
  nginx:
    Container ID:   docker://8768971083bca73fbf30c6ca30899b1d9ab7489de08289df5f5579130fba30f6
    Image:          nginx:1.7.9
    Image ID:       docker-pullable://nginx@sha256:e3456c851a152494c3e4ff5fcc26f240206abac0c9d794affb40e0714846c451
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Mon, 16 Dec 2019 09:59:18 +0000
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
                 role=monitoring:NoSchedule
Events:
  Type     Reason            Age                From                  Message
  ----     ------            ----               ----                  -------
  Normal   Scheduled         <unknown>          default-scheduler     Successfully assigned default/nginx to kube-slave1
  Normal   Pulled            32s                kubelet, kube-slave1  Container image "nginx:1.7.9" already present on machine
  Normal   Created           32s                kubelet, kube-slave1  Created container nginx
  Normal   Started           31s                kubelet, kube-slave1  Started container nginx
```


## Step  Cleanup

Finally you can clean up the resources you created in your cluster:
```
kubectl delete -f pod-tolerations-node.yaml
```

- An important thing to notice, though, is that tolerations may enable a tainted node to accept a pod but it does not guarantee that this pod runs on that specific node.
- In other words, the tainted node  will be considered as one of the candidates for running our pod. However, if another node has a higher priority score, it will be chosen instead. For situations like this, you need to combine the toleration with nodeSelector or node affinity parameters.
