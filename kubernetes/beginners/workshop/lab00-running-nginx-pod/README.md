# Running Nginx pod

## Creating 2 NGINX Pods

The kubectl run line below will create two nginx pods listening on port 80. It will also create a deployment named my-nginx to ensure that there are always two pods running.

```
[node1 lab01-creating-nginx-pod]$ kubectl run my-nginx --image=nginx --replicas=2 --port=80
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
deployment.apps/my-nginx created
```

```
[node1 lab01-creating-nginx-pod]$ kubectl get po,svc,deploy
NAME                          READY   STATUS    RESTARTS   AGE
pod/my-nginx-7b64f649-258lb   1/1     Running   0          15s
pod/my-nginx-7b64f649-8zcdr   1/1     Running   0          15s


NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   25m

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.extensions/my-nginx   2/2     2            2           15s
```

```
[node1 lab01-creating-nginx-pod]$ kubectl get pods -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP          NODE    NOMINATED NODE   READINESS GATES
my-nginx-7b64f649-258lb   1/1     Running   0          30s   10.44.0.1   node2   <none>   <none>
my-nginx-7b64f649-8zcdr   1/1     Running   0          30s   10.44.0.2   node2   <none>
```



```
node1 lab01-creating-nginx-pod]$
[node1 lab01-creating-nginx-pod]$ kubectl get deployment -o wide
NAME       READY   UP-TO-DATE   AVAILABLE   AGE    CONTAINERS   IMAGES   SELECTOR
my-nginx   2/2     2            2           2m9s   my-nginx     nginx    run=my-nginx
```

# Exposing the Service so as to browse the Nginx over URL

```
[node1 lab01-creating-nginx-pod]$ kubectl expose deployment my-nginx --port=80
service/my-nginx exposed
```


```
[node1 lab01-creating-nginx-pod]$ kubectl get pods,svc -o wide
NAME                          READY   STATUS    RESTARTS   AGE     IP          NODE    NOMINATED NODE   READINESS GATES
pod/my-nginx-7b64f649-258lb   1/1     Running   0          4m17s   10.44.0.1   node2   <none>         <none>
pod/my-nginx-7b64f649-8zcdr   1/1     Running   0          4m17s   10.44.0.2   node2   <none>         <none>

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE   SELECTOR
service/kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP   29m   <none>
service/my-nginx     ClusterIP   10.106.231.19   <none>        80/TCP    21s   run=my-nginx
```

```
[node1 lab01-creating-nginx-pod]$ curl 10.106.231.19:80
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
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

## Accessing it through localhost

```
IP=$(kubectl get svc my-nginx -o go-template --template '{{ .spec.clusterIP }}')
```

```
curl $IP:80
```


## Cleaning Up

```
my-nginx   2/2     2            2           14m
[node1 lab01-creating-nginx-pod]$ kubectl delete deploy my-nginx
deployment.extensions "my-nginx" deleted

```
