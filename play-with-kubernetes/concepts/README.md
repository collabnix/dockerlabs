# Demystifying Kubernetes Architecture

## What is Kubernetes?

Kubernetes (often abbreviated to K8S), is a container orchestration platform for applications that run on containers.
Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications.
It groups containers that make up an application into logical units for easy management and discovery. 

At a minimum, Kubernetes can schedule and run application containers on clusters of physical or virtual machines. 
However, Kubernetes also allows developers to ‘cut the cord’ to physical and virtual machines, moving from a host-centric infrastructure to a container-centric infrastructure, which provides the full advantages and benefits inherent to containers. 
Kubernetes provides the infrastructure to build a truly container-centric development environment.

IMPORTANT NOTES:

1.Kubernetes operates at the application level rather than at the hardware level
2.Kubernetes is not monolithic, and these default solutions are optional and pluggable.
3.Additionally, Kubernetes is not a mere orchestration system. 


In fact, it eliminates the need for orchestration. 
The technical definition of orchestration is execution of a defined workflow: first do A, then B, then C. 
In contrast, Kubernetes is comprised of a set of independent, composable control processes that continuously drive the 
current state towards the provided desired state. 
It shouldn’t matter how you get from A to C. 
Centralized control is also not required; the approach is more akin to choreography. 
This results in a system that is easier to use and more powerful, robust, resilient, and extensible.

4. Kubernetes aims to support an extremely diverse variety of workloads, including stateless, stateful, and 
data-processing workloads.If an application can run in a container, it should run great on Kubernetes.

5. Allows users to choose their logging, monitoring, and alerting systems. (It provides some integrations as proof of concept.)
6. Kubernetes is designed to serve as a platform for building an ecosystem of components and tools to make it easier to deploy,
 scale, and manage applications.
7.

