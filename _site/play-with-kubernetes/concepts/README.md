# Demystifying Kubernetes Architecture

## What is Kubernetes?

Kubernetes (often abbreviated to K8S), is a container orchestration platform for applications that run on containers.
Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications.
It groups containers that make up an application into logical units for easy management and discovery. 

At a minimum, Kubernetes can schedule and run application containers on clusters of physical or virtual machines. 
However, Kubernetes also allows developers to ‘cut the cord’ to physical and virtual machines, moving from a host-centric infrastructure to a container-centric infrastructure, which provides the full advantages and benefits inherent to containers. 
Kubernetes provides the infrastructure to build a truly container-centric development environment.

K8s provides a rich set of features for container grouping, container orchestration, health checking, service discovery, load balancing, horizontal autoscaling, secrets & configuration management, storage orchestration, resource usage monitoring, CLI, and dashboard.

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

The API server exposes four APIs; Kubernetes API, Extensions API, Autoscaling API, and Batch API. These are used for communicating with the Kubernetes cluster and executing container cluster operations.

# Kube-Controller Manager

Also known as the “kube-controller manager,” this runs all the controllers that handle routine tasks in the cluster. These include the Node Controller, Replication Controller, Endpoints Controller, and Service Account and Token Controllers. Each of these controllers works separately to maintain the desired state.

Kube-controller manager will always look after your cluster and runs new command which you run against the API server
Ensures that any workload you schedule it finds free nodes and then schedule workload on that node.

Controller manager monitors the current state of the applications deployed on Kubernetes via the API server and makes sure that it meets the desired state.

# Kube-Scheduler

The scheduler watches for newly-created pods (groups of one or more containers) and assigns them to nodes.

Please note that all Kubernetes nodes have kubelet that ensures that any pod assigned to it are running and configured in desired state.

The Scheduler’s responsibility is to monitor the resource usage of each node and scheduling containers according to resource availability.

# etcd 

etcd is a key/value store implemented by CoreOS. Kubernetes uses that as the persistence storage of all of its API objects

## Kubernetes Worker Nodes

The second important component under the hood are nodes. Whereas the master handles and manages the cluster, worker nodes run the containers and provide the Kubernetes runtime environment.

Worker nodes comprise a kubelet. This is the primary node agent. It watches the API server for pods that have been assigned to its node. Kubelet carries out tasks and maintains a reporting backchannel of pod status to the master node.

Inside each pod there are containers, kubelet runs these via Docker (pulling images, starting and stopping containers, etc.). It also periodically executes any requested container liveness probes. In addition to Docker, RKT is also supported and the community is actively working to support OCI.

Please note that all Kubernetes nodes have kubelet that ensures that any pod assigned to it are running and configured in desired state.


In each Kubernetes node following components are installed:

# Kubelet -
 
Kubelet is the agent that runs on each node. It makes use of the pod specification for creating containers and managing them.


# Kube-Proxy

Another component of worker nodes is kube-proxy. This is the network brain of the node, maintaining network rules on the host and performing connection forwarding. It’s also responsible for load balancing across all pods in the service.

Kube-proxy runs in each node for load balancing pods. It uses iptable rules for doing simple TCP, UDP stream forwarding or round robin TCP, UDP forwarding.


# Important Note:

A Kubernetes production deployment may need multiple master nodes and a separate etcd cluster for high availability. Kubernetes make use of an overlay network for providing networking capabilities similar to a virtual machine-based environment. It allows container-to-container communication throughout the cluster and will provide unique IP addresses for each container. If such a software defined network (SDN) is not used, the container runtimes in each node will have an isolated network and subsequently the above networking features will not be available. This is one of the key advantages of Kubernetes over other container cluster management solutions, such as Apache Mesos.




# Pod - Container Grouping 

- Pods are a set of containers on a single docker host
- Each pod is assigned an IP address 
- Communication between pods is performed via a proxy, which is the abstraction layer offering the pod’s IP address from outside
- consits of one or more container
- MOst Pods are single container to make it simple

- a pod is a group of one or more containers (such as Docker containers), with shared storage/network. 
- Each pod contains specific information on how the containers should be run. Think of pods as a ring-fenced environment to run containers.
- Pods are also a unit for scaling. If you need to scale an app component up or down, this can be achieved by adding or removing pods.
- It’s possible to run more than one container in a pod (where each share the same IP address and mounted volumes), if they’re tightly coupled.
- Pods are deployed on a single node and have a definite lifecycle. They can be pending, running, succeeding, or failing, but once gone, they are never brought back to life. If a pod dies, a replication controller or other controller must be used to create a new one.

A pod [2] is a group of containers that share the storage, users, network interfaces, etc. using Linux namespaces (ipc, uts, mount, pid, network and user), cgroups, and other kernel features. This facilitates creating composite applications while preserving the one application per container model. Containers in a pod share an IP address and the port space. They can find each other using localhost and communicate using IPC technologies like SystemV semaphores or POSIX shared memory. A sample composition of a pod would be an application server container running in parallel with a Logstash container monitoring the server logs using the same filesystem.


#ReplicaSets(formerly called Replication Controller)

- A replication controller is a logical entity that creates and manages pods. 
- It uses a pod template for defining the container image identifiers, ports, and labels. 
- Replication controllers auto heal pods according to the given health checks. 
- These health checks are called liveness probes. 
- Replication controllers support manual scaling of pods, and this is handled by the replica count.



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

# What is Kubectl?

kubectl is the client talking to a REST API, which in turn talks to the kublet info service, which in turn talks to the pods via local kublet agents.

# Health Checking

In reality, software applications fail due to many reasons; undiscovered bugs in the code, resource limitations, networking issues, infrastructure problems, etc. Therefore, monitoring software application deployments is essential. Kubernetes provides two main mechanisms for monitoring applications. This is done via the Kubelet agent:

1. Process Health Checking: Kubelet continuously checks the health of the containers via the Docker daemon. If a container process is not responding, it will get restarted. This feature is enabled by default and it’s not customizable.

2. Application Health Checking: Kubernetes provides three methods for monitoring the application health, and these are known as health checking probes:

HTTP GET: If the application exposes an HTTP endpoint, an HTTP GET request can be used for checking the health status. The HTTP endpoint needs to return a HTTP status code between 200 and 399, for the application to be considered healthy.

Container Exec: If not, a shell command can be used for this purpose. This command needs to return a zero to application to be considered healthy.

TCP Socket: If none of the above works, a simple TCP socket can also be used for checking the health status. If Kubelet can establish a connection to the given socket, the application is considered healthy.

# Service Discovery and Load Balancing

- A Kubernetes service provides a mechanism for load balancing pods. 
- It is implemented using kube-proxy and internally uses iptable rules for load balancing at the network layer. 
- Each Kubernetes service exposes a DNS entry via Sky DNS for accessing the services within the Kubernetes internal network. 
- A Kubernetes service can be implemented as one of the following types:

ClusterIP: This type will make the service only visible to the internal network for routing internal traffic.

NodeIP: This type will expose the service via node ports to the external network. 
Each port in a service will be mapped to a node port and those will be accessible via <node-ip>:<node-port>.

Load Balancer: If services need to be exposed via a dynamic load balancer the service type can be set to Load Balancer. This feature is enabled by the underlying cloud provider (example: GCE).

# Automated Rollouts and Rollbacks

This is one of the distinguishing features of Kubernetes that allows users to do a rollout of a new application version without a service outage. Once an application is deployed using a replication controller, a rolling update can be triggered by packaging the new version of the application to a new container image. The rolling update process will create a new replication controller and rollout one pod at a time using the new replication controller created. The time interval between a pod replacement can be configured. Once all the pods are replaced the existing replication controller will be removed.
A kubectl CLI command can be executed for updating an existing WSO2 ESB deployment via a rolling update. The following example updates an ESB cluster created using Docker image wso2esb:4.9.0-v1 to wso2esb:4.9.0-v2:

```
$ kubectl rolling-update my-wso2esb — image=wso2esb:4.9.0-v2
```

Similarly, an application update done via a rolling update can be rolled back if 

Similarly, an application update done via a rolling update can be rolled back if needed. The following sample command would rollback wso2esb:4.9.0-v2 to wso2esb:4.9.0-v1 assuming that its previous state was 4.9.0-v1:

```
$ kubectl rolling-update my-wso2esb — rollback
```

# Horizontal Autoscaling

Horizontal Pod Autoscalers provide autoscaling capabilities for pods. It does this by monitoring health statistics sent by the cAdvisor. A cAdvisor instance runs in each node and provides information on CPU, memory, and disk usage of containers. These statistics get aggregated by Heapster and get accessible via the Kubernetes API server. Currently, horizontal autoscaling is only available based on CPU usage, and an initiative is in progress to support custom metrics.

# Secret and Configuration Management

Applications that run on pods may need to contain passwords, keys, and other sensitive information. Packaging them with the container image may lead to security threats. Technically, anyone who gets access to the container image will be able to see all of the above. Kubernetes provides a much more secure mechanism to send this sensitive information to the pods at the container startup without packaging them in the container image. These entries are called secrets. For example, a secret can be created via the secret API for storing a database password of a web application. Then the secret name can be given in the replication controller to let the pods access the actual value of the secret at the container startup.
Kubernetes uses the same method for sending the token needed for accessing the Kubernetes API server to the pods. Similarly, Kubernetes supports sending configuration parameters to the pods via ConfigMap API. Both secrets and config key/value pairs can be accessed inside the container either using a virtual volume mount or using environment variables.

# Storage Orchestration

Docker supports mounting storage systems to containers using container host storage or network storage systems [11]. Kubernetes provides the same functionality via the Kubernetes API and supports NFS, iSCSI, Gluster, Ceph, Cinder, or Flocker.

# Providing Well Known Ports for Kubernetes Services

- Kubernetes provides a mechanism for adding a proxy server for Kubernetes services. This feature is known as Ingress [3]. 
-  The main advantage of this is the ability to expose Kubernetes services via well-known ports, such as 80, 443. An ingress controller listens to Kubernetes API, generates a proxy configuration in runtime whenever a service is changed, and reloads the Nginx configuration. 
- It can expose any given port via a Docker host port. Clients can send requests to one of the Kubernetes node IPs, Nginx port and those will get redirected to the relevant service. 
- The service will do round robin load balancing in the network layer.
The service can be identified using an URL context or hostname;
https://node-ip/foo/, https://foo.bar.com/

# Sticky Session Management Using Service Load Balancers

Similar to ingress controllers, Kubernetes provides another mechanism for load balancing pods using third-party load balancers. These are known as service load balancers. Unlike ingress, service load balancers don’t route requests to services, rather they are dispatched directly to the pods. The main advantage of this feature is the ability to provide sticky session management at the load balancer

# Resource Usage Monitoring

Kubernetes uses cAdvisor [5] for monitoring containers in each node. It provides information on CPU usage, memory consumption, disk usage, network statistics, etc. A component called Heapster [6] aggregates above data and makes them available via Kubernetes API. Optionally, data can be written to a data store and visualized via a UI. InfluxDB, Grafana and Kube-UI can be used for this purpose [7].

# Kubernetes Dashboard

Kubernetes dashboard provides features for deploying and monitoring applications. Any server cluster can be deployed by specifying a Docker image ID and required service ports. Once deployed, server logs can be viewed via the same UI.








