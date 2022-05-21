# Getting Started with Kubernetes on Docker for Mac 17.12

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



# Kubernetes powered Docker for Mac 17.12 CE Edition

## How ```docker stack deploy``` manage to deploy to K8s? Does it convert docker-compose files to k8s manifests (something like kompose) before deployment ?

It’s a custom apiserver that is in charge of keeping your stack up and running. Basically converting services to k8s objets and maintaining them (if you remove a deployment of a stack, the compose controller will recreate it)

One can do kubectl get stacks for instance and scale it by hand.

## How you add things to K8s API?

The Kubernetes API server validates and configures data for the api objects which include pods, services, replicationcontrollers, and others. The API Server services REST operations and provides the frontend to the cluster’s shared state through which all other components interact.

Docker use api aggregation. In Kubernetes, you can add new things to the api with this mechanism.
https://kubernetes.io/docs/concepts/api-extension/apiserver-aggregation/

## What happens behind the scene while you run ```docker stack deploy```?

Docker introduced a new type : Stack, under compose.docker.com. This object, that you can create with kubectl or more easily with docker stack deploy, contains the compose file.

Behind the scene, a controller watches for stacks and create/update corresponding kubernetes objets (deployments, services, etc).
The job of the controller is to reconcile the stacks (stored in the api-server or crd) with k8s native object

kubectl has a discovery mechanism, nothing more. You can list all apis available with `kubectl api-versions`
[Learn more](https://github.com/docker/cli/blob/master/kubernetes/compose/v1beta1/stack_types.go#L24)





Basic Commands:

```
# Describe a node
  kubectl describe nodes kubernetes-node-emt8.c.myproject.internal
  
  # Describe a pod
  kubectl describe pods/nginx
  
  # Describe a pod identified by type and name in "pod.json"
  kubectl describe -f pod.json
  
  # Describe all pods
  kubectl describe pods
  
  # Describe pods by label name=myLabel
  kubectl describe po -l name=myLabel
  
  # Describe all pods managed by the 'frontend' replication controller (rc-created pods
  # get the name of the rc as a prefix in the pod the name).
  kubectl describe pods frontend
```

# Describing a D4M Node:

```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl describe nodes docker-for-desktop
Name:               docker-for-desktop
Roles:              master
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/hostname=docker-for-desktop
                    node-role.kubernetes.io/master=
Annotations:        node.alpha.kubernetes.io/ttl=0
                    volumes.kubernetes.io/controller-managed-attach-detach=true
Taints:             <none>
CreationTimestamp:  Sat, 13 Jan 2018 07:12:08 +0530
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----             ------  -----------------                 ------------------                ------                       -------
  OutOfDisk        False   Mon, 15 Jan 2018 08:20:12 +0530   Sat, 13 Jan 2018 07:12:08 +0530   KubeletHasSufficientDisk     kubelet has sufficient disk space available
  MemoryPressure   False   Mon, 15 Jan 2018 08:20:12 +0530   Mon, 15 Jan 2018 07:50:48 +0530   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure     False   Mon, 15 Jan 2018 08:20:12 +0530   Mon, 15 Jan 2018 07:50:48 +0530   KubeletHasNoDiskPressure     kubelet has no disk pressure
  Ready            True    Mon, 15 Jan 2018 08:20:12 +0530   Mon, 15 Jan 2018 07:50:48 +0530   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  192.168.65.3
  Hostname:    docker-for-desktop
Capacity:
 cpu:     2
 memory:  2046984Ki
 pods:    110
Allocatable:
 cpu:     2
 memory:  1944584Ki
 pods:    110
System Info:
 Machine ID:                 
 System UUID:                E83A78DE-CE12-313C-ABA7-B12622C3B8FD
 Boot ID:                    e8082259-a5e6-47f6-b5f4-9a01981cad6f
 Kernel Version:             4.9.60-linuxkit-aufs
 OS Image:                   Docker for Mac
 Operating System:           linux
 Architecture:               amd64
 Container Runtime Version:  docker://17.12.0-ce
 Kubelet Version:            v1.8.2
 Kube-Proxy Version:         v1.8.2
ExternalID:                  docker-for-desktop
Non-terminated Pods:         (14 in total)
  Namespace                  Name                                          CPU Requests  CPU Limits  Memory Requests  Memory Limits
  ---------                  ----                                          ------------  ----------  ---------------  -------------
  default                    hello-world-85f98cf8c9-gplbf                  0 (0%)        0 (0%)      0 (0%)           0 (0%)
  default                    hello-world-85f98cf8c9-qgbs2                  0 (0%)        0 (0%)      0 (0%)           0 (0%)
  default                    my-nginx-6994b857d7-88kv8                     0 (0%)        0 (0%)      0 (0%)           0 (0%)
  default                    my-nginx-6994b857d7-vlhjl                     0 (0%)        0 (0%)      0 (0%)           0 (0%)
  default                    nginx-7cbc4b4d9c-rjk5d                        0 (0%)        0 (0%)      0 (0%)           0 (0%)
  default                    ournginx-574975f64-p52w6                      0 (0%)        0 (0%)      0 (0%)           0 (0%)
  default                    ournginx-574975f64-sp2c4                      0 (0%)        0 (0%)      0 (0%)           0 (0%)
  docker                     compose-75f8bb4779-jhkgh                      0 (0%)        0 (0%)      0 (0%)           0 (0%)
  kube-system                etcd-docker-for-desktop                       0 (0%)        0 (0%)      0 (0%)           0 (0%)
  kube-system                kube-apiserver-docker-for-desktop             250m (12%)    0 (0%)      0 (0%)           0 (0%)
  kube-system                kube-controller-manager-docker-for-desktop    200m (10%)    0 (0%)      0 (0%)           0 (0%)
  kube-system                kube-dns-545bc4bfd4-s2wql                     260m (13%)    0 (0%)      110Mi (5%)       170Mi (8%)
  kube-system                kube-proxy-7g4kg                              0 (0%)        0 (0%)      0 (0%)           0 (0%)
  kube-system                kube-scheduler-docker-for-desktop             100m (5%)     0 (0%)      0 (0%)           0 (0%)
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  CPU Requests  CPU Limits  Memory Requests  Memory Limits
  ------------  ----------  ---------------  -------------
  810m (40%)    0 (0%)      110Mi (5%)       170Mi (8%)
Events:
  Type    Reason                   Age                From                         Message
  ----    ------                   ----               ----                         -------
  Normal  NodeHasSufficientMemory  29m (x31 over 1h)  kubelet, docker-for-desktop  Node docker-for-desktop status is now: NodeHasSufficientMemory
  Normal  NodeHasNoDiskPressure    29m (x31 over 1h)  kubelet, docker-for-desktop  Node docker-for-desktop status is now: NodeHasNoDiskPressure
  Normal  NodeReady                29m                kubelet, docker-for-desktop  Node docker-for-desktop status is now: NodeReady
```
