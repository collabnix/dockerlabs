---
layout: default
title: Beginners Track - What is Docker?
description: collabnix | DockerLab | Docker - Beginners Track
---

# What is Docker?

![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/docker/images/dockerinc.jpg)


In 2019, "DOCKER" refers to several things. This includes an open source community project which started in 2013; tools from the open source project; Docker Inc., the company that is the primary supporter of that project; and the tools that the company formally supports. 

![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/docker/images/docker_facebook_share.png)

Here's a quick explanation:

- The IT software "Docker” is containerization technology that enables the creation and use of Linux® containers.
- The open source Docker community works to improve these technologies to benefit all users—freely.
- The company, Docker Inc., builds on the work of the Docker community, makes it more secure, and shares those advancements back to the greater community. It then supports the improved and hardened technologies for enterprise customers.

With DOCKER, you can treat containers like extremely lightweight, modular virtual machines. And you get flexibility with those containers—you can create, deploy, copy, and move them from environment to environment, which helps optimize your apps for the cloud.

In nutshell, Docker is a computer program, command-line tool, a containerization platform, product & a company.

## Docker as a Computer program...

Docker is a computer program that performs operating-system-level virtualization, also known as "containerization". 
It was first released in 2013 and is developed by Docker, Inc. 

## Docker as a CLI tool

Docker is a command-line program, a background daemon, and a set of remote services that take a logistical approach to solving common software problems and simplifying
your experience installing, running, publishing, and removing software. It accomplishes this using a UNIX technology called containers.

## Docker as a Platform

Docker is a containerization platform that packages your application and all its dependencies together in the form of a docker container to ensure that your application works seamlessly in any environment.Docker Container is a standardized unit which can be created on the fly to deploy a particular application or environment. It could be an Ubuntu container, CentOs container, etc. to full-fill the requirement from an operating system point of view. Also, it could be an application oriented container like CakePHP container or a Tomcat-Ubuntu container etc.

## Docker as a Product

Docker is the leader in the containerization market, combining an enterprise-grade container platform with world-class services to give developers and IT alike the freedom to build, manage and secure applications without the fear of technology or infrastructure lock-in. 

# How does Docker work?

The Docker technology uses the Linux kernel and features of the kernel, like Cgroups and namespaces, to segregate processes so they can run independently. This independence is the intention of containers‐the ability to run multiple processes and apps separately from one another to make better use of your infrastructure while retaining the security you would have with separate systems.

Container tools, including Docker, provide an image-based deployment model. This makes it easy to share an application, or set of services, with all of their dependencies across multiple environments. Docker also automates deploying the application (or combined sets of processes that make up an app) inside this container environment.

These tools built on top of Linux containers—what makes Docker user-friendly and unique—gives users unprecedented access to apps, the ability to rapidly deploy, and control over versions and version distribution.

# Is Docker technology the same as traditional Linux containers?

No. Docker technology was initially built on top of the LXC technology—what most people associate with "traditional” Linux containers—though it’s since moved away from that dependency. LXC was useful as lightweight virtualization, but it didn’t have a great developer or user experience. The Docker technology brings more than the ability to run containers—it also eases the process of creating and building containers, shipping images, and versioning of images (among other things).

![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/docker/images/traditional-linux-containers-vs-docker_0.png)

Traditional Linux containers use an init system that can manage multiple processes. This means entire applications can run as one. The Docker technology encourages applications to be broken down into their separate processes and provides the tools to do that. This granular approach has its advantages.

# Benefits of Docker containers

## Modularity

The Docker approach to containerization is focused on the ability to take down a part of an application, to update or repair, without unnecessarily taking down the whole app. In addition to this microservices-based approach, you can share processes amongst multiple apps in much the same way that service-oriented architecture (SOA) works.

## Layers and image version control

Each Docker image file is made up of a series of layers. These layers are combined into a single image. A layer is created when the image changes. Every time a user specifies a command, such as run or copy, a new layer gets created.

Docker reuses these layers for new container builds, which makes the build process much faster. Intermediate changes are shared between images, further improving speed, size, and efficiency. Inherent to layering is version control. Every time there’s a new change, you essentially have a built-in changelog—full control over your container images.

## Rollback

Perhaps the best part about layering is the ability to roll back. Every image has layers. Don’t like the current iteration of an image? Roll it back to the previous version. This supports an agile development approach and helps make continuous integration and deployment (CI/CD) a reality from a tools perspective.

## Rapid deployment

Getting new hardware up, running, provisioned, and available used to take days. And the level of effort and overhead was burdensome. Docker-based containers can reduce deployment to seconds. By creating a container for each process, you can quickly share those similar processes with new apps. And, since an OS doesn’t need to boot to add or move a container, deployment times are substantially shorter. On top of this, with the speed of deployment, you can easily and cost-effectively create and destroy data created by your containers without concern.

So, Docker technology is a more granular, controllable, microservices-based approach that places greater value on efficiency.


[Proceed >> Docker Vs Containers](https://collabnix.github.io/dockerlabs/beginners/docker/docker-vs-container.html)

