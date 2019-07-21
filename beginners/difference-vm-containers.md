---
layout: default
title: Beginners Track - Difference between Containers and Virtual Machines
description: collabnix | DockerLab | Docker - Beginners Track
---


# Difference between Containers and Virtual Machines

Let us look at the component view of how virtual machines and containers are implemented.



![Component View](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/images/difference-vm-containers.png)

## Virtual Machine

If we closely look at how Virtual Machines are built over the physical hardware, there is a layer of Hypervisor which sits between physical hardware and operating systems. In a broader view, Hypervisor is used to virtualize the hardware which is then configured with the way a user wants it to.

Virtual Machines our physical machine is divided into following parts :-

**Example:**

Say, you are using a system having 8GB RAM. If you create 2 VMs each with 4GB RAM, you are basically dividing your server into two components - each with 4GB RAM and would never be able to use that underlying 8GB RAM altogether again. 

![Component View](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/docker-vs-vm.png)

## Containers

Unlike virtual machines where hypervisor divides physical hardware into parts, Containers are like normal operating system processes. Now the question is, if containers are like normal processes then how come there are isolated from other processes. This is where namespaces come into picture.

Namespaces is an advance concept in linux where each namespace has its own isolated resources without actual partitioning of the underlying hardware. Namesapces are used to virtualize the underlying operating system.

Since containers are nothing other than OS processes, This is the reason why lifting a container takes seconds and lifting a virtual machine takes minutes.

## Conclusion

Prime differnce between Containers and Virtual Machine is the virtualization of *Operating System* and *Hardware* respectively. While using Virtual machine each virtual machine has its own underlying operating system whereas, While using containers, Each container runs on same underlying operating system instance, While underlying OS is the same containers can still have different OS environment in their respective namespace.

## Contributors:

- Ajeet Singh Raina
- Akshit Grover


## Further References

* https://blog.netapp.com/blogs/containers-vs-vms/
* https://www.toptal.com/linux/separation-anxiety-isolating-your-system-with-linux-namespaces 

[Proceed >> Difference between VM Networking & Container Networking](https://collabnix.github.io/dockerlabs/beginners/difference-vmnetwork-docker-networking.html)
