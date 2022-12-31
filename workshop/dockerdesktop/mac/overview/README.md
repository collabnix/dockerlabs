# Overview of Docker Desktop Internals

- An Easy-to-install application for your Mac, Linux, or Windows environment.
- Enables you to build and share containerized applications and microservices.
- Provides a simple interface that enables you to manage your containers, applications, and images directly from your machine without having to use the CLI to perform core actions.
- A tool for developing and running Docker containers on a Mac. 
- Provides a native Mac application that includes all of the necessary tools to build, run, and manage Docker containers.


## What does it use?


- Docker Desktop for Mac uses the Docker Engine to run containers. 
- The Docker Engine is a powerful, open-source container runtime that builds and runs containers using the Docker image format and containerd runtime.


# What is Containerd?

Containerd is an industry-standard container runtime that is responsible for executing and managing containers. It provides a stable, high-level API for interacting with containers and is designed to be used by a variety of container tools, such as Docker.

Internally, containerd works by using a set of long-running processes called "daemons" to manage containers. These daemons are responsible for tasks such as pulling images from a registry, starting and stopping containers, and managing container networks.

When you run a Docker container on Docker Desktop for Mac, the Docker Engine sends a request to containerd to create and run the container. Containerd then pulls the necessary image from a registry, creates the container, and starts it. It also manages the container's runtime environment, including its networking, storage, and resource limits.

