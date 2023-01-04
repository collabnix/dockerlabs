
# Deploying a Sample Nginx-based HelloWhale App on Kubernetes

## Pre-requisite:

- Docker Desktop
- Enable Kubernetes under Docker Desktop

## Getting Started


```
kubectl create deployment hellowhale --image ajeetraina/hellowhale
deployment "hellowhale" created
```

## Listing the Deployment


```
kubectl get deploy
```

## Result:

```
NAME         DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
hellowhale   1         1         1            1           10s
```


```
kubectl get nodes
NAME             STATUS   ROLES           AGE   VERSION
docker-desktop   Ready    control-plane   15h   v1.25.2
```

```
ajeetraina@Docker-Ajeet-Singh-Rainas-MacBook-Pro ddextension % kubectl get po   
NAME                          READY   STATUS    RESTARTS      AGE
hellowhale-66b5557c4c-k8zts   1/1     Running   2 (29m ago)   14h
```

```
ajeetraina@Docker-Ajeet-Singh-Rainas-MacBook-Pro ddextension % kubectl get po,svc,deploy
NAME                              READY   STATUS    RESTARTS      AGE
pod/hellowhale-66b5557c4c-k8zts   1/1     Running   2 (29m ago)   14h

NAME                    TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/hellowhalesvc   LoadBalancer   10.104.95.130   localhost     80:31424/TCP   14h
service/kubernetes      ClusterIP      10.96.0.1       <none>        443/TCP        14h

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/hellowhale   1/1     1            1           14h
ajeetraina@Docker-Ajeet-Singh-Rainas-MacBook-Pro ddextension % 
```

Open https://localhost:80 to access Hello Whale Sample app.


<img width="736" alt="image" src="https://user-images.githubusercontent.com/313480/210483625-289f4127-98f3-4fca-8bba-79f82f370d71.png">

