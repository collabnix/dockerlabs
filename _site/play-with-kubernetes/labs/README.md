# Getting Started with PWK Labs

Play with Docker is a sandbox environment to get you started with Kubernetes Cluster on the fly.
Using personal credentials is HIGHLY! discouraged.

## Pre-requisite

- Open up [play-with-kubernetes.com](http://play-with-kubernetes.com) on your browser


## Bootstrapping the K8s Cluster:

Bring up your first k8s instance by clicking on "New Instance". 

 - Initializes cluster master node:

 ```
 kubeadm init --apiserver-advertise-address $(hostname -i)
 ```
 
 Wait for a minute to get it completely intiliazed. This will start up API server
 
 
 ## Start Using Your Cluster
 
 To start using your cluster, you need to run (as a regular user):

```
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

 ## Initialize cluster networking:

```
kubectl apply -n kube-system -f \
    "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 |tr -d '\n')"
```    
    
 ## (Optional) Create an nginx deployment:

 ```
 kubectl apply -f https://raw.gi
 
 ```


## Adding K8s Worker Nodes

Open up new instances and join the other nodes:

```
kubeadm join --token fb9445.c4835ebdb6a7d7e5 192.168.0.8:6443 --discovery-token-ca-cert-hashsha256:b211c43880b4419f6de772495a35ee40337a36cbac0b8af54704b84622423bf4
```

## Displaying the Nodes

```
[node1 ~]$ kubectl get nodes
NAME      STATUS    ROLES     AGE       VERSION
node1     Ready     master    23m       v1.10.0
node2     Ready     <none>    13m       v1.10.0
node3     Ready     <none>    12m       v1.10.0
node4     Ready     <none>    12m       v1.10.0
[node1 ~]$
```

Proceed to [Lab #1: Test Driving NGINX Deployment on a Single Node](https://github.com/ajeetraina/docker101/blob/master/play-with-kubernetes/labs/nginx.md)

