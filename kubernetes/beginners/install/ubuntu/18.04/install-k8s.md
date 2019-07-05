# How to setup 3 Node Kubernetes Cluster on VMware vSphere ESXi VMs?

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

```
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.98.26.206

```

Troubleshooting Steps:

In case you want to reset the last command, you need to do it cleanly via the below steps:

```
sudo kubeadm reset
```

```
sudo systemctl restart kubectl
```

If still issue occurs, you can uninstall kubelet and kubeadm both.

```
rm -fr /opt/containerd
```

```
~$ mkdir -p $HOME/.kube
~$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

```
cse@ubuntu1804-1:~$ sudo hostname kubemaster
```

```
$ sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
podsecuritypolicy.extensions/psp.flannel.unprivileged created
clusterrole.rbac.authorization.k8s.io/flannel created
clusterrolebinding.rbac.authorization.k8s.io/flannel created
serviceaccount/flannel created
configmap/kube-flannel-cfg created
daemonset.extensions/kube-flannel-ds-amd64 created
daemonset.extensions/kube-flannel-ds-arm64 created
daemonset.extensions/kube-flannel-ds-arm created
daemonset.extensions/kube-flannel-ds-ppc64le created
daemonset.extensions/kube-flannel-ds-s390x created
```

```
cse@ubuntu1804-1:~$ sudo kubectl get nodes
NAME           STATUS     ROLES    AGE     VERSION
ubuntu1804-1   NotReady   master   2m18s   v1.15.0
cse@ubuntu1804-1:~$
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
## Listing the Nodes

```

cse@kubemaster:~$ sudo kubectl get nodes
NAME         STATUS     ROLES    AGE     VERSION
kubemaster   NotReady   master   3m14s   v1.15.0
```

```
cse@kubemaster:~$ sudo kubectl get nodes
NAME         STATUS     ROLES    AGE     VERSION
kubemaster   NotReady   master   3m15s   v1.15.0
```
## Checking the detailed information


```
cse@kubemaster:~$ sudo kubectl describe nodes kubemaster
Name:               kubemaster
Roles:              master
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=kubemaster
                    kubernetes.io/os=linux
                    node-role.kubernetes.io/master=
Annotations:        flannel.alpha.coreos.com/backend-data: {"VtepMAC":"ba:7e:74:34:96:55"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 100.98.26.210
                    kubeadm.alpha.kubernetes.io/cri-socket: /var/run/dockershim.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Fri, 05 Jul 2019 04:42:37 -0400
Taints:             node.kubernetes.io/not-ready:NoExecute
                    node-role.kubernetes.io/master:NoSchedule
                    node.kubernetes.io/not-ready:NoSchedule
Unschedulable:      false
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----             ------  -----------------                 ------------------                ------                       -------
  MemoryPressure   False   Fri, 05 Jul 2019 04:52:38 -0400   Fri, 05 Jul 2019 04:42:37 -0400   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure     False   Fri, 05 Jul 2019 04:52:38 -0400   Fri, 05 Jul 2019 04:42:37 -0400   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Fri, 05 Jul 2019 04:52:38 -0400   Fri, 05 Jul 2019 04:42:37 -0400   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            False   Fri, 05 Jul 2019 04:52:38 -0400   Fri, 05 Jul 2019 04:42:37 -0400   KubeletNotReady              runtime network not ready: NetworkReady=false reason:NetworkPluginNotReady message:docker: network plugin is not ready: cni config uninitialized
Addresses:
  InternalIP:  100.98.26.210
  Hostname:    kubemaster
Capacity:
 cpu:                2
 ephemeral-storage:  102685624Ki
 hugepages-1Gi:      0
 hugepages-2Mi:      0
 memory:             4040008Ki
 pods:               110
Allocatable:
 cpu:                2
 ephemeral-storage:  94635070922
 hugepages-1Gi:      0
 hugepages-2Mi:      0
 memory:             3937608Ki
 pods:               110
System Info:
 Machine ID:                 e7573bb6bf1e4cf5b9249413950f0a3d
 System UUID:                CB5C3F42-D2C6-D024-42E8-FA7AB2243C53
 Boot ID:                    f508be44-f306-4d2e-82c0-de559c51dba2
 Kernel Version:             4.15.0-29-generic
 OS Image:                   Ubuntu 18.04.1 LTS
 Operating System:           linux
 Architecture:               amd64
 Container Runtime Version:  docker://18.9.7
 Kubelet Version:            v1.15.0
 Kube-Proxy Version:         v1.15.0
PodCIDR:                     100.98.0.0/24
Non-terminated Pods:         (6 in total)
  Namespace                  Name                                  CPU Requests  CPU Limits  Memory Requests  Memory Limits  AGE
  ---------                  ----                                  ------------  ----------  ---------------  -------------  ---
  kube-system                etcd-kubemaster                       0 (0%)        0 (0%)      0 (0%)           0 (0%)         9m31s
  kube-system                kube-apiserver-kubemaster             250m (12%)    0 (0%)      0 (0%)           0 (0%)         9m32s
  kube-system                kube-controller-manager-kubemaster    200m (10%)    0 (0%)      0 (0%)           0 (0%)         9m39s
  kube-system                kube-flannel-ds-amd64-5vplk           100m (5%)     100m (5%)   50Mi (1%)        50Mi (1%)      10s
  kube-system                kube-proxy-f6xp7                      0 (0%)        0 (0%)      0 (0%)           0 (0%)         10m
  kube-system                kube-scheduler-kubemaster             100m (5%)     0 (0%)      0 (0%)           0 (0%)         9m45s
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests    Limits
  --------           --------    ------
  cpu                650m (32%)  100m (5%)
  memory             50Mi (1%)   50Mi (1%)
  ephemeral-storage  0 (0%)      0 (0%)
Events:
  Type    Reason                   Age                From                    Message
  ----    ------                   ----               ----                    -------
  Normal  Starting                 11m                kubelet, kubemaster     Starting kubelet.
  Normal  NodeHasSufficientMemory  11m (x8 over 11m)  kubelet, kubemaster     Node kubemaster status is now: NodeHasSufficientMemory
  Normal  NodeHasNoDiskPressure    11m (x8 over 11m)  kubelet, kubemaster     Node kubemaster status is now: NodeHasNoDiskPressure
  Normal  NodeHasSufficientPID     11m (x7 over 11m)  kubelet, kubemaster     Node kubemaster status is now: NodeHasSufficientPID
  Normal  NodeAllocatableEnforced  11m                kubelet, kubemaster     Updated Node Allocatable limit across pods
  Normal  Starting                 10m                kube-proxy, kubemaster  Starting kube-proxy.
```

```
cse@kubemaster:~$ sudo kubectl get nodes
NAME         STATUS   ROLES    AGE   VERSION
kubemaster   Ready    master   10m   v1.15.0
cse@kubemaster:~$
```

```
root@ubuntu1804-1:~# kubeadm reset
[reset] WARNING: Changes made to this host by 'kubeadm init' or 'kubeadm join' will be reverted.
[reset] Are you sure you want to proceed? [y/N]: y
[preflight] Running pre-flight checks
[reset] WARNING: Changes made to this host by 'kubeadm init' or 'kubeadm join' will be reverted.
[reset] Are you sure you want to proceed? [y/N]: y
[preflight] Running pre-flight checks
[reset] Stopping the kubelet service
[reset] Unmounting mounted directories in "/var/lib/kubelet"
[reset] Deleting contents of config directories: [/etc/kubernetes/manifests /etc/kubernetes/pki]
[reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/scheduler.conf]
[reset] Deleting contents of stateful directories: [/var/lib/kubelet /etc/cni/net.d /var/lib/dockershim /var/run/kubernetes]

The reset process does not reset or clean up iptables rules or IPVS tables.
If you wish to reset iptables, you must do so manually.
For example:
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X

If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
to reset your system's IPVS tables.

The reset process does not clean your kubeconfig files and you must remove them manually.
Please, check the contents of the $HOME/.kube/config file.
root@ubuntu1804-1:~# kubeadm join 100.98.26.210:6443 --token 3m8abj.6fk8mszif58hsx6o     --discovery-token-ca-cert-hash sha256:42ebcc9b7a52f004698cbb37ce0f1baa474dab93945ded4baf66026361c2e8da
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

root@ubuntu1804-1:~#
```

```
root@ubuntu1804-1:~# kubeadm reset
[reset] WARNING: Changes made to this host by 'kubeadm init' or 'kubeadm join' will be reverted.
[reset] Are you sure you want to proceed? [y/N]: y
[preflight] Running pre-flight checks
[reset] WARNING: Changes made to this host by 'kubeadm init' or 'kubeadm join' will be reverted.
[reset] Are you sure you want to proceed? [y/N]: y
[preflight] Running pre-flight checks
[reset] Stopping the kubelet service
[reset] Unmounting mounted directories in "/var/lib/kubelet"
[reset] Deleting contents of config directories: [/etc/kubernetes/manifests /etc/kubernetes/pki]
[reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/scheduler.conf]
[reset] Deleting contents of stateful directories: [/var/lib/kubelet /etc/cni/net.d /var/lib/dockershim /var/run/kubernetes]

The reset process does not reset or clean up iptables rules or IPVS tables.
If you wish to reset iptables, you must do so manually.
For example:
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X

If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
to reset your system's IPVS tables.

The reset process does not clean your kubeconfig files and you must remove them manually.
Please, check the contents of the $HOME/.kube/config file.
```

```
root@ubuntu1804-1:~# kubeadm join 100.98.26.210:6443 --token 3m8abj.6fk8mszif58hsx6o     --discovery-token-ca-cert-hash sha256:42ebcc9b7a52f004698cbb37ce0f1baa474dab93945ded4baf66026361c2e8da
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

root@ubuntu1804-1:~#
```

```
cse@kubemaster:~$ sudo kubectl get nodes
NAME               STATUS   ROLES    AGE   VERSION
kubemaster         Ready    master   18m   v1.15.0
worker1.dell.com   Ready    <none>   14s   v1.15.0
cse@kubemaster:~$

```

```
cse@kubemaster:~$ sudo kubectl get nodes
NAME               STATUS   ROLES    AGE   VERSION
kubemaster         Ready    master   11h   v1.15.0
worker1.dell.com   Ready    <none>   10h   v1.15.0
cse@kubemaster:~$ sudo kubectl describe nodes
Name:               kubemaster
Roles:              master
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=kubemaster
                    kubernetes.io/os=linux
                    node-role.kubernetes.io/master=
Annotations:        flannel.alpha.coreos.com/backend-data: {"VtepMAC":"ba:7e:74:                                                                             34:96:55"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 100.98.26.210
                    kubeadm.alpha.kubernetes.io/cri-socket: /var/run/dockershim.                                                                             sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Fri, 05 Jul 2019 04:42:37 -0400
Taints:             node-role.kubernetes.io/master:NoSchedule
Unschedulable:      false
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                                                                                             Reason                       Message
  ----             ------  -----------------                 ------------------                                                                                             ------                       -------
  MemoryPressure   False   Fri, 05 Jul 2019 15:46:46 -0400   Fri, 05 Jul 2019 04                                                                             :42:37 -0400   KubeletHasSufficientMemory   kubelet has sufficient memory availa                                                                             ble
  DiskPressure     False   Fri, 05 Jul 2019 15:46:46 -0400   Fri, 05 Jul 2019 04                                                                             :42:37 -0400   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Fri, 05 Jul 2019 15:46:46 -0400   Fri, 05 Jul 2019 04                                                                             :42:37 -0400   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            True    Fri, 05 Jul 2019 15:46:46 -0400   Fri, 05 Jul 2019 04                                                                             :53:28 -0400   KubeletReady                 kubelet is posting ready status. App                                                                             Armor enabled
Addresses:
  InternalIP:  100.98.26.210
  Hostname:    kubemaster
Capacity:
 cpu:                2
 ephemeral-storage:  102685624Ki
 hugepages-1Gi:      0
 hugepages-2Mi:      0
 memory:             4040008Ki
 pods:               110
Allocatable:
 cpu:                2
 ephemeral-storage:  94635070922
 hugepages-1Gi:      0
 hugepages-2Mi:      0
 memory:             3937608Ki
 pods:               110
System Info:
 Machine ID:                 e7573bb6bf1e4cf5b9249413950f0a3d
 System UUID:                CB5C3F42-D2C6-D024-42E8-FA7AB2243C53
 Boot ID:                    f508be44-f306-4d2e-82c0-de559c51dba2
 Kernel Version:             4.15.0-29-generic
 OS Image:                   Ubuntu 18.04.1 LTS
 Operating System:           linux
 Architecture:               amd64
 Container Runtime Version:  docker://18.9.7
 Kubelet Version:            v1.15.0
 Kube-Proxy Version:         v1.15.0
PodCIDR:                     100.98.0.0/24
Non-terminated Pods:         (8 in total)
  Namespace                  Name                                  CPU Requests                                                                               CPU Limits  Memory Requests  Memory Limits  AGE
  ---------                  ----                                  ------------                                                                               ----------  ---------------  -------------  ---
  kube-system                coredns-5c98db65d4-g5jn6              100m (5%)                                                                                  0 (0%)      70Mi (1%)        170Mi (4%)     11h
  kube-system                coredns-5c98db65d4-m6g6c              100m (5%)                                                                                  0 (0%)      70Mi (1%)        170Mi (4%)     11h
  kube-system                etcd-kubemaster                       0 (0%)                                                                                     0 (0%)      0 (0%)           0 (0%)         11h
  kube-system                kube-apiserver-kubemaster             250m (12%)                                                                                 0 (0%)      0 (0%)           0 (0%)         11h
  kube-system                kube-controller-manager-kubemaster    200m (10%)                                                                                 0 (0%)      0 (0%)           0 (0%)         11h
  kube-system                kube-flannel-ds-amd64-5vplk           100m (5%)                                                                                  100m (5%)   50Mi (1%)        50Mi (1%)      10h
  kube-system                kube-proxy-f6xp7                      0 (0%)                                                                                     0 (0%)      0 (0%)           0 (0%)         11h
  kube-system                kube-scheduler-kubemaster             100m (5%)                                                                                  0 (0%)      0 (0%)           0 (0%)         11h
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests    Limits
  --------           --------    ------
  cpu                850m (42%)  100m (5%)
  memory             190Mi (4%)  390Mi (10%)
  ephemeral-storage  0 (0%)      0 (0%)
Events:              <none>


Name:               worker1.dell.com
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=worker1.dell.com
                    kubernetes.io/os=linux
Annotations:        flannel.alpha.coreos.com/backend-data: {"VtepMAC":"6e:5b:47:                                                                             cd:e3:11"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 100.98.26.213
                    kubeadm.alpha.kubernetes.io/cri-socket: /var/run/dockershim.                                                                             sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Fri, 05 Jul 2019 05:01:00 -0400
Taints:             <none>
Unschedulable:      false
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                                                                                             Reason                       Message
  ----             ------  -----------------                 ------------------                                                                                             ------                       -------
  MemoryPressure   False   Fri, 05 Jul 2019 15:46:27 -0400   Fri, 05 Jul 2019 05                                                                             :01:00 -0400   KubeletHasSufficientMemory   kubelet has sufficient memory availa                                                                             ble
  DiskPressure     False   Fri, 05 Jul 2019 15:46:27 -0400   Fri, 05 Jul 2019 05                                                                             :01:00 -0400   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Fri, 05 Jul 2019 15:46:27 -0400   Fri, 05 Jul 2019 05                                                                             :01:00 -0400   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            True    Fri, 05 Jul 2019 15:46:27 -0400   Fri, 05 Jul 2019 05                                                                             :01:10 -0400   KubeletReady                 kubelet is posting ready status. App                                                                             Armor enabled
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
PodCIDR:                     100.98.1.0/24
Non-terminated Pods:         (2 in total)
  Namespace                  Name                           CPU Requests  CPU Li                                                                             mits  Memory Requests  Memory Limits  AGE
  ---------                  ----                           ------------  ------                                                                             ----  ---------------  -------------  ---
  kube-system                kube-flannel-ds-amd64-fbgd4    100m (5%)     100m (                                                                             5%)   50Mi (1%)        50Mi (1%)      10h
  kube-system                kube-proxy-mx9kn               0 (0%)        0 (0%)                                                                                   0 (0%)           0 (0%)         10h
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests   Limits
  --------           --------   ------
  cpu                100m (5%)  100m (5%)
  memory             50Mi (1%)  50Mi (1%)
  ephemeral-storage  0 (0%)     0 (0%)
Events:              <none>
cse@kubemaster:~$
```



