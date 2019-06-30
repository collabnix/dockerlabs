# Lab #01: Creating Nginx Pod

```
kubectl create -f nginx-pod.yaml
```

```
[node1 lab01-creating-nginx-pod]$ kubectl apply -f nginx-pod.yaml
pod/nginx-pod created
```

```
[node1 lab01-creating-nginx-pod]$ kubectl get po,svc,deploy
NAME            READY   STATUS              RESTARTS   AGEpod/nginx-pod   0/1     ContainerCreating   0          8s
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   76m
[node1 lab01-creating-nginx-pod]$
```

```
[node1 lab01-creating-nginx-pod]$ kubectl describe po nginx-pod
Name:               nginx-pod
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               node2/192.168.0.7
Start Time:         Sun, 30 Jun 2019 01:14:49 +0000
Labels:             name=nginx-pod
Annotations:        kubectl.kubernetes.io/last-applied-configuration:
                      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"labels":{"name":"nginx-pod"},"name":"nginx-pod","namespace":"default"},"spec...
Status:             Running
IP:                 10.44.0.1
Containers:
  nginx:
    Container ID:   docker://ba2f8aafc79fcdbdcb2c77a7f6f268a05be75a9f8430d3f05d1b536306de3663
    Image:          nginx:latest
    Image ID:       docker-pullable://nginx@sha256:bdbf36b7f1f77ffe7bd2a32e59235dff6ecf131e3b6b5b96061c652f30685f3a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sun, 30 Jun 2019 01:14:58 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-jrm8k (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-jrm8k:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-jrm8k
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  13m   default-scheduler  Successfully assigned default/nginx-pod to node2
  Normal  Pulling    13m   kubelet, node2     Pulling image "nginx:latest"
  Normal  Pulled     13m   kubelet, node2     Successfully pulled image "nginx:latest"
  Normal  Created    13m   kubelet, node2     Created container nginx
  Normal  Started    13m   kubelet, node2     Started container nginx
  ```

