# Lab-#1: Demonstrating a Single Node Nginx CLuster

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/cn/docs/user-guide/nginx-app.yaml
```

```
[node1 ~]$ kubectl get po
NAME                        READY     STATUS    RESTARTS   AGEmy-nginx-569477d6d8-2872c   1/1       Running   0          20m
my-nginx-569477d6d8-njqtg   1/1       Running   0          20mmy-nginx-569477d6d8-r7szv   1/1       Running   0          20m
```

```
[node1 ~]$ kubectl get svcNAME           TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
kubernetes     ClusterIP      10.96.0.1        <none>        443/TCP        28mmy-nginx-svc   LoadBalancer   10.101.230.179   <pending>     80:30480/TCP   20m
[node1 ~]$
```

You will see port appeared on the top of the screen, click on it and you have NGINX page displayed.
