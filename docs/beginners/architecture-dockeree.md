---
layout: default
title: Beginners Track -  Architecture of Docker Enteprise Edition 2.0
description: collabnix | DockerLab | Docker - Beginners Track
---


# Architecture of Docker Enteprise Edition 2.0

## Introduction to Docker EE 2.0

* Docker EE is more than just a container orchestration solution.
* It is a full lifecycle management solution for the modernization of traditional applications and microservices across a broad set of infrastructure platforms. 
* It is a Containers-as-a-Service(CaaS) platform for IT that manages and secures diverse applications across disparate infrastructure, both on-premises and in the cloud. 
* Docker EE provides an integrated, tested and certified platform for apps running on enterprise Linux or Windows operating systems and Cloud providers. 
* It is tightly integrated to the underlying infrastructure to provide a native, easy to install experience and an optimized Docker environment.

![alt text](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/images/b005-arch2.png)

Docker EE 2.0 GA consists of 3 major components which together enable a full software supply chain, from image creation, to secure image storage, to secure image deployment.

## Universal Control Plane 3.0.0 (application and cluster management):

Deploys applications from images, by managing orchestrators, like Kubernetes and Swarm. UCP is designed for high availability (HA). You can join multiple UCP manager nodes to the cluster, and if one manager node fails, another takes its place automatically without impact to the cluster.

## Docker Trusted Registry 2.5.0:

The production-grade image storage solution from Docker.

## EE Engine 17.06.2:

The commercially supported Docker engine for creating images and running them in Docker containers.

## Does Docker EE support Kubernetes?

Yes, Kubernetes in Docker EE fully supports all Docker EE features, including role-based access control, LDAP/AD integration, scanning,  signing enforcement, and security policies.

## Kubernetes features on Docker EE include:

- Kubernetes orchestration full feature set
- CNCF Certified Kubernetes conformance
- Kubernetes app deployment by using web UI or CLI
- Compose stack deployment for Swarm and Kubernetes apps
- Role-based access control for Kubernetes workloads
- Pod-based autoscaling, to increase and decrease pod count based on CPU usage
- Blue-Green deployments, for load balancing to different app versions
- Ingress Controllers with Kubernetes L7 routing
- Interoperability between Swarm and Kubernetes workloads for networking and storage.

## Architecture of Docker EE

![alt text](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/images/b005-arch1.png)

At the base of the architecture, we have Docker Enterprise Engine. All the nodes in the cluster runs Docker Enterprise Edition as the base engine. Currently the stable release is 17.06 EE. It is a lightweight and powerful containerization technology combined with a work flow for building and containerizing your applications.

Sitting on top of the Docker Engine is what we call “Enterprise Edition Stack” where all of these components run as containers(shown below in the picture), except Swarm Mode. Swarm Mode is integrated into Docker Engine and you can turn it on/off based on your choice.Swarm Mode is enabled when Universal Control Plane (UCP) is up & running.

In case you’re new to UCP, Docker Universal Control Plane is a solution designed to deploy, manage and scale Dockerized applications and infrastructure. As a Docker native solution, full support for the Docker API ensures seamless transition of your app from development to test to production – no code changes required, support for the Docker tool-set and compatibility with the Docker ecosystem.

From infrastructure clustering and container scheduling with the embedded Docker Swarm Mode, Kubernetes to multi-container application definition with Docker Compose and image management with Trusted Registry, Universal Control Plane simplifies the process of managing infrastructure, deploying, managing applications and monitoring their activity, with a mix of graphical dashboards and Docker command line driven user interface

There are 3 orchestrators sitting on top of Docker Enterprise Engine – Docker Swarm Mode, Classic Swarm & Kubernetes. For both Classic Swarm and Kubernetes, there is the same underlying etcd instance which is highly available based on setup you have in your cluster.

Docker EE provides access to the full API sets of three popular orchestrators:

![alt text](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/images/b005-arch3.png)

* Kubernetes: Full YAML object support
* SwarmKit: Service-centric, Compose file version 3
* “Classic” Swarm: Container-centric, Compose file version 2

Docker EE proxies the underlying API of each orchestrator, giving you access to all of the capabilities of each orchestrator, along with the benefits of Docker EE, like role-based access control and Docker Content Trust.

To manage lifecycle of orchestrator, we have a component called Agents and reconciler which manages both the promotion and demotion flows as well as certification renewal rotation and deal with patching and upgrading.

Agent is the core component of UCP and is a globally-scheduled service. When you install UCP on a node, or join a node to a swarm that’s being managed by UCP, the agent service starts running on that node. Once this service is running, it deploys containers with other UCP components, and it ensures they keep running. The UCP components that are deployed on a node depend on whether the node is a manager or a worker. In nutshell, it monitors the node and ensures the right UCP services are running.

Another important component is Reconciler. When UCP agent detects that the node is not running the right UCP components, it starts the reconciler container to converge the node to its desired state. It is expected for the UCP reconciler container to remain in an exited state when the node is healthy.

In order to integrate with K8s and support authentication, Docker Team built open ID connect provider. In case you’re completely new to OIDC, OpenID Connect is a simple identity layer on top of the OAuth 2.0 protocol. It allows Clients to verify the identity of the End-User based on the authentication performed by an Authorization Server, as well as to obtain basic profile information about the End-User in an inter-operable and REST-like manner.

As Swarm Mode is designed, we have central certificate authority that manages all the certificates and cryptographic node identity of the cluster. All component uses mutual TLS communication and they are using nodes which are issue by certificate authority. We are using unmodified version of Kubernetes.

Sitting on the top of the stack, there is GUI which uses Swarm APIs and Kubernetes APIs. Right next to GUI, we have Docker Trusted Registry which is an enterprise-ready on-premises service for storing, distributing and securing images. It gives enterprises the ability to ensure secure collaboration between developers and sysadmins to build, ship and run applications. Finally we have Docker & Kubernetes CLI capability integrated. Please note that this uses un-modified version of Kubernetes API.


Contributor:
- Ajeet Singh Raina

[Proceed >>  Architecture of Docker Community Edition](http://dockerlabs.collabnix.com/beginners/arhcitecture-of-docker-ce.html)
