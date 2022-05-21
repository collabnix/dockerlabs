# Installing Kubernetes Dashboard on Play with Kubernetes Platform

Dashboard is a web-based Kubernetes user interface. It can be used to deploy containerized applications to a Kubernetes cluster, 
troubleshoot your containerized application, and manage the cluster resources. 
You can use Dashboard to get an overview of applications running on your cluster, as well as for creating or modifying individual 
Kubernetes resources (such as Deployments, Jobs, DaemonSets, etc). For example, you can scale a Deployment, initiate a rolling update,
restart a pod or deploy new applications using a deploy wizard. It also provides information on the state of Kubernetes resources in your cluster and on any errors that may have occurred.

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Play with Kubernetes</b></td>
    <td class="tg-yw4l"><b>5</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWK](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side


## Building 5 Node K8s Cluster

```
git clone https://github.com/ajeetraina/kubernetes101
cd kubernetes101/install
sh bootstrap.sh
```

```
You can now join any number of machines by running the following on each node
as root:

  kubeadm join 172.26.0.2:6443 --token 6pe5qv.08r4ca4zpun0iden --discovery-token-ca-cert-hash sha256:30df21524001ffe6bd2c5a6a3af53729c1d830865f68e8af1e2c2836774da068

Waiting for api server to startup
Warning: kubectl apply should be used on resource created by either kubectl create --save-config or kubectl apply
daemonset.extensions/kube-proxy configured
No resources found
serviceaccount/weave-net created
clusterrole.rbac.authorization.k8s.io/weave-net created
clusterrolebinding.rbac.authorization.k8s.io/weave-net created
role.rbac.authorization.k8s.io/weave-net created
rolebinding.rbac.authorization.k8s.io/weave-net created
daemonset.extensions/weave-net created
```

## Adding Worker Nodes

Copy the command which joins rest of the 4 worker node to the master node

```
kubeadm join 172.26.0.2:6443 --token 6pe5qv.08r4ca4zpun0iden --discovery-token-ca-cert-hash sha256:30df21524001ffe6bd2c5a6a3af53729c1d830865f68e8af1e2c2836774da068
```

## Listing K8s Nodes

```
[node1 install]$ kubectl get nodes
NAME      STATUS     ROLES     AGE       VERSION
node1     Ready      master    2m        v1.11.3
node2     NotReady   <none>    33s       v1.11.3
node3     NotReady   <none>    25s       v1.11.3
node4     NotReady   <none>    14s       v1.11.3
node5     NotReady   <none>    7s        v1.11.3
```

Wait for 3 minutes till these nodes shows up as "Ready"

```
[node1 install]$ kubectl get nodes
NAME      STATUS    ROLES     AGE       VERSION
node1     Ready     master    4m        v1.11.3
node2     Ready     <none>    2m        v1.11.3
node3     Ready     <none>    2m        v1.11.3
node4     Ready     <none>    2m        v1.11.3
node5     Ready     <none>    2m        v1.11.3
```

## Installing Kubernetes Dashboard

```
[node1 install]$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml
secret/kubernetes-dashboard-certs created
secret/kubernetes-dashboard-csrf created
serviceaccount/kubernetes-dashboard created
role.rbac.authorization.k8s.io/kubernetes-dashboard-minimal created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard-minimal created
deployment.apps/kubernetes-dashboard created
service/kubernetes-dashboard created
[node1 install]$
```





