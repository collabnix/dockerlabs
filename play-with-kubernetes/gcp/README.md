# How to install 3 Node Kubernetes Cluster on Google Cloud Platform - Hard Way?

```
apt-get update && apt-get install -y apt-transport-https

```

##


```
echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

##

```
root@instance-1:~# apt-get install -y kubelet kubeadm kubectl kubernetes-cni
Reading package lists... Done
Building dependency tree       
Reading state information... Done
kubectl is already the newest version (1.11.1-00).
kubernetes-cni is already the newest version (0.6.0-00).
The following NEW packages will be installed:
  kubeadm kubelet
0 upgraded, 2 newly installed, 0 to remove and 43 not upgraded.
5 not fully installed or removed.
Need to get 0 B/32.7 MB of archives.
After this operation, 221 MB of additional disk space will be used.
(Reading database ... 120980 files and directories currently installed.)
Preparing to unpack .../kubelet_1.11.1-00_amd64.deb ...
Unpacking kubelet (1.11.1-00) ...
Preparing to unpack .../kubeadm_1.11.1-00_amd64.deb ...
Unpacking kubeadm (1.11.1-00) ...
Setting up cri-tools (1.11.0-00) ...
Setting up ebtables (2.0.10.4-3.4ubuntu2.16.04.2) ...
update-rc.d: warning: start and stop actions are no longer supported; falling back to defaults
Setting up kubectl (1.11.1-00) ...
Setting up kubernetes-cni (0.6.0-00) ...
Setting up socat (1.7.3.1-1) ...
Setting up kubelet (1.11.1-00) ...
Setting up kubeadm (1.11.1-00) ...
Processing triggers for systemd (229-4ubuntu21.2) ...
Processing triggers for ureadahead (0.100.0-19) ...
root@instance-1:~# 
```

##

```
root@instance-1:~# kubeadm init
[init] using Kubernetes version: v1.11.1
[preflight] running pre-flight checks
I0805 10:14:10.906982   32509 kernel_validator.go:81] Validating kernel version
I0805 10:14:10.907305   32509 kernel_validator.go:96] Validating kernel config
        [WARNING SystemVerification]: docker version is greater than the most recently validated version. Docker version: 18.03.1-ee-2. Max validated version: 17.03
[preflight/images] Pulling images required for setting up a Kubernetes cluster
[preflight/images] This might take a minute or two, depending on the speed of your internet connection
[preflight/images] You can also perform this action in beforehand using 'kubeadm config images pull
```

