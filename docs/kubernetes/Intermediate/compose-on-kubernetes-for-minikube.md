# Compose on Kubernetes for Minikube

Why Compose on Kubernetes? 

The Kubernetes API is really quite large. There are more than 50 first-class objects in the latest release, from Pods and Deployments to ValidatingWebhookConfiguration and ResourceQuota. This can lead to a verbosity in configuration, which then needs to be managed by you, the developer. 

The Kubernetes API is amazingly general purpose — it exposes low-level primitives for building the full range of distributed systems. Compose, meanwhile, isn't an API, but a high-level tool focused on developer productivity. That's why combining them together makes sense. For the common case of a set of interconnected web services, Compose provides an abstraction that simplifies Kubernetes configuration. For everything else, you can still drop down to the raw Kubernetes API primitives.

Now you can use Swarm CLI to manage Kubernetes Cluster in lot easier way. 

First, we need to install the Compose on Kubernetes controller into your Kubernetes cluster. This controller uses the standard Kubernetes extension points to introduce the "Stack" to the Kubernetes API. You can use any Kubernetes cluster you like, but if you don't already have one available then remember that Docker Desktop comes with Kubernetes and the Compose controller built-in, and enabling it is as simple as ticking a box in the settings.

Kops, short for Kubernetes Operations, is a set of tools for installing, operating, and deleting Kubernetes clusters in the cloud. A rolling upgrade of an older version of Kubernetes to a new version can also be performed. It also manages the cluster add-ons. After the cluster is created, the usual kubectl CLI can be used to manage resources in the cluster.

## Pre-requisite

- Install Docker Desktop on MacOS
- Enable Kubernetes with the below feature enabled

![My Image](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/Intermediate/dockerdesktop1.png)





## Verifying Docker Desktop

```
[Captains-Bay]🚩 >  docker version
Client: Docker Engine - Community
 Version:           18.09.1
 API version:       1.39
 Go version:        go1.10.6
 Git commit:        4c52b90
 Built:             Wed Jan  9 19:33:12 2019
 OS/Arch:           darwin/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.1
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.6
  Git commit:       4c52b90
  Built:            Wed Jan  9 19:41:49 2019
  OS/Arch:          linux/amd64
  Experimental:     true
 Kubernetes:
  Version:          v1.12.4
  StackAPI:         v1beta2
[Captains-Bay]🚩 >
  ```




## Installing Minikube

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 \
  && chmod +x minikube
```


## Verifying Minikube Version

```
minikube version
minikube version: v0.32.0
```

## Checking Minikube Status

```
minikube status
host: Stopped
kubelet:
apiserver:
```

## Starting Minikube

```
kubectl: [Captains-Bay]🚩 >  minikube start
Starting local Kubernetes v1.12.4 cluster...
Starting VM...
Getting VM IP address...
Moving files into cluster...
Setting up certs...
Connecting to cluster...
Setting up kubeconfig...
Stopping extra container runtimes...
Machine exists, restarting cluster components...
Verifying kubelet health ...
Verifying apiserver health ....Kubectl is now configured to use the cluster.
Loading cached images from config file.


Everything looks great. Please enjoy minikube!
```

## Checking the Status

```
[Captains-Bay]🚩 >  minikube status
host: Running
kubelet: Running
apiserver: Running
kubectl: Correctly Configured: pointing to minikube-vm at 192.168.99.100[Captains-Bay]🚩 >
```

##  Verifying Minikube Cluster Nodes


```
 kubectl get nodes
NAME       STATUS    ROLES     AGE       VERSION
minikube   Ready     master    12h       v1.12.4
```

##

```
kubectl create namespace compose
namespace "compose" created
```

## Creating the tiller service account

```
kubectl -n kube-system create serviceaccount tiller
serviceaccount "tiller" created
```

## Give it admin access to your cluster (note: you might want to reduce the scope of this):

```
kubectl -n kube-system create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount kube-system:tiller
clusterrolebinding "tiller" created
```

## Initializing the helm component.

```
[Captains-Bay]🚩 >  helm init --service-account tiller
$HELM_HOME has been configured at /Users/ajeetraina/.helm.

Tiller (the Helm server-side component) has been installed into your Kubernetes Cluster.

Please note: by default, Tiller is deployed with an insecure 'allow unauthenticated users' policy.
For more information on securing your installation see: https://docs.helm.sh/using_helm/#securing-your-helm-installation
Happy Helming!
```

##

```
helm version
Client: &version.Version{SemVer:"v2.9.1", GitCommit:"20adb27c7c5868466912eebdf6664e7390ebe710", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.9.1", GitCommit:"20adb27c7c5868466912eebdf6664e7390ebe710", GitTreeState:"clean"}
```

##

```
[Captains-Bay]🚩 >  minikube status
host: Running
kubelet: Running
apiserver: Running
```

##

```
kubectl -n kube-system get pod
NAME                                    READY     STATUS    RESTARTS   AGE
coredns-576cbf47c7-fsk76                1/1       Running   1          12h
coredns-576cbf47c7-xc2br                1/1       Running   1          12h
etcd-minikube                           1/1       Running   1          12h
kube-addon-manager-minikube             1/1       Running   1          12h
kube-apiserver-minikube                 1/1       Running   0          11m
kube-controller-manager-minikube        1/1       Running   0          11m
kube-proxy-8kcjr                        1/1       Running   0          11m
kube-scheduler-minikube                 1/1       Running   1          12h
kubernetes-dashboard-5bff5f8fb8-qfrwl   1/1       Running   3          12h
storage-provisioner                     1/1       Running   3          12h
tiller-deploy-694dc94c65-tt27k          1/1       Running   0          4m
```

## Deploy etcd operator and create an etcd cluster

```
Captains-Bay]🚩 >  helm install --name etcd-operator stable/etcd-operator --namespace compose
NAME:   etcd-operator
LAST DEPLOYED: Fri Jan 11 10:08:06 2019
NAMESPACE: compose
STATUS: DEPLOYED

RESOURCES:
==> v1/ServiceAccount
NAME                                               SECRETS  AGE
etcd-operator-etcd-operator-etcd-backup-operator   1        1s
etcd-operator-etcd-operator-etcd-operator          1        1s
etcd-operator-etcd-operator-etcd-restore-operator  1        1s

==> v1beta1/ClusterRole
NAME                                       AGE
etcd-operator-etcd-operator-etcd-operator  1s

==> v1beta1/ClusterRoleBinding
NAME                                               AGE
etcd-operator-etcd-operator-etcd-backup-operator   1s
etcd-operator-etcd-operator-etcd-operator          1s
etcd-operator-etcd-operator-etcd-restore-operator  1s

==> v1/Service
NAME                   TYPE       CLUSTER-IP      EXTERNAL-IP  PORT(S)    AGE
etcd-restore-operator  ClusterIP  10.104.102.245  <none>       19999/TCP  1s

==> v1beta1/Deployment
NAME                                               DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
etcd-operator-etcd-operator-etcd-backup-operator   1        1        1           0          1s
etcd-operator-etcd-operator-etcd-operator          1        1        1           0          1s
etcd-operator-etcd-operator-etcd-restore-operator  1        1        1           0          1s

==> v1/Pod(related)
NAME                                                             READY  STATUS             RESTARTS  AGE
etcd-operator-etcd-operator-etcd-backup-operator-7978f8bc4r97s7  0/1    ContainerCreating  0         1s
etcd-operator-etcd-operator-etcd-operator-6c57fff9d5-kdd7d       0/1    ContainerCreating  0         1s
etcd-operator-etcd-operator-etcd-restore-operator-6d787599vg4rb  0/1    ContainerCreating  0         1s


NOTES:
1. etcd-operator deployed.
  If you would like to deploy an etcd-cluster set cluster.enabled to true in values.yaml
  Check the etcd-operator logs
    export POD=$(kubectl get pods -l app=etcd-operator-etcd-operator-etcd-operator --namespace compose --output name)
    kubectl logs $POD --namespace=compose
[Captains-Bay]🚩 >
```


## Copy the below content into compose-etcd.yml

```
cat compose-etcd.yaml
apiVersion: "etcd.database.coreos.com/v1beta2"
kind: "EtcdCluster"
metadata:
  name: "compose-etcd"
  namespace: "compose"
spec:
  size: 3
  version: "3.2.13"
```

##

```
kubectl apply -f compose-etcd.yml
etcdcluster "compose-etcd" created


```

This should bring an etcd cluster in the compose namespace.

## Download the Compose Installer

```
wget https://github.com/docker/compose-on-kubernetes/releases/download/v0.4.17/installer-darwin
```

## 

```
./installer-darwin -namespace=compose -etcd-servers=http://compose-etcd-client:2379 -tag=v0.4.17
INFO[0000] Checking installation state
INFO[0000] Install image with tag "v0.4.16" in namespace "compose"
INFO[0000] Api server: image: "docker/kube-compose-api-server:v0.4.17", pullPolicy: "Always"
INFO[0000] Controller: image: "docker/kube-compose-controller:v0.4.17", pullPolicy: "Always"
```

##

```
[Captains-Bay]🚩 >  kubectl api-versions| grep compose
compose.docker.com/v1beta1
compose.docker.com/v1beta2
```

## 

```
[Captains-Bay]🚩 >  minikube service list
|-------------|-------------------------------------|-----------------------------|
|  NAMESPACE  |                NAME                 |             URL             |
|-------------|-------------------------------------|-----------------------------|
| compose     | compose-api                         | No node port                |
| compose     | compose-etcd-client                 | No node port                |
| compose     | compose-etcd-client-client          | No node port                |
| compose     | etcd-restore-operator               | No node port                |
| default     | db1                                 | No node port                |
| default     | example-etcd-cluster-client-service | http://192.168.99.100:32379 |
| default     | kubernetes                          | No node port                |
| default     | web1                                | No node port                |
| default     | web1-published                      | http://192.168.99.100:32511 |
| kube-system | kube-dns                            | No node port                |
| kube-system | kubernetes-dashboard                | No node port                |
| kube-system | tiller-deploy                       | No node port                |
|-------------|-------------------------------------|-----------------------------|
[Captains-Bay]🚩 >
```

## Verifying StackAPI

```
[Captains-Bay]🚩 >  docker version
Client: Docker Engine - Community
 Version:           18.09.1
 API version:       1.39
 Go version:        go1.10.6
 Git commit:        4c52b90
 Built:             Wed Jan  9 19:33:12 2019
 OS/Arch:           darwin/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.1
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.6
  Git commit:       4c52b90
  Built:            Wed Jan  9 19:41:49 2019
  OS/Arch:          linux/amd64
  Experimental:     true
 Kubernetes:
  Version:          v1.12.4
  StackAPI:         v1beta2
[Captains-Bay]🚩 >
```

```
[Captains-Bay]🚩 >  docker stack deploy -c docker-compose2.yml myapp4
Waiting for the stack to be stable and running...
db1: Ready		[pod status: 1/2 ready, 1/2 pending, 0/2 failed]
web1: Ready		[pod status: 2/2 ready, 0/2 pending, 0/2 failed]

Stack myapp4 is stable and running

[Captains-Bay]🚩 >  docker stack ls
NAME                SERVICES            ORCHESTRATOR        NAMESPACE
myapp4              2                   Kubernetes          default
[Captains-Bay]🚩 >  kubectl get po
NAME                    READY     STATUS    RESTARTS   AGE
db1-55959c855d-jwh69    1/1       Running   0          57s
db1-55959c855d-kbcm4    1/1       Running   0          57s
web1-58cc9c58c7-sgsld   1/1       Running   0          57s
web1-58cc9c58c7-tvlhc   1/1       Running   0          57s
```

## Contributor

[Ajeet S Raina](mailto:ajeetraina@gmail.com)
