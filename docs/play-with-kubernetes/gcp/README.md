# How to install 3 Node Kubernetes Cluster on Google Cloud Platform - Hard Way?

## Setting up Kubernetes Master Node

```
apt-get update && apt-get install -y apt-transport-https

```

##


```
echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

##

```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
```

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

[markmaster] Marking the node instance-1 as master by adding the taints [node-role.kubernetes.io/ma
ster:NoSchedule]
[patchnode] Uploading the CRI Socket information "/var/run/dockershim.sock" to the Node API object 
"instance-1" as an annotation
[bootstraptoken] using token: tq1bra.gvb47is9ipkwcrsk
[bootstraptoken] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nod
es to get long term certificate credentials
[bootstraptoken] configured RBAC rules to allow the csrapprover controller automatically approve CS
Rs from a Node Bootstrap Token
[bootstraptoken] configured RBAC rules to allow certificate rotation for all node client certificat
es in the cluster
[bootstraptoken] creating the "cluster-info" ConfigMap in the "kube-public" namespace
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy
Your Kubernetes master has initialized successfully!
To start using your cluster, you need to run the following as a regular user:
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/
You can now join any number of machines by running the following on each node
as root:
  kubeadm join 10.140.0.2:6443 --token tq1bra.gvb47is9ipkwcrsk --discovery-token-ca-cert-hash sha25
6:fbe33cb67b07b4261c71b642fc21f9f36f53e6e9bf7f5ffa37665915244adfc0
root@instance-1:~# 

```

```
CaptainsBay==>kubectl apply -f https://git.io/weave-kube
serviceaccount/weave-net created
daemonset.extensions/weave-net created
CaptainsBay==>
```

## Setting up Kubernetes Worker Node

Follow the above steps to install k8s components.

## Joining the node

```
 1. Run 'modprobe -- ' to load missing kernel modules;
2. Provide the missing builtin kernel ipvs support
I0805 10:25:38.089798    6704 kernel_validator.go:81] Validating kernel version
I0805 10:25:38.090020    6704 kernel_validator.go:96] Validating kernel config
        [WARNING SystemVerification]: docker version is greater than the most recently validated ver
sion. Docker version: 18.06.0-ce. Max validated version: 17.03
[discovery] Trying to connect to API Server "10.140.0.2:6443"
[discovery] Created cluster-info discovery client, requesting info from "https://10.140.0.2:6443"
[discovery] Requesting info from "https://10.140.0.2:6443" again to validate TLS against the pinned 
public key
[discovery] Cluster info signature and contents are valid and TLS certificate validates against pinn
ed roots, will use API Server "10.140.0.2:6443"
[discovery] Successfully established connection with API Server "10.140.0.2:6443"
[kubelet] Downloading configuration for the kubelet from the "kubelet-config-1.11" ConfigMap in the 
kube-system namespace
[kubelet] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[preflight] Activating the kubelet service
[tlsbootstrap] Waiting for the kubelet to perform the TLS Bootstrap...
[patchnode] Uploading the CRI Socket information "/var/run/dockershim.sock" to the Node API object "
instance-2" as an annotation
This node has joined the cluster:
* Certificate signing request was sent to master and a response
  was received.
* The Kubelet was informed of the new secure connection details.
Run 'kubectl get nodes' on the master to see this node join the cluster.
```

## Verifying the Nodes

```
CaptainsBay==>kubectl get nodes
NAME         STATUS     ROLES     AGE       VERSION
instance-1   NotReady   master    10m       v1.11.1
instance-2   NotReady   <none>    42s       v1.11.1
```

## Regenerating the token

```
root@system-mining: kubeadm token generate  
206b7b.a815ac87abb0ea03
```

## Setting up Dashboard

```
CaptainsBay==>kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master
/src/deploy/recommended/kubernetes-dashboard.yaml
secret/kubernetes-dashboard-certs created
serviceaccount/kubernetes-dashboard created
role.rbac.authorization.k8s.io/kubernetes-dashboard-minimal created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard-minimal created
deployment.apps/kubernetes-dashboard created
service/kubernetes-dashboard created
CaptainsBay==>

```

##

```

```

##

```


```




