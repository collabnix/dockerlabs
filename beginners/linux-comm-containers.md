---
layout: default
title: Beginners Track - Can container communication cross over to noncontainerized apps?
description: collabnix | DockerLab | Docker - Beginners Track
---

# Can container communication cross over to noncontainerized apps?

Let us start with a popular question - Can an application having Python as a container, run SQL queries on an external Microsoft SQL database and publish the results on an Apache web server container? 

The answer is "Absolutely, Yes its possible."Under this page, we will deep dive into this subject.

Containers resemble VMs in that they get full network access and can connect to any other service on the internet as long as the containers are configured to do so.

For example, containers on the AWS Fargate compute engine for containers and Kubernetes can have their own IP addresses and be used to network with any service that is internet-enabled. Containers can also exist behind virtual private clouds (VPCs) -- which are walled-off dedicated resources on AWS or another public cloud host -- or other network firewalls that isolate and protect them from outside connections. Container communication isn't much different than other application deployment strategies, as long as you understand the options.

In addition to containers' ability to connect to anything outside of their environment through traditional networks, they can also use Docker's bridge networks to connect to other Docker containers running on the same physical system. They can also employ overlay networks to connect to services running on other Docker hosts.

Although no longer recommended, Docker links can also join multiple containers together to provide one service. Consider how a Python container can run SQL queries against a Docker container that's running Microsoft SQL, and publish those results to an Apache web server in another container.

* Please Note - Docker Inc. states that the functionality of Docker links was incorp


[Proceed >> Architecture of Docker Platform](http://dockerlabs.collabnix.com/beginners/architecture-of-docker.html)
