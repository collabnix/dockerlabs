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
