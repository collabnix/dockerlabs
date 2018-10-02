# Kubernetes For You

Are you new to Kubernetes? Want to build your career in Kubernetes?

Then Welcome ! You are at the right place.

This repository brings you tutorials that help you get hands-on experience using Kubernetes. Here you will find a mix of labs and tutorials that will help you, no matter if you are a beginner, SysAdmin, IT Pro or Developer. Yes, you read it correct ! Its $0 learning platform. You don't need any infrastructure. Most of the tutorials runs on Play with K8s Platform. This is a free browser based learning platform for you. Kubernetes tools like kubeadm, kompose & kubectl are already installed for you. All you need is to get started.

We recommend you start with one of our Beginners Guides, and then move to intermediate and expert level tutorials that cover most of the features of Kubernetes. For a comprehensive approach to understanding Docker, I have categorized it as shown below:

[Kubernetes for Beginners](https://github.com/ajeetraina/docker101/blob/master/play-with-kubernetes/beginners/README.md)<br>

[Kubernetes for Intermediate](https://github.com/ajeetraina/docker101/blob/master/play-with-kubernetes/intermediate/README.md)<br>

[Kubernetes for Advanced Users](https://github.com/ajeetraina/docker101/play-with-kubernetes/advanced/README.md)<br>

## Getting Started with Kubernetes

To get started with Kubernetes, follow the below steps:

-  Open https://labs.play-with-kubernetes.com on your browser


Click on Add Instances to setup first k8s node cluster

## Cloning the Repository

```
git clone https://github.com/ajeetraina/docker101/
cd docker101/play-with-kubernetes

```

## Bootstrapping the First Node Cluster

```
sh bootstrap.sh
```

## Adding New K8s Cluster Node

Click on Add Instances to setup first k8s node cluster

Wait for 1 minute time till it gets completed.

Copy the command starting with ```kubeadm join ....```. We will need it to be run on the worker node.


## Setting up Worker Node

Click on "Add New Instance" and paste the last kubeadm command on this fresh new worker node.

```
[node2 ~]$ kubeadm join --token 4f924f.14eb7618a20d2ece 192.168.0.8:6443 --discovery-token-ca-cert-hash  sha256:a5c25aa4573e06a0c11b11df23c8f85c95bae36cbb07d5e7879d9341a3ec67b3```
```

You will see the below output:

```
[kubeadm] WARNING: kubeadm is in beta, please do not use it for production clusters.
[preflight] Skipping pre-flight checks[discovery] Trying to connect to API Server "192.168.0.8:6443"
[discovery] Created cluster-info discovery client, requesting info from "https://192.168.0.8:6443"
[discovery] Requesting info from "https://192.168.0.8:6443" again to validate TLS against the pinned public key
[discovery] Cluster info signature and contents are valid and TLS certificate validates against pinned roots, will use API Server "192.168.0.8:6443"[discovery] Successfully established connection with API Server "192.168.0.8:6443"
[bootstrap] Detected server version: v1.8.15
[bootstrap] The server supports the Certificates API (certificates.k8s.io/v1beta1)
Node join complete:
* Certificate signing request sent to master and response
  received.
* Kubelet informed of new secure connection details.

Run 'kubectl get nodes' on the master to see this machine join.
[node2 ~]$
```

# Verifying Kubernetes Cluster

Run the below command on master node

```
[node1 ~]$ kubectl get nodes
NAME      STATUS    ROLES     AGE       VERSION
node1     Ready     master    15m       v1.10.2
node2     Ready     <none>    1m        v1.10.2
[node1 ~]$
```

## Adding Worker Nodes

```
[node1 ~]$ kubectl get nodes
NAME      STATUS    ROLES     AGE       VERSION
node1     Ready     master    58m       v1.10.2
node2     Ready     <none>    57m       v1.10.2
node3     Ready     <none>    57m       v1.10.2
node4     Ready     <none>    57m       v1.10.2
node5     Ready     <none>    54s       v1.10.2
```

```
[node1 istio]$ kubectl get po
No resources found.
```

```
[node1 istio]$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   1h
[node1 istio]$
```

# Kubernetes-Ready Solution

[ Demonstrating WordPress under Multi-Node K8s Cluster](https://github.com/ajeetraina/docker101/blob/master/play-with-kubernetes/intermediate/README.md)<br>
[ Deploying Nginx on Single Node K8s Cluster](https://github.com/ajeetraina/docker101/blob/master/play-with-kubernetes/beginner/nginx/README.md)<br>
[ Building Multi-Node Hadoop Cluster under K8s Cluster](https://github.com/ajeetraina/docker101/blob/master/play-with-kubernetes/intermediate/README.md)<br>





