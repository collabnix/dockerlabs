## Kubernetes Architecture

- Kubernetes is a sophisticated platform consisting of various components that enables us to run production-ready container applications robustly and reliably. It is crucial to learn about its architecture and design to understand how it works and why it is so successful. Kubernetes is designed to run applications on clusters on the cloud or on-premise systems. Virtual or physical server instances are used with a shared network in these clusters to operate in harmony. This is the actual environment where all Kubernetes components and user applications are configured and run.

- Servers in a Kubernetes cluster are given two essential roles: master or node. If a server is assigned with the master role, it is expected to run centralized logical components of Kubernetes. It is possible to have more than one master server to achieve high availability, and the master servers run the Kubernetes API server, key/value store, scheduler, and controllers. These components create the brain of Kubernetes that interacts with the outside world and makes decisions based on the changes in the cluster or user demands. Other servers in the clusters are assigned the node role to run the workload as containers. Node servers receive the definition of the workload from the master and create, update, or delete the containers accordingly. In addition, nodes form the required networking and storage for the containers and forward the traffic between them.

- Kubernetes with master and node components work on the desired state of applications provided by the Kubernetes API. For example, it is possible to send a declarative JSON or YAML definition of a workload to the Kubernetes API in master servers. Master components enrich these definitions for the required storage, networking, and computing resources and these are then sent to nodes for execution. Node instances execute the plan by running containerized applications and checking application statuses continuously. To sum up, the Kubernetes cluster tries to achieve the desired state, defined in JSON or YAML, by changing and testing the actual state. In the following sections, components in the master and node servers are described in more detail, as
 ![](https://raw.githubusercontent.com/collabnix/dockerlabs/master/kubernetes/workshop/img/KubernetesArchitecture.jpg)

## Master Components

Master components of Kubernetes, also called the control plane, is the primary set of services that provide the API operations, authentication, scheduling, and networking. It is possible to install these components on a single server or distribute across servers. Control plane components and their interaction with each other are as follows:

## etcd

etcd is the data store of Kubernetes where all configuration, runtime information, and statuses are stored. The actual statuses and the desired states of resources are stored in etcd, which is the only stateful component in the master components. etcd is an open source key/value store developed by CoreOS, and is one of the crucial components that make Kubernetes reliable. etcd can be installed in multiple master servers, as well as being reachable inside the Kubernetes cluster.

## kube-apiserver

The API server is the central management interface in the Kubernetes cluster for user interactions and status information. It is possible to send and receive data from kube-apiserver, since it is a RESTful API server. Every workload definition is sent to this API server, and it handles the storing the data in etcd. Since Kubernetes is an API-driven platform, kube-apiserver is the most critical component in the control plane.

## kube-controller-manager

The controller is a general pattern in Kubernetes to manage the life cycle of resources. Controllers are expected to read the new information when a change is seen. Then, they implement the required changes to achieve the desired state. For instance, when an application is scaled up by the user, the data is sent to kube-apiserver and persisted in etcd. The controller manager of the corresponding resource handles the creation of additional instances. kube-controller-manager consists of such controllers to manage the Kubernetes resources.

## kube-scheduler

The scheduler is responsible for assigning workload containers to the nodes, taking into account capacity, requirements, and the infrastructure environment. It can be regarded as a continuous loop for checking unassigned workloads and finding appropriate nodes.

## cloud-controller-manager

Kubernetes is designed to be installed into any cloud provider that implements required interfaces. It is possible to run Kubernetes on AWS, Google Cloud, Azure, Alibaba Cloud, or on-premise OpenStack systems. Cloud controller managers are the set of bridges that connect Kubernetes resources to the cloud providers. For instance, they manage the storage and networking requirements based on the cloud environment. It is possible to have portable and robust applications running in Kubernetes with the help of cloud controller managers.

## Node Components

Node components are responsible for running workloads in Kubernetes. Thus, it is expected to manage containers, networking, and storage operations of the workload assigned to the node. Node components and their interaction with the control plane are as follows:

## Container runtime

The container runtime is required to run the workload as containers in the node servers. It is expected to implement the Container Runtime Interface (CRI) and Docker, rkt, and runc, which are the notable container runtimes for Kubernetes environment. The main functionality of the container runtime is to start, check the status, and delete containers according to the desired state in Kubernetes.

## kubelet

kubelet is the primary service running on the servers that collect information from the control plane and manage the resources in the node. It is expected that kubelet will communicate with the control plane to get desired states and send commands to the container runtime to convert the actual state into the desired one.

## kube-proxy

kube-proxy is the service responsible for networking on the node servers. Since containers and the host system are isolated in terms of networking, this is the service that forwards requests to the containers and makes them reachable from the outside world.
