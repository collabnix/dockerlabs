# Overview of Docker Desktop for Mac

- Docker Desktop is a full development platform for creating containerized apps
- It runs on a LinuxKit VM and NOT on VirtualBox or VMware Fusion.
- It embeds a hypervisor called xhyve(a lightweight OS X virtualization solution) -  a  Linux distribution which runs on LinuxKit and filesystem & network sharing that is much more Mac native.
- It is a Mac native application, that you install in `/Applications`.
- At installation time, it creates symlinks in /usr/local/bin for docker & docker-compose and others, to the commands in the application bundle, in /Applications/Docker.app/Contents/Resources/bin


```
 pwd
/Applications/Docker.app/Contents/Resources/bin
 bin % tree -L 1
.
├── com.docker.cli
├── com.docker.vpnkit
├── docker
├── docker-compose
├── docker-compose-v1
├── docker-credential-desktop
├── docker-credential-ecr-login
├── docker-credential-osxkeychain
├── docker-index
├── hub-tool
└── kubectl

1 directory, 10 files
osxkeychain	kubectl
docker				docker-credential-desktop	docker-index
```




## What does it use?


- Docker Desktop for Mac uses the Docker Engine to run containers. 
- The Docker Engine is a powerful, open-source container runtime that builds and runs containers using the Docker image format and containerd runtime.


# What is Containerd?

Containerd is an industry-standard container runtime that is responsible for executing and managing containers. It provides a stable, high-level API for interacting with containers and is designed to be used by a variety of container tools, such as Docker.

Internally, containerd works by using a set of long-running processes called "daemons" to manage containers. These daemons are responsible for tasks such as pulling images from a registry, starting and stopping containers, and managing container networks.

When you run a Docker container on Docker Desktop for Mac, the Docker Engine sends a request to containerd to create and run the container. Containerd then pulls the necessary image from a registry, creates the container, and starts it. It also manages the container's runtime environment, including its networking, storage, and resource limits.

