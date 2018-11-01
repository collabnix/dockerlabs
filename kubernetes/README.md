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
=== Create the VM
[source,bash]
----
#!/bin/bash

minikube config set memory 6144
minikube config set cpus 2 <1>
minikube config set vm-driver virtualbox #hyperkit <2>
# minishift addon enable admin-user <3>
# minishift addon enable anyuid <4>
minikube start
----
<1> I use 2 cpus here because I have 6 core laptop.  Keep this number at or below 50% of overall laptop resources.
There is nothing in this series of exercises that is CPU intensive but minishift has a 10 pod per core limit.
<2> I use virtualbox because it is available on all platforms.  There a number of hypervisor options
https://kubernetes.io/docs/tasks/tools/install-minikube/#install-a-hypervisor
<3> Minishift is secured by default, this creates an cluster "admin" user

Note: with 1.24, I have seen this command fail, the workaround is to wait until minishift start completes then use
"minishift addons apply admin-user"

<4> A mechanism on OpenShift that allows the execution of an image with any user id, including root.
https://github.com/burrsutter/9stepsawesome/issues/3
