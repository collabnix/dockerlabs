# What is Kubernetes?


- Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications.
- It groups containers that make up an application into logical units for easy management and discovery. 
- Kubernetes builds upon 15 years of experience of running production workloads at Google, combined with best-of-breed ideas and practices from the community.
- Kubernetes is a portable, extensible, open-source platform for managing containerized workloads and services, that facilitates both declarative configuration and automation. 
- It has a large, rapidly growing ecosystem. Kubernetes services, support, and tools are widely available

- Kubernetes (commonly referred to as K8s) is an orchestration engine for container technologies such as Docker and rkt that is taking over the DevOps scene in the last couple of years. It is already available on Azure and Google Cloud as a managed service.

- Kubernetes can speed up the development process by making easy, automated deployments, updates (rolling-update) and by managing our apps and services with almost zero downtime. It also provides self-healing. Kubernetes can detect and restart services when a process crashes inside the container. Kubernetes is originally developed by Google, it is open-sourced since its launch and managed by a large community of contributors.

Any developer can package up applications and deploy them on Kubernetes with basic Docker knowledge.

# Why Kubernetes?

## Traditional deployment era: 

Early on, organizations ran applications on physical servers. There was no way to define resource boundaries for applications in a physical server, and this caused resource allocation issues. For example, if multiple applications run on a physical server, there can be instances where one application would take up most of the resources, and as a result, the other applications would underperform. A solution for this would be to run each application on a different physical server. But this did not scale as resources were underutilized, and it was expensive for organizations to maintain many physical servers.

## Virtualized deployment era: 

As a solution, virtualization was introduced. It allows you to run multiple Virtual Machines (VMs) on a single physical server’s CPU. Virtualization allows applications to be isolated between VMs and provides a level of security as the information of one application cannot be freely accessed by another application.

Virtualization allows better utilization of resources in a physical server and allows better scalability because an application can be added or updated easily, reduces hardware costs, and much more.

Each VM is a full machine running all the components, including its own operating system, on top of the virtualized hardware.

## Container deployment era: 

Containers are similar to VMs, but they have relaxed isolation properties to share the Operating System (OS) among the applications. Therefore, containers are considered lightweight. Similar to a VM, a container has its own filesystem, CPU, memory, process space, and more. As they are decoupled from the underlying infrastructure, they are portable across clouds and OS distributions.

Containers are becoming popular because they have many benefits. Some of the container benefits are listed below:

- Agile application creation and deployment: increased ease and efficiency of container image creation compared to VM image use.
- Continuous development, integration, and deployment: provides for reliable and frequent container image build and deployment with quick and easy rollbacks (due to image immutability).
- Dev and Ops separation of concerns: create application container images at build/release time rather than deployment time, thereby decoupling applications from infrastructure.
- Observability not only surfaces OS-level information and metrics, but also application health and other signals.
- Environmental consistency across development, testing, and production: Runs the same on a laptop as it does in the cloud.
- Cloud and OS distribution portability: Runs on Ubuntu, RHEL, CoreOS, on-prem, Google Kubernetes Engine, and anywhere else.
- Application-centric management: Raises the level of abstraction from running an OS on virtual hardware to running an application on an OS using logical resources.
- Loosely coupled, distributed, elastic, liberated micro-services: applications are broken into smaller, independent pieces and can be deployed and managed dynamically – not a monolithic stack running on one big single-purpose machine.
- Resource isolation: predictable application performance.
- Resource utilization: high efficiency and density

# What is K8s made up of?

![alt text](https://raw.githubusercontent.com/collabnix/dockerlabs/master/kubernetes/beginners/what-is-kubernetes/k8s-architecture.png)

Kubernetes Cluster is primarily made up of following components
- Master:
    - Kube API Server
    - Control Plane (kube-scheduler + kube-controller-manager + Cloud-controller Manager)
    - Etcd
    
- Node:
    - Kubelet
    - Kube-proxy
    - Container Runtime
    
- Addons:
   - DNS 
   - WebUI 
   - Container Resource Monitoring
   - Cluster Level Logging


# Kubernetes Cluster Components

## Master Node and its Components:

![alt text](https://raw.githubusercontent.com/ajeetraina/kubernetes101/master/architecture/kubernetes-kubelet.png)

- The main machine that controls the nodes
- Main entrypoint for all administrative tasks
- It handles the orchestration of the worker nodes


```
[node1 install]$ kubectl get componentstatus
NAME                 STATUS    MESSAGE             ERROR
scheduler            Healthy   ok
controller-manager   Healthy   ok
etcd-0               Healthy   {"health":"true"}
```

- K8s may have 1 or more master.
- Master components provide the cluster’s control plane. 
- Master components make global decisions about the cluster (for example, scheduling), and they detect and respond to cluster events (for example, starting up a new pod when a replication controller’s replicas field is unsatisfied).
- Master components can be run on any machine in the cluster. However, for simplicity, set up scripts typically start all master components on the same machine, and do not run user containers on this machine. See Building High-Availability Clusters for an example multi-master-VM setup

### The Kube API Server

Kubernetes architecture consists of one or more master machine. 

The Kube API server is the main component and everything in kubernetes cluster will connect and talk to this API Server.
Component on the master that exposes the Kubernetes API. It is the front-end for the Kubernetes control plane.It is designed to scale horizontally – that is, it scales by deploying more instances. 

### The etcd

- Store the information abou k8s cluster
- A very important component in the entire cluster
- if you loose etcd, you will loose the whole cluster
- You can use separate etcd too.
- Consistent and highly-available key value store used as Kubernetes’ backing store for all cluster data.
- If your Kubernetes cluster uses etcd as its backing store, make sure you have a back up plan for those data.


### Kube Scheduler

- Decide where to start the workload, on which node should it start the application
- Component on the master that watches newly created pods that have no node assigned, and selects a node for them to run on.
- Factors taken into account for scheduling decisions include:
    - individual and collective resource requirements, 
    - hardware/software/policy constraints, 
    - affinity and anti-affinity specifications, 
    - data locality, 
    - inter-workload interference and 
    - deadlines

### Kube-controller-manager

- Component on the master that runs controllers .
- Logically, each controller is a separate process, but to reduce complexity, they are all compiled into a single binary and run in a single process.
- These controllers include:
   - Node Controller: Responsible for noticing and responding when nodes go down.
   - Replication Controller: Responsible for maintaining the correct number of pods for every replication controller object in the system.
   - Endpoints Controller: Populates the Endpoints object (that is, joins Services & Pods).
   - Service Account & Token Controllers: Create default accounts and API access tokens for new namespaces.
   - cloud-controller
   
### Cloud-controller-manager
 
- cloud-controller-manager runs controllers that interact with the underlying cloud providers. 
- The cloud-controller-manager binary is an alpha feature introduced in Kubernetes release 1.6.
- cloud-controller-manager runs cloud-provider-specific controller loops only. 
- You must disable these controller loops in the kube-controller-manager. 
- You can disable the controller loops by setting the --cloud-provider flag to external when starting the kube-controller-manager.
- cloud-controller-manager allows the cloud vendor’s code and the Kubernetes code to evolve independently of each other. 
- In prior releases, the core Kubernetes code was dependent upon cloud-provider-specific code for functionality. 
- In future releases, code specific to cloud vendors should be maintained by the cloud vendor themselves, and linked to cloud-controller-manager while running Kubernetes.


## Worker Node and its components:


![alt text](https://raw.githubusercontent.com/ajeetraina/kubernetes101/master/architecture/kubernetes-worker-node.png)

- It is a worker machine in Kubernetes (used to be known as minion)
- This machine performs the requested tasks. Each Node is controlled by the Master Node
- Runs containers inside pods
- This is where the Docker engine runs and takes care of downloading images and starting containers

### KubeProxy
- `kube-proxy` is a network proxy that runs on each node in the cluster.
- `Kube-proxy` is responsible for request forwarding. kube-proxy allows TCP and UDP stream forwarding or round robin TCP and UDP forwarding across a set of backend functions.


### Kubelet
- An agent that runs on each node in the cluster. It makes sure that containers are running in a pod.
- The kubelet takes a set of PodSpecs that are provided through various mechanisms and ensures that the containers described in those PodSpecs are running and healthy.
- Kubelet does not manage the container which are not created by Kubernetes .

![alt text](https://raw.githubusercontent.com/ajeetraina/kubernetes101/master/architecture/kubernetes-kubelet.png)


### Container Runtime
- The container runtime is the software that is responsible for running containers.
- Kubernetes supports several container runtimes: Docker, containerd etc.
- Docker is the most common container runtime that is used in many Kubernetes Clusters.


## Kubernetes Constructs: 

### Kubectl:

- A CLI tool for Kubernetes

![alt text](https://raw.githubusercontent.com/ajeetraina/kubernetes101/master/architecture/kubernetes-kubectl.png)


### Kubernetes Pod:

- A Pod can host multiple containers and storage volumes
- Pods are instances of Deployments (see Deployment)
- One Deployment can have multiple pods
- With Horizontal Pod Autoscaling, Pods of a Deployment can be automatically started and halted based on CPU usage
- Containers within the same pod have access to shared volumes
- Each Pod has its unique IP Address within the cluster
- Pods are up and running until someone (or a controller) destroys them
- Any data saved inside the Pod will disappear without a persistent storage

![alt text](https://raw.githubusercontent.com/ajeetraina/kubernetes101/master/architecture/kubernetes-pod-new.png)

### ReplicaSet
- A Repliaset runs `n` number of pods , based on the provided kubernetes object template.
- A ReplicaSet ensures that a specified number of pod replicas are running at any given time.
- If one pod dies or crashes , the ReplicaSet ensures a new one is created in its place .
- A Deployment ( explained below ) is a higher level construct that manages replicasets. As per K8S recommendation , Deployments should be used over ReplicaSets

### Deployment:

![alt text](https://raw.githubusercontent.com/collabnix/dockerlabs/master/kubernetes/beginners/what-is-kubernetes/k8s_deployment.png)

- A deployment is a blueprint for the Pods to be create (see Pod)
- Handles update of its respective Pods.
- A deployment will create a Pod by it’s spec from the template.
- Their target is to keep the Pods running and update them (with rolling-update) in a more controlled way.
- Pod(s) resource usage can be specified in the deployment.
- Deployment can scale up replicas of Pods.
- kubernetes-deployment

![alt text](https://raw.githubusercontent.com/ajeetraina/kubernetes101/master/architecture/kubernetes-deployment%20(1).png)

![alt text](https://raw.githubusercontent.com/ajeetraina/kubernetes101/master/architecture/kubernetes-deployment%20(1).png)


### ConfigMap
- A ConfigMap binds configuration files , command-line , arguments, environment variables and other configuration artifacts to your Pods.
- ConfigMaps allow you to separate your configurations from Pods and components, which helps keep the workloads portable, makes their configurations easier to change and manage.
- ConfigMaps are useful for storing and sharing non-sensitive, unencrypted configuration information.
 
### Secret:

- A Secret is an object, where we can store sensitive informations like usernames and passwords.
- In the secret files, values are base64 encoded.
- To use a secret, we need to refer to the secret in our Pod.
- Or we can put it inside a volume and mount that to the container.
- Secrets are not encrypted by default. For encryption we need to create an EncryptionConfig.
- You can read more about encryption here

### Service:

![alt text](https://raw.githubusercontent.com/collabnix/dockerlabs/master/kubernetes/beginners/what-is-kubernetes/k8s-service.png)

- A service is responsible for making our Pods discoverable inside the network or exposing them to the internet
- A Service identifies Pods by its LabelSelector
- There are 3 types of services:

### ClusterIP:
- The deployment is only visible inside the cluster
- The deployment gets an internal ClusterIP assigned to it
- Traffic is load balanced between the Pods of the deployment

### Node Port:
- The deployment is visible inside the cluster
- The deployment is bound to a port of the Master Node
- Each Node will proxy that port to your Service
- The service is available at http(s)://:/
- Traffic is load balanced between the Pods of the deployment

### Load Balancer:
- The deployment gets a Public IP address assigned
- The service is available at http(s)://:<80||42>/
- Traffic is load balanced between the Pods of the deployment

## Credits:
- [Link-1](https://blog.risingstack.com/what-is-kubernetes-how-to-get-started/)
- [Link-2](https://matthewpalmer.net/kubernetes-app-developer/articles/kubernetes-deployment-tutorial-example-yaml.html)

