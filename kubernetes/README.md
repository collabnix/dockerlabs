# Getting Started with Kubernetes

# Understanding The Term "Kubernetes"
- What is Kubernetes ?
- Explain where kubernetes fits ?

# Installation & Getting Started
- Setup
- Prerequisites
- Downloads
  Download & Install Kubernetes CLI
[source,bash]
- Environment
[source,bash]
- Create the VM
[source,bash]

```
$ !/bin/bash

$ minikube config set memory 6144
$ minikube config set cpus 2 <1>
$ minikube config set vm-driver virtualbox #hyperkit <2>
$ minishift addon enable admin-user <3>
$ minishift addon enable anyuid <4>
$ minikube start
```
<1> "Explain Minimum Resources for Laptop/ Home Machine".  
<2> "Explain recommended Hypervisor".  
<3> Minishift is secured by default, this creates an cluster "admin" user.  
<4> A mechanism on OpenShift that allows the execution of an image with any user id, including root.  

- Check status, IP & Dashboard/Console
```
$
```
