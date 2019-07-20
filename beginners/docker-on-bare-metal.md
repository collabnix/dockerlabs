---
layout: default
title: Beginners Track - Docker On Bare Metal 
description: collabnix | DockerLab | Docker - Beginners Track
---



# Top Reasons WHY TO & WHY NOT TO run Docker containers on Bare Metal System

## Why to run containers on Bare Metal System?

Containers on bare-metal hosts get many of the advantages VMs offer but without the drawbacks of virtualization:

- Gain access to bare-metal hardware in apps without relying on pass-through techniques, because the app processes run on the same OS as 
the host server.
- Have optimal use of system resources. Although you can set limits on how much compute, storage and networking containers can use, they generally don't require these resources to be dedicated to a single container. A host can, therefore, distribute use of shared system resources as needed.
- Get bare-metal performance to apps, because there is no hardware emulation layer separating them from a host server.

In addition, by hosting containers on bare metal, you get the benefits that have traditionally been possible only with VMs:

- Gain the ability to deploy apps inside portable environments that can move easily between host servers.
- Get app isolation. Although containers arguably don't provide the same level of isolation as VMs, containers do enable admins to prevent apps from interacting with one another and to set strict limits on the privileges and resource accessibility associated with each container.

In short, run containers on bare metal to square the circle -- do what seems impossible. Reap all the benefits of bare-metal servers' performance and hardware accessibility, and take advantage of the portability and isolation features seen with VMs.

## WHY NOT TO RUN CONTAINERS ON BARE METAL SYSTEM

You probably are wondering why we don't run all containers on bare metal. Consider the following drawbacks of using bare-metal servers to host a container engine, rather than VMs:

- Physical server upgrades are difficult. To replace a bare-metal server, you must recreate the container environment from scratch on the new server. If the container environment were part of a VM image, you could simply move the image to the new host.

- Most clouds require VMs. There are some bare-metal cloud hosts out there, such as Rackspace's OnMetal offering and Oracle's Bare Metal Cloud Services. But bare-metal servers in cloud computing environments usually cost significantly more -- if the cloud vendor even offers it. By and large, most public cloud providers only offer VMs. If you want to use their platforms to run containers, you'll have to deploy into VMs.

- Container platforms don't support all hardware and software configurations. These days, you can host almost any type of OS on a VM platform such as VMware or a kernel-based VM. And you can run that virtualization platform on almost any kind of OS or server. Docker is more limited and can run only on Linux, certain Windows servers and IBM mainframes if hosted on bare metal. For example, bare-metal servers that run Windows Server 2012 -- which Docker does not currently support -- require a VM on top of the Windows host.

- Containers are OS-dependent. Linux containers run on Linux hosts; Windows containers run on Windows hosts. A bare-metal Windows server requires a Linux VM environment to host Docker containers for an app compiled for Linux. However, there are technological developments in this space (see sidebar).

- Bare-metal servers don't offer rollback features. Most virtualization platforms enable admins to take VM snapshots and roll back to that captured configuration status at a later time. Containers are ephemeral by nature, so there is nothing to roll back to. You might be able to use rollback features built into the host OS or file system, but those are often a less seamless experience. To take advantage of simple system rollback, host containers on a VM.

# Here's a Bonus..


## Linux containers on bare-metal Windows

Historically, there was not an easy, efficient way to run Linux containers on a Windows host. However, Linux Containers on Windows (LCOW) is a tool from Docker that automatically runs Linux containers on a Windows host.

Technically, LCOW needs the Windows host to set up a Hyper-V hypervisor, so the Linux containers actually don't run directly on bare metal inside the Windows environment. However, the hypervisor footprint is miniscule, and the hypervisor is fully managed. Consequently, the performance and management drawbacks associated with hosting containers inside a VM don't exist with LCOW, and the technology removes another historical downside of running containers on bare metal.

## Credits

https://searchitoperations.techtarget.com/tip/Explore-the-benefits-of-containers-on-bare-metal-vs-on-VMs
