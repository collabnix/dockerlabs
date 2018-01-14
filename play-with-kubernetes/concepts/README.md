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
- Kubernetes operates on a declarative model, object specifications provided in so called manifest files declare how you want the cluster to look. There’s no need for a list of commands, it’s up to Kubernetes to do anything and everything it needs to get there.

## A Look at High Level Kubernetes Architecture

- There is a kubernetes Client called Kubectl which talks to Kube API which is running on your master node.
- All states and configuration are stored in etcd. The etcd can be run on master or outside the cluster.
- You have nodes where you run workloads on

# Kubernetes Master:

This is the Kubernetes control panel or control plane. This is where decisions are made about the cluster, such as scheduling, and detecting/responding to cluster events. The components of the master can be run on any node in the cluster. Below is a breakdown of each of the key components of the master:

It consists of -

- Kube-apiserver
- kube-controller-manager
- kube-scheduler

# Kube-apiserver

This is the only component of the Kubernetes control panel with a user-accessible API and the sole master component that you’ll interact with. The API server exposes a restful Kubernetes API and consumes JSON manifest files.

Whenever you run command through kubectl, it always hits the API server which then goes to etcd store.

Kubernetes uses “etcd.” This is a strong, consistent, and highly-available key value store that Kubernetes uses for persistent storage of all API objects. Think of it as the “source of truth” for the cluster.

# Kube-Controller Manager

Also known as the “kube-controller manager,” this runs all the controllers that handle routine tasks in the cluster. These include the Node Controller, Replication Controller, Endpoints Controller, and Service Account and Token Controllers. Each of these controllers works separately to maintain the desired state.

Kube-controller manager will always look after your cluster and runs new command which you run against the API server
Ensures that any workload you schedule it finds free nodes and then schedule workload on that node.

# Kube-Scheduler

The scheduler watches for newly-created pods (groups of one or more containers) and assigns them to nodes.

Please note that all Kubernetes nodes have kubelet that ensures that any pod assigned to it are running and configured in desired state.


## Kubernetes Worker Nodes

The second important component under the hood are nodes. Whereas the master handles and manages the cluster, worker nodes run the containers and provide the Kubernetes runtime environment.

Worker nodes comprise a kubelet. This is the primary node agent. It watches the API server for pods that have been assigned to its node. Kubelet carries out tasks and maintains a reporting backchannel of pod status to the master node.

Inside each pod there are containers, kubelet runs these via Docker (pulling images, starting and stopping containers, etc.). It also periodically executes any requested container liveness probes. In addition to Docker, RKT is also supported and the community is actively working to support OCI.

Please note that all Kubernetes nodes have kubelet that ensures that any pod assigned to it are running and configured in desired state.

# Kube-Proxy

Another component of worker nodes is kube-proxy. This is the network brain of the node, maintaining network rules on the host and performing connection forwarding. It’s also responsible for load balancing across all pods in the service.


# Pod: 
- consits of one or more container
- MOst Pods are single container to make it simple

- a pod is a group of one or more containers (such as Docker containers), with shared storage/network. 
- Each pod contains specific information on how the containers should be run. Think of pods as a ring-fenced environment to run containers.
- Pods are also a unit for scaling. If you need to scale an app component up or down, this can be achieved by adding or removing pods.
- It’s possible to run more than one container in a pod (where each share the same IP address and mounted volumes), if they’re tightly coupled.
- Pods are deployed on a single node and have a definite lifecycle. They can be pending, running, succeeding, or failing, but once gone, they are never brought back to life. If a pod dies, a replication controller or other controller must be used to create a new one.


# Services:

- Helps us in finding out more pods.
- You don't need to go to Pods using IP address, instead you go to service, and service route to specifc Pod.
Services are more stable, pods keeping changing
- An object that describes a set of pods that provide a useful service. 
- Services are typically used to define clusters of uniform pods.

# Volume
- Allow to maintain state in the cluster
- keep any info we want
- A Kubernetes abstraction for persistent storage. Kubernetes supports many types of volumes, such as NFS, Ceph, GlusterFS, local directory, etc.

# namespace
- seperating different workload from each other
- You can have 10 developers, give them each namespace...each namespace which shoudnt consume mroe than 2GB RAM.
- This is a tool used to group, separate, and isolate groups of objects. Namespaces are used for access control, network access control, resource management, and quoting

# Ingress rules 
— These specify how incoming network traffic should be routed to services and pods.


# Network policies 

— This defines the network access rules between pods inside the cluster.

# ConfigMaps and Secrets 

— Used to separate configuration information from application definition.

# Controllers 

— These implement different policies for automatic pod management. There are three main types:

1. Deployment — Responsible for maintaining a set of running pods of the same type.

2. DaemonSet — Runs a specific type of pod on each node based on a condition.

3. StatefulSet — Used when several pods of the same type are needed to run in parallel, but each of the pods is required to have a specific identity.

Advance Features:



# ReplicataSet

- Both allows to ensure when you launch pods, I want 5 pods in a cluster, it will ensure we hae 5 pods in a cluster
- Superseded Replication Controller
- More Regex way of selecting the Pods

 

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













