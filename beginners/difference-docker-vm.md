---
layout: default
title: Beginners Track - Difference between VM vs Docker 
description: collabnix | DockerLab | Docker - Beginners Track
---
# Difference between VM vs Docker

Let us understand this with a simple analogy. 

Virtual machines have a full OS with its own memory management installed with the associated overhead of virtual device drivers. In a virtual machine, valuable resources are emulated for the guest OS and hypervisor, which makes it possible to run many instances of one or more operating systems in parallel on a single machine (or host). Every guest OS runs as an individual entity from the host system. Hence, we can look at it an independent full-fledge house where we don't share any resources as shown below:

![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/docker/images/vm-docker1.png)

In the other hand, Docker containers are executed with the Docker engine rather than the hypervisor. Containers are therefore smaller than Virtual Machines and enable faster start up with better performance, less isolation and greater compatibility possible due to sharing of the host’s kernel. Hence, it looks very similar to residental flats system where we share resources of the building.

![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/docker/images/vm-docker2.png)



![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/docker/images/vm-docker3.png)

 
## Docker Containers versus Virtual Machines:

![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/docker/images/vm-docker4.png)
 
When it comes to comparing the two, it could be said that Docker Containers have much more potential than Virtual Machines. It’s evident as Docker Containers are able to share a single kernel and share application libraries. Containers present a lower system overhead than Virtual Machines and performance of the application inside a container is generally same or better as compared to the same application running within a Virtual Machine.

 
There is one key metric where Docker Containers are weaker than Virtual Machines, and that’s “Isolation”. Intel’s VT-d and VT- x technologies have provided Virtual Machines with ring-1 hardware isolation of which, it takes full advantage. It helps Virtual Machines from breaking down and interfering with each other. Docker Containers yet don’t have any hardware isolation, thus making them receptive to exploits.

![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/docker/images/vm-docker5.png)

 
As compared to virtual machines, containers can be faster and less resource heavy as long as the user is willing to stick to a single platform to provide the shared OS. A virtual machine could take up several minutes to create and launch whereas a container can be created and launched just in a few seconds. Applications contained in containers offer superior performance, compared to running the application within a virtual machine.

 
There is an estimation being done by Docker that application running in a container can go twice as fast as one in a virtual machine. Also, a single server can pack more than one containers as OS is not duplicated for each application.

 
# Virtual Machines and Containers: better together

 
You can sometimes use a hybrid approach which uses both VM and Docker. There are also workloads which are best suited for physical hardware. If both are placed in a hybrid approach, it might lead to a better and efficient scenario. With this Hybrid setup, users can benefit from the advantages if they have workloads that fit the model. 

 
Following are a few of them, that explain how they work together as a Hybrid:

 
1). Docker Containers and Virtual Machines by themselves are not sufficient to operate an application in production. So one should be considering how are the Docker Containers going to run in an enterprise data center.

 
2). Application probability and enabling the accordant provisioning of the application across infrastructure is provided by containers. But other operational requirements such as security, performance and capacity management and various management tool integrations are still a challenge in front of Docker Containers, thus leaving everyone in a big puzzle.

 
3). Security isolation can be equally achieved by both Docker Containers and Virtual Machines.

 
4). Docker Containers can run inside Virtual Machines though they are positioned as two separate technologies and provide them with pros like proven isolation, security properties, mobility, dynamic virtual networking, software-defined storage and massive ecosystem.

 
Apples to apples comparison: On a physical host with a certain configuration and Virtual Machines with the same configuration running an identical running same number of docker Containers with the same performance on both?

 
# Okay. Who's the winner?

 
Answer to this question so far cannot be ascertained but depending upon their configurations and constraints one could say that containers are overcoming virtual machines. Application design is the one standpoint suggesting which one of the two should be chosen. If application is designed to provide scalability and high availability then containers are the best choice else application can be placed in a virtual machine, though Docker containers have surely challenged  virtualization market with containers. Well, keeping the debate aside, it is easy to say that containers in Virtual Machines are twice as robust as one without the other.

[Proceed >> Similarity between Docker & Virtual Machine](https://collabnix.github.io/dockerlabs/beginners/similarity-vm-docker.html)
