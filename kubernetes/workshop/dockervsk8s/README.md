# Docker Swarm Vs Kubernetes CLI

# Example #1: Service Creation

## Docker Swarm

```
docker service create --name nginx --replicas 2 --publish 80:80 nginx
```

```
$ docker service create --name nginx --replicas 2 --publish 80:80 nginx
wohqu7qvj18dy7zjtmy12v2ib
overall progress: 2 out of 2 tasks 
1/2: running   
2/2: running   
verify: Service converged 
```

# Kubernetes

```
$kubectl run my-nginx --image=nginx --replicas=2 --port=80

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   8m28s
[node1 install]$ kubectl get po,svc
NAME                            READY   STATUS    RESTARTS   AGE
pod/my-nginx-86459cfc9f-b8zbz   1/1     Running   0          43s
pod/my-nginx-86459cfc9f-kztnt   1/1     Running   0          43s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   9m4s
```

Exposing the port

```
kubectl expose deployment my-nginx --port=80
```


# Example #2: 
