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

![alt text](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/beginners/what-is-kubernetes/k8s-architecture.png)

- Master Components - ( Kube API Server + etcd + kube-scheduler + kube-controller-manager + Cloud-controller Manager)
- Node Components - ( Kubelet + Kube-proxy + Container Runtime)
- Addons - ( DNS + WebUI + Container Resource Monitoring + Cluster Level Logging)

## Master Components:

- Master components provide the cluster’s control plane. 
- Master components make global decisions about the cluster (for example, scheduling), and they detect and respond to cluster events (for example, starting up a new pod when a replication controller’s replicas field is unsatisfied).
- Master components can be run on any machine in the cluster. However, for simplicity, set up scripts typically start all master components on the same machine, and do not run user containers on this machine. See Building High-Availability Clusters for an example multi-master-VM setup

## Kubectl:

- A CLI tool for Kubernetes

![alt text](https://github.com/ajeetraina/kubernetes101/blob/master/architecture/kubernetes-kubectl.png)



## Master Node:

![alt text](https://github.com/ajeetraina/kubernetes101/blob/master/architecture/kubernetes-kubelet.png)

- The main machine that controls the nodes
- Main entrypoint for all administrative tasks
- It handles the orchestration of the worker nodes



## Worker Node

![alt text](https://github.com/ajeetraina/kubernetes101/blob/master/architecture/kubernetes-worker-node.png)

- It is a worker machine in Kubernetes (used to be known as minion)
- This machine performs the requested tasks. Each Node is controlled by the Master Node
- Runs containers inside pods
- This is where the Docker engine runs and takes care of downloading images and starting containers

## Kubelet

![alt text](https://github.com/ajeetraina/kubernetes101/blob/master/architecture/kubernetes-kubelet.png)

- Primary node agent
- Ensures that containers are running and healthy

## Kubernetes Pod:

- A Pod can host multiple containers and storage volumes
- Pods are instances of Deployments (see Deployment)
- One Deployment can have multiple pods
- With Horizontal Pod Autoscaling, Pods of a Deployment can be automatically started and halted based on CPU usage
- Containers within the same pod have access to shared volumes
- Each Pod has its unique IP Address within the cluster
- Pods are up and running until someone (or a controller) destroys them
- Any data saved inside the Pod will disappear without a persistent storage

![alt text](https://github.com/ajeetraina/kubernetes101/blob/master/architecture/kubernetes-pod-new.png)


## Deployment:

- A deployment is a blueprint for the Pods to be create (see Pod)
- Handles update of its respective Pods.
- A deployment will create a Pod by it’s spec from the template.
- Their target is to keep the Pods running and update them (with rolling-update) in a more controlled way.
- Pod(s) resource usage can be specified in the deployment.
- Deployment can scale up replicas of Pods.
- kubernetes-deployment

![alt text](https://github.com/ajeetraina/kubernetes101/blob/master/architecture/kubernetes-deployment%20(1).png)

![alt text](https://github.com/ajeetraina/kubernetes101/blob/master/architecture/kubernetes-deployment%20(1).png)

## Secret:

- A Secret is an object, where we can store sensitive informations like usernames and passwords.
- In the secret files, values are base64 encoded.
- To use a secret, we need to refer to the secret in our Pod.
- Or we can put it inside a volume and mount that to the container.
- Secrets are not encrypted by default. For encryption we need to create an EncryptionConfig.
- You can read more about encryption here

## Service:

- A service is responsible for making our Pods discoverable inside the network or exposing them to the internet
- A Service identifies Pods by its LabelSelector
- There are 3 types of services:

## ClusterIP:
- The deployment is only visible inside the cluster
- The deployment gets an internal ClusterIP assigned to it
- Traffic is load balanced between the Pods of the deployment

## Node Port:
- The deployment is visible inside the cluster
- The deployment is bound to a port of the Master Node
- Each Node will proxy that port to your Service
- The service is available at http(s)://:/
- Traffic is load balanced between the Pods of the deployment

## Load Balancer:
- The deployment gets a Public IP address assigned
- The service is available at http(s)://:<80||42>/
- Traffic is load balanced between the Pods of the deployment

## Credits:
- https://blog.risingstack.com/what-is-kubernetes-how-to-get-started/

