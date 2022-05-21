# What is Virtualization

Virtualization is the process of creating a software-based, or virtual, representation of something, such as virtual applications, servers, storage and networks. It is the single most effective way to reduce IT expenses while boosting efficiency and agility for all size businesses.

## Virtual Machines

A VM is a tightly isolated software container with an operating system and application inside. Each self-contained VM is completely independent. Putting multiple VMs on a single computer enables several operating systems and applications to run on just one physical server, or “host.”

A thin layer of software called a _“hypervisor”_ decouples the virtual machines from the host and dynamically allocates computing resources to each virtual machine as needed.

## What is a container

Containers use lightweight operating system level virtualization and multiple containers can run on the same host machine. However, containers do not have their own kernel. They share the host machine’s kernel, making them much smaller in size compared to virtual machines. They use process level isolation, allowing processes inside a container to be isolated from other containers.

## Dcoker Containers

The original Linux container technology is Linux Containers(LXC). LXC is a Linux operating system level virtualization method for running multiple isolated Linux systems on a single host. Namespaces and cgroups make LXC possible.

Docker, which started as a project to build single-application LXC containers, introduced several significant changes to LXC that make containers more portable and flexible to use.

Docker is a Linux utility that can efficiently create, ship, and run containers.

Both Docker and LXC containers are user-space lightweight virtualization mechanisms that implement cgroups and namespaces to manage resource isolation.

![Docker containers are Linux containers](https://user-images.githubusercontent.com/16256583/40974249-9daf21d2-68e4-11e8-8f11-85c5c03b41ac.jpg)

**Docker** is an open source tool that lets you to incorporate and store your code and its dependencies into a handy package called an image.

![virtual machine](https://user-images.githubusercontent.com/16256583/40974242-974095ce-68e4-11e8-9d2e-82a2829f718d.jpg)

## Virtual Machines V/S Containers

![vmcont](https://user-images.githubusercontent.com/16256583/40974226-895ccda6-68e4-11e8-800b-78586becb2b1.JPG)

[[Next Intro to Dockerfile]](https://github.com/ajeetraina/docker101/blob/master/beginners/intro-to-dockerfile-003.md)
