# Demystifying Kubernetes Architecture

## What is Kubernetes?

Kubernetes (often abbreviated to K8S), is a container orchestration platform for applications that run on containers.
Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications.
It groups containers that make up an application into logical units for easy management and discovery. 

At a minimum, Kubernetes can schedule and run application containers on clusters of physical or virtual machines. 
However, Kubernetes also allows developers to ‘cut the cord’ to physical and virtual machines, moving from a host-centric infrastructure to a container-centric infrastructure, which provides the full advantages and benefits inherent to containers. 
Kubernetes provides the infrastructure to build a truly container-centric development environment.

## IMPORTANT NOTES:

- Kubernetes operates at the application level rather than at the hardware level
- Kubernetes is not monolithic, and these default solutions are optional and pluggable.
- Additionally, Kubernetes is not a mere orchestration system.

In fact, it eliminates the need for orchestration. 
The technical definition of orchestration is execution of a defined workflow: first do A, then B, then C. 
In contrast, Kubernetes is comprised of a set of independent, composable control processes that continuously drive the 
current state towards the provided desired state. 
It shouldn’t matter how you get from A to C. 
Centralized control is also not required; the approach is more akin to choreography. 
This results in a system that is easier to use and more powerful, robust, resilient, and extensible.

- Kubernetes aims to support an extremely diverse variety of workloads, including stateless, stateful, and 
data-processing workloads.If an application can run in a container, it should run great on Kubernetes.

- Allows users to choose their logging, monitoring, and alerting systems. (It provides some integrations as proof of concept.)
- Kubernetes is designed to serve as a platform for building an ecosystem of components and tools to make it easier to deploy,
 scale, and manage applications.
- Kubernetes is not a traditional, all-inclusive PaaS (Platform as a Service) system

## A Look at High Level Kubernetes Architecture

- There is a kubernetes Client called Kubectl which talks to Kube API which is running on your master node.
- All states and configuration are stored in etcd. The etcd can be run on master or outside the cluster.
- You have nodes where you run workloads on

# Kubernetes Master:

It consists of -

- Kube-apiserver
- kube-controller-manager
- kube-scheduler

Whenever you run command through kubectl, it always hits the API server which then goes to etcd store.
Kube-controller manager will always look after your cluster and runs new command which you run against the API server
Ensures that any workload you schedule it finds free nodes and then schedule workload on that node.

All Kubernetes nodes have kubelet that ensures that any pod assigned to it are running and configured in desired state.

# Pod: 
- consits of one or more container
- MOst Pods are single container to make it simple

# Services:

- Helps us in finding out more pods.
- You don't need to go to Pods using IP address, instead you go to service, and service route to specifc Pod.
Services are more stable, pods keeping changing

# Volume
- Allow to maintain state in the cluster
- keep any info we want

# namespace
- seperating different workload from each other
You can have 10 developers, give them each namespace...each namespace which shoudnt consume mroe than 2GB RAM.


Advance Features:



# ReplicataSet

- 

- Both allows to ensure when you launch pods, I want 5 pods in a cluster, it will ensure we hae 5 pods in a cluster
- Superseded Replication Controller
- More Regex way of selecting the Pods

We usually dont 

# Deployments:

- Combines ReplicataSets 
- Roll out new images and ROll back Images
- Nice Continuous Deployment scenarios

# Statefulset:

- Databases in a cluster

# DaemonSets:

- Ensure that there is atleast 1 Pod running in a cluster

# Jobs

- Cron jobs or one of job you want to run
- Batch Processing..it finishes up..













