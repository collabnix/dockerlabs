# Getting Started with Nginx 


## Creating 2 NGINX Pods

The kubectl run line below will create two nginx pods listening on port 80. It will also create a deployment named my-nginx to ensure that there are always two pods running.


```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl run my-nginx --image=nginx --replicas=2 --port=82
deployment "my-nginx" created
```

```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl get pods
NAME                           READY     STATUS              RESTARTS   AGE

my-nginx-6994b857d7-88kv8      0/1       ContainerCreating   0          7s
my-nginx-6994b857d7-vlhjl      0/1       ContainerCreating   0          7s

```


Once the pods are created, you can list them to see what is up and running:

```

Ajeets-MacBook-Air:~ ajeetraina$ kubectl get pods -o wide
NAME                           READY     STATUS    RESTARTS   AGE       IP          NODE

my-nginx-6994b857d7-88kv8      1/1       Running   0          17m       10.1.0.22   docker-for-desktop
my-nginx-6994b857d7-vlhjl      1/1       Running   0          17m       10.1.0.21   docker-for-desktop


```

You can also see the deployment that was created:

```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl get deployment -o wide
NAME          DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       CONTAINERS    IMAGES                                 SELECTOR

my-nginx      2         2         2            2           16m       my-nginx      nginx                                  run=my-nginx
nginx         1         1         1            1           20h       nginx         nginx                                  run=nginx



```

Little more details..

```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl describe deployment my-nginx
Name:                   my-nginx
Namespace:              default
CreationTimestamp:      Mon, 15 Jan 2018 08:11:55 +0530
Labels:                 run=my-nginx
Annotations:            deployment.kubernetes.io/revision=1
Selector:               run=my-nginx
Replicas:               2 desired | 2 updated | 2 total | 2 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  1 max unavailable, 1 max surge
Pod Template:
  Labels:  run=my-nginx
  Containers:
   my-nginx:
    Image:        nginx
    Port:         82/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
OldReplicaSets:  <none>
NewReplicaSet:   my-nginx-6994b857d7 (2/2 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  20m   deployment-controller  Scaled up replica set my-nginx-6994b857d7 to 2
Ajeets-MacBook-Air:~ ajeetraina$ 

```

Lets look at services meanwhile. As you see there has been no service yet created.

```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl get services
NAME              TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
example-service   NodePort    10.106.252.68   <none>        8080:31477/TCP   19h
kubernetes        ClusterIP   10.96.0.1       <none>        443/TCP          2d
nginx             ClusterIP   10.105.96.0     <none>        80/TCP           20h
```

# Exposing your pods to the internet



```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl expose deployment my-nginx --port=80
service "my-nginx" exposed
```
```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl get services
NAME              TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
example-service   NodePort    10.106.252.68    <none>        8080:31477/TCP   19h
kubernetes        ClusterIP   10.96.0.1        <none>        443/TCP          2d
my-nginx          ClusterIP   10.101.119.153   <none>        80/TCP           4s

```

Introspection

```
kubectl get pods
kubectl get services
kubectl get deployments
```


