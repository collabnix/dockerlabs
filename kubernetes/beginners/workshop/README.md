# Kubernetes Workshop

## Lab #01 - Getting Started

[Building 5-Node Kubernetes Cluster on Browser](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/beginners/getting-started-on-pwk.md)<br>
[Running Your First Nginx pod](https://github.com/collabnix/dockerlabs/tree/master/kubernetes/beginners/workshop/lab00-running-nginx-pod#lab-00-running-nginx-pod)<br>
[Exposing the Service so as to browse the Nginx over URL ](https://github.com/collabnix/dockerlabs/tree/master/kubernetes/beginners/workshop/lab00-running-nginx-pod#exposing-the-service-so-as-to-browse-the-nginx-over-url)<br>
[Cleaning Up Nginx Pod](https://github.com/collabnix/dockerlabs/tree/master/kubernetes/beginners/workshop/lab00-running-nginx-pod#cleaning-up) <br>

## Lab #02 - Getting Started with Pod Manifest file

[Creating Nginx Pod using Pod Manifest File](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/beginners/workshop/lab01-creating-nginx-pod/README.md#lab-01-creating-nginx-pod-using-pod-manifest-file)<br>
[Accessing Nginx Page over URL](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/beginners/workshop/lab01-creating-nginx-pod/README.md#verify-that-the-pod-came-up-fine)<br>

## Lab #03 - Getting Started with ReplicaSet Manifest File

[Creating ReplicaSet Manifest file for Nginx](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/beginners/workshop/lab02-creating-replicaset)<br>
[Scaling up Nginx Application](https://github.com/collabnix/dockerlabs/tree/master/kubernetes/beginners/workshop/lab03-creating-deployment-3replicas-nginx#scaling-up-nginx-app)

## Lab #04 - Getting Started with Deployment Manifest File

[Creating a Deployment with 3 replicas of NGINX service](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/beginners/workshop/lab03-creating-deployment-3replicas-nginx)<br>

## Lab #05 Deployments, Rolling Updates and Rollbacks
[ creating deployement nginx with 2 replicals ] <br> 
[ Rolling update of nginx application via two methods] <br> 
[ Rolling out deployement with revision ] <br>

## Lab #06 Service Networking
## Lab #07 Ingress for kubernetes 
## lab #08 Deploying a Load Balancer
## lab #09 Configure and Use Cluster DNS
## lab #10 Persistent Storage
## lab #11 Kubernetes Self-Healing
## lab #12 Liveness Probes in Kubernetes
## lab #13 Auto-Scaling
## lab #14 Horizontal Pod Auto-Scaling
## lab #15 monitoring 


## Using Helm

[Installing Helm](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/beginners/workshop/helm/getting-started.md)<br>
[Installing WordPress using Helm on PWK](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/beginners/workshop/helm/installing-wordpress.md)<br>

# Tips & Tricks

## #1: My system rebooted and now the ```kubectl get nodes``` is unable to display my K8s nodes. What shall I do?


```
~$ sudo systemctl restart kubelet
@kubemaster:~$ sudo kubectl version
Client Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.0", GitCommit:"e8462b5b5dc2584fdcd18e6bcfe9f1e4d970a529", GitTreeState:"clean", BuildDate:"2019-06-19T16:40:16Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.0", GitCommit:"e8462b5b5dc2584fdcd18e6bcfe9f1e4d970a529", GitTreeState:"clean", BuildDate:"2019-06-19T16:32:14Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}
```

```
$ sudo kubectl get nodes
NAME               STATUS   ROLES    AGE   VERSION
kubemaster         Ready    master   10d   v1.15.0
worker1            Ready    <none>   10d   v1.15.0
```
