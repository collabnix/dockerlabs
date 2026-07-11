# Using Docker Swarm CLI to bring up Kubernetes Cluster

# Writing a Docker Compose File

```
Ajeets-MacBook-Air:testenviron ajeetraina$ cat docker-compose.yml 
version: '3.4'
services:
  web:
    image: nginx:alpine
    ports:
      - 8081:80
  db:
    image: nginx:alpine
 ```
    
  # Using Docker Stack deploy 
  
```
Ajeets-MacBook-Air:testenviron ajeetraina$ docker stack deploy -c docker-compse.yml kubestack
Stack kubestack was created
Waiting for the stack to be stable and running...
 - Service db has one container running
 - Service web has one container running
Stack kubestack is stable and running
```
  
# Verfying the Stack

```
Ajeets-MacBook-Air:testenviron ajeetraina$ docker stack ls
NAME                SERVICES
kubestack           2
```


# Detailed Information

```
Ajeets-MacBook-Air:testenviron ajeetraina$ docker stack services kubestack
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
36031213-fb3        db                  replicated          1/1                 nginx:alpine        
360ecf5b-fb3        web                 replicated          1/1                 nginx:alpine        *:8081->80/tcp
```

# Verifying using Kubectl

```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl get pods
NAME                       READY     STATUS    RESTARTS   AGE
db-6d45958ddf-8qtms        1/1       Running   0          12m
web-69bccb5f54-4lmxg       1/1       Running   0          12m
```

# Getting Kubectl Service Information

```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl get svc
NAME         TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
db           ClusterIP      None             <none>        55555/TCP        12m
kubernetes   ClusterIP      10.96.0.1        <none>        443/TCP          4d
web          LoadBalancer   10.100.242.160   <pending>     8081:32030/TCP   12m

```

# Describing the Deployment

```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl describe deployment
Name:                   db
Namespace:              default
CreationTimestamp:      Wed, 17 Jan 2018 09:10:49 +0530
Labels:                 com.docker.service.id=kubestack-db
                        com.docker.service.name=db
                        com.docker.stack.namespace=kubestack
Annotations:            deployment.kubernetes.io/revision=1
Selector:               com.docker.service.id=kubestack-db,com.docker.service.name=db,com.docker.stack.namespace=kubestack
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  com.docker.service.id=kubestack-db
           com.docker.service.name=db
           com.docker.stack.namespace=kubestack
  Containers:
   db:
    Image:        nginx:alpine
    Port:         <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   db-6d45958ddf (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  13m   deployment-controller  Scaled up replica set db-6d45958ddf to 1


Name:                   web
Namespace:              default
CreationTimestamp:      Wed, 17 Jan 2018 09:10:50 +0530
Labels:                 com.docker.service.id=kubestack-web
                        com.docker.service.name=web
                        com.docker.stack.namespace=kubestack
Annotations:            deployment.kubernetes.io/revision=1
Selector:               com.docker.service.id=kubestack-web,com.docker.service.name=web,com.docker.stack.namespace=kubestack
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  com.docker.service.id=kubestack-web
           com.docker.service.name=web
           com.docker.stack.namespace=kubestack
  Containers:
   web:
    Image:        nginx:alpine
    Port:         80/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   web-69bccb5f54 (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  13m   deployment-controller  Scaled up replica set web-69bccb5f54 to 1


Name:                   webdemo
Namespace:              default
CreationTimestamp:      Mon, 15 Jan 2018 12:17:13 +0530
Labels:                 run=webdemo
Annotations:            deployment.kubernetes.io/revision=1
Selector:               run=webdemo
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  1 max unavailable, 1 max surge
Pod Template:
  Labels:  run=webdemo
  Containers:
   webdemo:
    Image:        ajeetraina/webdemo
    Port:         8080/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
OldReplicaSets:  <none>
NewReplicaSet:   webdemo-85f56bc5d5 (1/1 replicas created)
Events:          <none>
```

```
Ajeets-MacBook-Air:testenviron ajeetraina$ curl localhost:8081
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
</body>
</html>
```
