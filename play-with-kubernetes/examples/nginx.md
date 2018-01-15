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
hello-world-85f98cf8c9-gplbf   1/1       Running             0          19h
hello-world-85f98cf8c9-qgbs2   1/1       Running             0          19h
my-nginx-6994b857d7-88kv8      0/1       ContainerCreating   0          7s
my-nginx-6994b857d7-vlhjl      0/1       ContainerCreating   0          7s
nginx-7cbc4b4d9c-rjk5d         1/1       Running             0          19h
```


Once the pods are created, you can list them to see what is up and running:

```
kubectl get pods
```

You can also see the deployment that was created:

```
kubectl get deployment
```
