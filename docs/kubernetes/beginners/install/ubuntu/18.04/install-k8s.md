# How to setup 3 Node Kubernetes Cluster on Bare Metal System using MetalLB?

## Preparing the Infrastructure

- Machine #1: 100.98.26.206
- Machine #2: 100.98.26.210
- Machine #3: 100.98.26.213

## Assign hostname to each of these systems:

```
~$ cat /etc/hosts
127.0.0.1       localhost
127.0.1.1       ubuntu1804-1
100.98.26.206    kubemaster.dell.com
100.98.26.210   node1.dell.com
100.98.26.213   node2.dell.com
```

## Installing curl package

```
$ sudo apt install curl
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following additional packages will be installed:
  libcurl4
The following NEW packages will be installed:
  curl libcurl4
0 upgraded, 2 newly installed, 0 to remove and 472 not upgraded.
Need to get 373 kB of archives.
After this operation, 1,036 kB of additional disk space will be used.
Do you want to continue? [Y/n] Y
Get:1 http://us.archive.ubuntu.com/ubuntu bionic-updates/main amd64 libcurl4 amd64 7.58.0-2ubuntu3.7 [214 kB]
Get:2 http://us.archive.ubuntu.com/ubuntu bionic-updates/main amd64 curl amd64 7.58.0-2ubuntu3.7 [159 kB]
Fetched 373 kB in 2s (164 kB/s)
Selecting previously unselected package libcurl4:amd64.
(Reading database ... 128791 files and directories currently installed.)
Preparing to unpack .../libcurl4_7.58.0-2ubuntu3.7_amd64.deb ...
Unpacking libcurl4:amd64 (7.58.0-2ubuntu3.7) ...
Selecting previously unselected package curl.
Preparing to unpack .../curl_7.58.0-2ubuntu3.7_amd64.deb ...
Unpacking curl (7.58.0-2ubuntu3.7) ...
Setting up libcurl4:amd64 (7.58.0-2ubuntu3.7) ...
Processing triggers for libc-bin (2.27-3ubuntu1) ...
Processing triggers for man-db (2.8.3-2) ...
Setting up curl (7.58.0-2ubuntu3.7) ...
```

## Installing Docker

```
$ sudo curl -sSL https://get.docker.com/ | sh
# Executing docker install script, commit: 2f4ae48
+ sudo -E sh -c apt-get update -qq >/dev/null
+ sudo -E sh -c apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
+ sudo -E sh -c curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add -qq - >/dev/null
Warning: apt-key output should not be parsed (stdout is not a terminal)
+ sudo -E sh -c echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list.d/docker.list
+ sudo -E sh -c apt-get update -qq >/dev/null
+ [ -n  ]
+ sudo -E sh -c apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
+ sudo -E sh -c docker version
Client:
 Version:           18.09.7
 API version:       1.39
 Go version:        go1.10.8
 Git commit:        2d0083d
 Built:             Thu Jun 27 17:56:23 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.7
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.8
  Git commit:       2d0083d
  Built:            Thu Jun 27 17:23:02 2019
  OS/Arch:          linux/amd64
  Experimental:     false
If you would like to use Docker as a non-root user, you should now consider
adding your user to the "docker" group with something like:

  sudo usermod -aG docker cse

Remember that you will have to log out and back in for this to take effect!

WARNING: Adding a user to the "docker" group will grant the ability to run
         containers which can be used to obtain root privileges on the
         docker host.
         Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
         for more information.
cse@kubemaster:~$
```

```
~$ sudo docker version
Client:
 Version:           18.09.7
 API version:       1.39
 Go version:        go1.10.8
 Git commit:        2d0083d
 Built:             Thu Jun 27 17:56:23 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.7
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.8
  Git commit:       2d0083d
  Built:            Thu Jun 27 17:23:02 2019
  OS/Arch:          linux/amd64
  Experimental:     false

```

## Add the Kubernetes signing key on both the nodes

```
$ sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
OK
```

## Adding Xenial Kubernetes Repository on both the nodes

```
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
```

## Installing Kubeadm


```
sudo apt update
```

```
sudo apt install kubeadm
```

## Verifying Kubeadm installation

```
$ sudo kubeadm version
kubeadm version: &version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.0", GitCommit:"e8462b5b5dc2584fdcd18e6bcfe9f1e4d970a529", GitTreeState:"clean", BuildDate:"2019-06-19T16:37:41Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}
```

## Disable swap memory (if running) on both the nodes

```
sudo swapoff -a
```


## Script to setup K8s Cluster

```
sudo kubeadm init --apiserver-advertise-address $(hostname -i)
mkdir -p $HOME/.kube
chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -n kube-system -f \
    "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 |tr -d '\n')"
``` 

## Adding Worker Node

```
cse@ubuntu1804-1:~$ sudo swapoff -a
cse@ubuntu1804-1:~$ sudo kubeadm join 100.98.26.210:6443 --token aju7kd.5mlhmmo1wlf8d5un     --discovery-token-ca-cert-hash sha256:89541bb9bbe5ee1efafe17b20eab77e6b756bd4ae023d2ff7c67ce73e3e8c7bb
[preflight] Running pre-flight checks
        [WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
[preflight] Reading configuration from the cluster...
[preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.15" ConfigMap in the kube-system namespace
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Activating the kubelet service
[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...

This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the control-plane to see this node join the cluster.

cse@ubuntu1804-1:~$
```

## Checking logs in case of any issue

```
journalctl -xeu kubelet
```

## Adding Pod Network

```
sudo kubectl apply -n kube-system -f     "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 |tr -d '\n')"

```

## Listing the Nodes

```
cse@kubemaster:~$ sudo kubectl get nodes
NAME               STATUS   ROLES    AGE     VERSION
kubemaster         Ready    master   8m17s   v1.15.0
worker1.dell.com   Ready    <none>   5m22s   v1.15.0
cse@kubemaster:~$
```

## 

```
cse@kubemaster:~$ sudo kubectl describe node worker1.dell.com
Name:               worker1.dell.com
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=worker1.dell.com
                    kubernetes.io/os=linux
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: /var/run/dockershim.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Fri, 05 Jul 2019 16:10:33 -0400
Taints:             <none>
Unschedulable:      false
Conditions:
  Type                 Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----                 ------  -----------------                 ------------------                ------                       -------
  NetworkUnavailable   False   Fri, 05 Jul 2019 16:10:55 -0400   Fri, 05 Jul 2019 16:10:55 -0400   WeaveIsUp                    Weave pod has set this
  MemoryPressure       False   Fri, 05 Jul 2019 16:15:33 -0400   Fri, 05 Jul 2019 16:10:33 -0400   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure         False   Fri, 05 Jul 2019 16:15:33 -0400   Fri, 05 Jul 2019 16:10:33 -0400   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure          False   Fri, 05 Jul 2019 16:15:33 -0400   Fri, 05 Jul 2019 16:10:33 -0400   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready                True    Fri, 05 Jul 2019 16:15:33 -0400   Fri, 05 Jul 2019 16:11:03 -0400   KubeletReady                 kubelet is posting ready status. AppArmor enabled
Addresses:
  InternalIP:  100.98.26.213
  Hostname:    worker1.dell.com
Capacity:
 cpu:                2
 ephemeral-storage:  102685624Ki
 hugepages-1Gi:      0
 hugepages-2Mi:      0
 memory:             4040016Ki
 pods:               110
Allocatable:
 cpu:                2
 ephemeral-storage:  94635070922
 hugepages-1Gi:      0
 hugepages-2Mi:      0
 memory:             3937616Ki
 pods:               110
System Info:
 Machine ID:                 e7573bb6bf1e4cf5b9249413950f0a3d
 System UUID:                2FD93F42-FA94-0C27-83A3-A1F9276469CF
 Boot ID:                    782d6cfc-08a2-4586-82b6-7149389b1f4f
 Kernel Version:             4.15.0-29-generic
 OS Image:                   Ubuntu 18.04.1 LTS
 Operating System:           linux
 Architecture:               amd64
 Container Runtime Version:  docker://18.9.7
 Kubelet Version:            v1.15.0
 Kube-Proxy Version:         v1.15.0
Non-terminated Pods:         (4 in total)
  Namespace                  Name                         CPU Requests  CPU Limits  Memory Requests  Memory Limits  AGE
  ---------                  ----                         ------------  ----------  ---------------  -------------  ---
  default                    my-nginx-68459bd9bb-55wk7    0 (0%)        0 (0%)      0 (0%)           0 (0%)         4m8s
  default                    my-nginx-68459bd9bb-z5r45    0 (0%)        0 (0%)      0 (0%)           0 (0%)         4m8s
  kube-system                kube-proxy-jt4bs             0 (0%)        0 (0%)      0 (0%)           0 (0%)         5m51s
  kube-system                weave-net-kw9gg              20m (1%)      0 (0%)      0 (0%)           0 (0%)         5m51s
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests  Limits
  --------           --------  ------
  cpu                20m (1%)  0 (0%)
  memory             0 (0%)    0 (0%)
  ephemeral-storage  0 (0%)    0 (0%)
Events:
  Type    Reason                   Age                    From                          Message
  ----    ------                   ----                   ----                          -------
  Normal  Starting                 5m51s                  kubelet, worker1.dell.com     Starting kubelet.
  Normal  NodeHasSufficientMemory  5m51s (x2 over 5m51s)  kubelet, worker1.dell.com     Node worker1.dell.com status is now: NodeHasSufficientMemory
  Normal  NodeHasNoDiskPressure    5m51s (x2 over 5m51s)  kubelet, worker1.dell.com     Node worker1.dell.com status is now: NodeHasNoDiskPressure
  Normal  NodeHasSufficientPID     5m51s (x2 over 5m51s)  kubelet, worker1.dell.com     Node worker1.dell.com status is now: NodeHasSufficientPID
  Normal  NodeAllocatableEnforced  5m51s                  kubelet, worker1.dell.com     Updated Node Allocatable limit across pods
  Normal  Starting                 5m48s                  kube-proxy, worker1.dell.com  Starting kube-proxy.
  Normal  NodeReady                5m21s                  kubelet, worker1.dell.com     Node worker1.dell.com status is now: NodeReady
cse@kubemaster:~$
```

```
$ sudo kubectl run nginx --image nginx
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
deployment.apps/nginx created
~$
```

## Configuring Metal LoadBalancer

```
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.7.3/manifests/metallb.yaml
```

## 

```
~$ sudo kubectl get ns
NAME              STATUS   AGE
default           Active   23h
kube-node-lease   Active   23h
kube-public       Active   23h
kube-system       Active   23h
metallb-system    Active   13m
```

```
$ kubectl get all -n metallb-system
NAME                              READY   STATUS    RESTARTS   AGE
pod/controller-547d466688-m9xlt   1/1     Running   0          13m
pod/speaker-tb9d7                 1/1     Running   0          13m



NAME                     DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/speaker   1         1         1       1            1           <none>          13m

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/controller   1/1     1            1           13m

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/controller-547d466688   1         1         1       13m
```

There are 2 components : 
- Controller - Assigns the IP address to the LB
- Speaker - Ensure that you can reach service through LB

Controller component is deployed as deplyment and speaker as daemonset which is running on all worker nodes

Next, we need to look at config files.

To configure MetalLB, write a config map to metallb-system/config

Link: https://metallb.universe.tf/configuration/

Layer 2 mode is the simplest to configure: in many cases, you don’t need any protocol-specific configuration, only IP addresses.

```
 sudo kubectl get nodes -o wide
NAME               STATUS   ROLES    AGE   VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
kubemaster         Ready    master   23h   v1.15.0   100.98.26.210   <none>        Ubuntu 18.04.1 LTS   4.15.0-29-generic   docker://18.9.7
worker1.dell.com   Ready    <none>   23h   v1.15.0   100.98.26.213   <none>        Ubuntu 18.04.1 LTS   4.15.0-29-generic   docker://18.9.7

```
We need to pay attention to the above Internal IP. We need to use this range only.

```
$ sudo cat <<EOF | kubectl create -f -
> apiVersion: v1
> kind: ConfigMap
> metadata:
>   namespace: metallb-system
>   name: config
> data:
>   config: |
>     address-pools:
>     - name: default
>       protocol: layer2
>       addresses:
>       - 100.98.26.200-100.98.26.255
>
> EOF
configmap/config created
```

```
cse@kubemaster:~$ kubectl describe configmap config -n metallb-system
Name:         config
Namespace:    metallb-system
Labels:       <none>
Annotations:  <none>

Data
====
config:
----
address-pools:
- name: default
  protocol: layer2
  addresses:
  - 100.98.26.200-100.98.26.255

Events:  <none>
```


```
kubectl get all
```


```
$ kubectl expose deploy nginx --port 80 --type LoadBalancer
service/nginx exposed

```

```
Every 2.0s: kubectl get all             kubemaster: Sat Jul  6 15:33:30 2019

NAME                         READY   STATUS    RESTARTS   AGE
pod/nginx-7bb7cd8db5-rc8c4   1/1     Running   0          18m


NAME                 TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)
        AGE
service/kubernetes   ClusterIP      10.96.0.1        <none>          443/TCP
        23h
service/nginx        LoadBalancer   10.105.157.210   100.98.26.200   80:3063
1/TCP   34s


NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx   1/1     1            1           18m

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-7bb7cd8db5   1         1         1       18m


```


By now, you should be able to browser NGINX Page under http://100.98.26.210

Hurray !!!

Let's run another nginx service:

```
~$ kubectl run nginx2 --image nginx
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
deployment.apps/nginx2 created
```

```
Every 2.0s: kubectl get all             kubemaster: Sat Jul  6 15:37:21 2019

NAME                          READY   STATUS    RESTARTS   AGE
pod/nginx-7bb7cd8db5-rc8c4    1/1     Running   0          21m
pod/nginx2-5746fc444c-4tsls   1/1     Running   0          42s


NAME                 TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)
        AGE
service/kubernetes   ClusterIP      10.96.0.1        <none>          443/TCP
        23h
service/nginx        LoadBalancer   10.105.157.210   100.98.26.200   80:3063
1/TCP   4m24s


NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx    1/1     1            1           21m
deployment.apps/nginx2   1/1     1            1           42s

NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-7bb7cd8db5    1         1         1       21m
replicaset.apps/nginx2-5746fc444c   1         1         1       42s
```

```
cse@kubemaster:~$ kubectl expose deploy  nginx2 --port 80 --type LoadBalancer
service/nginx2 exposed
cse@kubemaster:~$
```

```
Every 2.0s: kubectl get all             kubemaster: Sat Jul  6 15:38:49 2019

NAME                          READY   STATUS    RESTARTS   AGE
pod/nginx-7bb7cd8db5-rc8c4    1/1     Running   0          23m
pod/nginx2-5746fc444c-4tsls   1/1     Running   0          2m10s


NAME                 TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)
        AGE
service/kubernetes   ClusterIP      10.96.0.1        <none>          443/TCP
        23h
service/nginx        LoadBalancer   10.105.157.210   100.98.26.200   80:3063
1/TCP   5m52s
service/nginx2       LoadBalancer   10.107.32.195    100.98.26.201   80:3139
0/TCP   15s


NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx    1/1     1            1           23m
deployment.apps/nginx2   1/1     1            1           2m10s

NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-7bb7cd8db5    1         1         1       23m
replicaset.apps/nginx2-5746fc444c   1         1         1       2m10s
```

Let's run hellowhale example

```
cse@kubemaster:~$ sudo kubectl run hellowhale --image ajeetraina/hellowhale
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
deployment.apps/hellowhale created
cse@kubemaster:~$
```

```
cse@kubemaster:~$ sudo kubectl expose deploy hellowhale --port 89 --type LoadBalancer
service/hellowhale exposed
cse@kubemaster:~$
```


```
cse@kubemaster:~$ sudo kubectl get all
NAME                              READY   STATUS    RESTARTS   AGE
pod/hellowhale-64ff675cb5-c95qf   1/1     Running   0          99s
pod/nginx-7bb7cd8db5-rc8c4        1/1     Running   0          2d9h
pod/nginx2-5746fc444c-4tsls       1/1     Running   0          2d8h


NAME                 TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)        AGE
service/hellowhale   LoadBalancer   10.100.239.246   100.98.26.203   89:30385/TCP   29s
service/kubernetes   ClusterIP      10.96.0.1        <none>          443/TCP        3d8h
service/nginx        LoadBalancer   10.105.157.210   100.98.26.200   80:30631/TCP   2d8h
service/nginx2       LoadBalancer   10.107.32.195    100.98.26.201   80:31390/TCP   2d8h


NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/hellowhale   1/1     1            1           99s
deployment.apps/nginx        1/1     1            1           2d9h
deployment.apps/nginx2       1/1     1            1           2d8h

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/hellowhale-64ff675cb5   1         1         1       99s
replicaset.apps/nginx-7bb7cd8db5        1         1         1       2d9h
replicaset.apps/nginx2-5746fc444c       1         1         1       2d8h
```

