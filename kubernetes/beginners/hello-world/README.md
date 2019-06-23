## Hello World Example on K8s Cluster

## Pre-requisite

- Follow [this](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/beginners/install-k8s-on-GCP-platform.md)


```
rainaajeet1981@kubemaster:~$ sudo kubectl apply -f https://k8s.io/examples/service/load-balancer-example.yaml
deployment.apps/hello-world created
```

```
rainaajeet1981@kubemaster:~$ kubectl get deployments hello-world
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
hello-world   0/5     5            0           22s
```

```
rainaajeet1981@kubemaster:~$ kubectl describe deployments hello-world
Name:                   hello-world
Namespace:              default
CreationTimestamp:      Sun, 23 Jun 2019 08:08:59 +0000
Labels:                 app.kubernetes.io/name=load-balancer-example
Annotations:            deployment.kubernetes.io/revision: 1
                        kubectl.kubernetes.io/last-applied-configuration:
                          {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"labels":{"app.kubernetes.io/name":"load-balancer-
example"},"name...
Selector:               app.kubernetes.io/name=load-balancer-example
Replicas:               5 desired | 5 updated | 5 total | 5 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app.kubernetes.io/name=load-balancer-example
  Containers:
   hello-world:
    Image:        gcr.io/google-samples/node-hello:1.0
    Port:         8080/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   hello-world-bbbb4c85d (5/5 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  31s   deployment-controller  Scaled up replica set hello-world-bbbb4c85d to 5
rainaajeet1981@kubemaster:~$ 
```

```
rainaajeet1981@kubemaster:~$ kubectl expose deployment hello-world --type=LoadBalancer --name=my-service
service/my-service exposed
rainaajeet1981@kubemaster:~$ 
```

```
kubectl describe services my-service
```

```
rainaajeet1981@kubemaster:~$ kubectl describe services my-service
Name:                     my-service
Namespace:                default
Labels:                   app.kubernetes.io/name=load-balancer-example
Annotations:              <none>
Selector:                 app.kubernetes.io/name=load-balancer-example
Type:                     LoadBalancer
IP:                       10.104.76.76
Port:                     <unset>  8080/TCP
TargetPort:               8080/TCP
NodePort:                 <unset>  32763/TCP
Endpoints:                10.244.1.4:8080,10.244.1.5:8080,10.244.1.6:8080 + 2 more...
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
```


