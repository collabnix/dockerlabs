---
layout: default
title: Beginners Track - Is Docker technology the same as traditional Linux containers?
description: collabnix | DockerLab | Docker - Beginners Track
---

# Is Docker technology the same as traditional Linux containers?

No. Docker technology was initially built on top of the LXC technology—what most people associate with "traditional” Linux containers—though it’s since moved away from that dependency. LXC was useful as lightweight virtualization, but it didn’t have a great developer or user experience. The Docker technology brings more than the ability to run containers—it also eases the process of creating and building containers, shipping images, and versioning of images (among other things).

![MyImage](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/docker/images/traditional-linux-containers-vs-docker_0.png)

Traditional Linux containers use an init system that can manage multiple processes. This means entire applications can run as one. The Docker technology encourages applications to be broken down into their separate processes and provides the tools to do that. This granular approach has its advantages.

# What is LXC?

LXC is a system container tool. This type of container makes a single Linux system act as many. LXC delivers containers that include a complete Linux system, much like a VM, with its own file system, networking and multiple applications. All three tiers of the web application can share one LXC container, although that's not the intended use. More typically, a user puts the web and application servers into a single LXC container and spins up multiple copies to provide scalability and redundancy. The database then runs in another LXC container and scales independently from the other tiers in the shared container.

Web hosting companies use LXC to provide each customer with independent Linux servers without physical servers dedicated to each one. LXC takes the place of VMs as a lighter resource-consuming option for workload isolation.

LXD is an interface to manage LXC system containers, not a platform or type of container. LXD features include snapshots and image control. It increases the capabilities of LXC technology. For example, with LXD's OpenStack interface, LXC containers act as OpenStack compute resources, without requiring a hypervisor and VMs.

# Is Docker based on LXC?

Docker initially relied on LXC as its container interface, but because LXC provides each container with a full Linux system in an isolated namespace, Docker developed the containerd runtime as a replacement. When comparing Docker vs. LXC, consider the main difference that containerd is only used for single application containers, while LXC is able to run multiple applications inside system containers.

[Proceed > What are Containers? ](https://collabnix.github.io/dockerlabs/beginners/linux-containers.html)
