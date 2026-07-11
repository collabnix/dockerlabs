## Preparing 5-Node Kubernetes Cluster

To get started with Kubernetes, follow the below steps:

-  Open https://play-with-k8s.com on your browser

![Image](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/workshop/img/pwk1.png)


Click on Add Instances to setup first k8s node cluster

## Cloning the Repository

```
git clone https://github.com/collabnix/dockerlabs/
cd dockerlabs/kubernetes/install

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
[node1 ]$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   1h
[node1 $
```




