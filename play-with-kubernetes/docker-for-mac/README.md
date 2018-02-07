# Kubernetes powered Docker for Mac 17.12 CE Edition

## How ```docker stack deploy``` manage to deploy to K8s? Does it convert docker-compose files to k8s manifests (something like kompose) before deployment ?

It’s a custom apiserver that is in charge of keeping your stack up and running. Basically converting services to k8s objets and maintaining them (if you remove a deployment of a stack, the compose controller will recreate it)

One can do kubectl get stacks for instance and scale it by hand.

## How you add things to K8s API?

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
