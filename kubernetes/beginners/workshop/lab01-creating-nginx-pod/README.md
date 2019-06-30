# Lab #1: Creating Nginx Pod

```
kubectl create -f templates/pod.yaml
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

