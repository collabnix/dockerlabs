# Getting Started with Kubernetes

## Pre-requisites

- Docker for Mac 17.12 Edge Release

## Hello World Example

Running a Hello World application in your cluster:


```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl run hello-world --replicas=2 --labels="run=load-balancer-example" --image=gcr.io/google-samples/node-hello:1.0  --port=8080
deployment "hello-world" created
```

Verifying the Pods:

```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl get pods
NAME                           READY     STATUS              RESTARTS   AGE
hello-world-85f98cf8c9-gplbf   0/1       ContainerCreating   0          20s
hello-world-85f98cf8c9-qgbs2   0/1       ContainerCreating   0          20s
nginx-7cbc4b4d9c-rjk5d         1/1       Running
```

The preceding command creates a Deployment object and an associated ReplicaSet object. 
The ReplicaSet has two Pods, each of which runs the Hello World application.

# Display information about the Deployment:

```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl get deployments hello-world
NAME          DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
hello-world   2         2         2            2           19m
Ajeets-MacBook-Air:~ ajeetraina$ 

```

# Display information about your ReplicaSet objects:


```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl get replicasets
NAME                     DESIRED   CURRENT   READY     AGE
hello-world-85f98cf8c9   2         2         2         20m
nginx-7cbc4b4d9c         1         1         1         47m
Ajeets-MacBook-Air:~ ajeetraina$ 
```

```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl describe replicasets
Name:           hello-world-85f98cf8c9
Namespace:      default
Selector:       pod-template-hash=4195479475,run=load-balancer-example
Labels:         pod-template-hash=4195479475
                run=load-balancer-example
Annotations:    deployment.kubernetes.io/desired-replicas=2
                deployment.kubernetes.io/max-replicas=3
                deployment.kubernetes.io/revision=1
Controlled By:  Deployment/hello-world
Replicas:       2 current / 2 desired
Pods Status:    2 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  pod-template-hash=4195479475
           run=load-balancer-example
  Containers:
   hello-world:
    Image:        gcr.io/google-samples/node-hello:1.0
    Port:         8080/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age   From                   Message
  ----    ------            ----  ----                   -------
  Normal  SuccessfulCreate  20m   replicaset-controller  Created pod: hello-world-85f98cf8c9-qgbs2
  Normal  SuccessfulCreate  20m   replicaset-controller  Created pod: hello-world-85f98cf8c9-gplbf


Name:           nginx-7cbc4b4d9c
Namespace:      default
Selector:       pod-template-hash=3767060857,run=nginx
Labels:         pod-template-hash=3767060857
                run=nginx
Annotations:    deployment.kubernetes.io/desired-replicas=1
                deployment.kubernetes.io/max-replicas=2
                deployment.kubernetes.io/revision=1
Controlled By:  Deployment/nginx
Replicas:       1 current / 1 desired
Pods Status:    1 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  pod-template-hash=3767060857
           run=nginx
  Containers:
   nginx:
    Image:        nginx
    Port:         80/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age   From                   Message
  ----    ------            ----  ----                   -------
  Normal  SuccessfulCreate  48m   replicaset-controller  Created pod: nginx-7cbc4b4d9c-rjk5d

```

# Create a Service object that exposes the deployment:




```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl expose deployment hello-world --type=NodePort --name=example-service
service "example-service" exposed
Ajeets-MacBook-Air:~ ajeetraina$ kubectl get deployment
NAME          DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
hello-world   2         2         2            0           1m
nginx         1         1         1            1           29m
```

# Display information about the Service:

```
kubectl describe services example-service
```

```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl describe services example-service
Name:                     example-service
Namespace:                default
Labels:                   run=load-balancer-example
Annotations:              <none>
Selector:                 run=load-balancer-example
Type:                     NodePort
IP:                       10.106.252.68
Port:                     <unset>  8080/TCP
TargetPort:               8080/TCP
NodePort:                 <unset>  31477/TCP
Endpoints:                10.1.0.10:8080,10.1.0.9:8080
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
```

Make a note of the NodePort value for the service. For example, in the preceding output, the NodePort value is 31496.

# List the pods that are running the Hello World application:

```
kubectl get pods --selector="run=load-balancer-example" --output=wide
```

```
kubectl get pods --selector="run=load-balancer-example" --output=wide
NAME                           READY     STATUS    RESTARTS   AGE       IP          NODE
hello-world-85f98cf8c9-gplbf   1/1       Running   0          24m       10.1.0.10   docker-for-desktop
hello-world-85f98cf8c9-qgbs2   1/1   
```
# Verify it on Web Browser

```
Ajeets-MacBook-Air:~ ajeetraina$ curl http://localhost:31477
Hello Kubernetes!
```
