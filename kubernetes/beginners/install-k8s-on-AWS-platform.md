# Installing Kubernetes on GCP Platform from Scratch

## Pre-requisite:

- GCP Free Tier Account
- Create 2 Ubuntu 18.04 Instance (1 Master and 1 Worker Node)

## Executing the script to install Kubernetes Cluster

### Master Node:

```
cd install
sh install-docker.sh
sh prepare-kube.sh
sh install-kube.sh
sh install-k8s-master.sh
sh bootstrap.sh

```



### Worker Node

```
sh install-docker.sh
sh prepare-kube.sh
sh install-kube.sh
```

```
rainaajeet1981@kubeworker1:~/dockerlabs/kubernetes/beginners/install$ sudo kubeadm join 10.140.0.7:6443 --token gzukm0.oqt9hsvagvi5ygxb \
>     --discovery-token-ca-cert-hash sha256:6cd6b2e51cee2ba5d6235bb3d6b1bb07cc4daefa2c941a1e1c8c2e3310d63c1c
[preflight] Running pre-flight checks
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
```


## Verifying Kubernetes Nodes

```
rainaajeet1981@kubemaster:~$ sudo kubectl version
Client Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.0", GitCommit:"e8462b5b5dc2584fdcd18e6bcfe9f1e4d970a529", GitTreeState:"clean",
 BuildDate:"2019-06-19T16:40:16Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.0", GitCommit:"e8462b5b5dc2584fdcd18e6bcfe9f1e4d970a529", GitTreeState:"clean",
 BuildDate:"2019-06-19T16:32:14Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}
rainaajeet1981@kubemaster:~$ 
```

## Deploy a Simple Web Page

```
rainaajeet1981@kubemaster:~$ sudo kubectl create deployment hellowhale --image ajeetraina/hellowhale
deployment.apps/hellowhale created
rainaajeet1981@kubemaster:~$ sudo kubectl get deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
hellowhale   1/1     1            1           13s
rainaajeet1981@kubemaster:~$ 
```

## Getting the Pods

```
rainaajeet1981@kubemaster:~$ kubectl get po
NAME                          READY   STATUS    RESTARTS   AGE
hellowhale-798955b69f-bmfnd   1/1     Running   0          44s
rainaajeet1981@kubemaster:~$ 
```

## 

```
rainaajeet1981@kubemaster:~$ sudo kubectl expose deployment/hellowhale --port=80 --name=hellowhalesvc --type NodePort
service/hellowhalesvc exposed
rainaajeet1981@kubemaster:~$ 
```

## 

```
rainaajeet1981@kubemaster:~$ kubectl get svc
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
hellowhalesvc   NodePort    10.109.16.198   <none>        80:32356/TCP   19s
kubernetes      ClusterIP   10.96.0.1       <none>        443/TCP        21m
rainaajeet1981@kubemaster:~$ 
```

## 

Wait till External-IP under the firt row appear.

## Logs

     
 ```
 [control-plane] Creating static Pod manifest for "kube-controller-manager"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up
 to 4m0s
[apiclient] All control plane components are healthy after 24.503004 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config-1.15" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Skipping phase. Please see --upload-certs
[mark-control-plane] Marking the node kubemaster as control-plane by adding the label "node-role.kubernetes.io/master=''"
[mark-control-plane] Marking the node kubemaster as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
[bootstrap-token] Using token: gzukm0.oqt9hsvagvi5ygxb
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy
Your Kubernetes control-plane has initialized successfully!
To start using your cluster, you need to run the following as a regular user:
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/
Then you can join any number of worker nodes by running the following on each as root:
kubeadm join 10.140.0.7:6443 --token gzukm0.oqt9hsvagvi5ygxb \
    --discovery-token-ca-cert-hash sha256:6cd6b2e51cee2ba5d6235bb3d6b1bb07cc4daefa2c941a1e1c8c2e3310d63c1c 
clusterrole.rbac.authorization.k8s.io/flannel created
clusterrolebinding.rbac.authorization.k8s.io/flannel created
serviceaccount/flannel created
configmap/kube-flannel-cfg created
daemonset.extensions/kube-flannel-ds-amd64 created
daemonset.extensions/kube-flannel-ds-arm64 created
daemonset.extensions/kube-flannel-ds-arm created
daemonset.extensions/kube-flannel-ds-ppc64le created
daemonset.extensions/kube-flannel-ds-s390x created
rainaajeet1981@kubemaster:~$ 
 
 ```









