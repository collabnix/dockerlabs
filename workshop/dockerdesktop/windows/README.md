# Docker Desktop for Windows

Docker Desktop is a one-click-install application for your Windows environment that enables you to build and share containerized applications and microservices.

## Running Linux containers on Windows

Windows Subsystem for Linux is a feature of Windows that allows developers to run a Linux environment without the need for a separate virtual machine or dual booting. There are two versions of WSL: WSL 1 and WSL 2.

WSL 2 primary goals are to increase file system performance, as well as adding full system call compatibility. This new architecture changes how these Linux binaries interact with Windows and your computer's hardware, but still provides the same user experience as in WSL 1 (the current widely available version). 

WSL 2 is only available in Windows 11 or Windows 10, Version 1903, Build 18362 or later. 

## Architecture of Docker Desktop for Windows


Docker CLI running on the host machine executes commands within the Docker Integration Package, which runs on the remote WSL VM.

DockerD runs directly within WSL so there's no need for the Hyper-V VM and all Linux containers run within the Linux userspace on Windows for improved performance and compatibility.



<img width="750" alt="image" src="https://user-images.githubusercontent.com/313480/212317460-8ab765de-700a-467a-830c-f667b966d0e7.png">


## Installation

By default, Docker Desktop is installed at the following location:

```
C:\Program Files\Docker\Docker
```


# Support

Docker only supports Docker Desktop on Windows for those versions of Windows 10 that are still within Microsoft’s servicing timeline.

[Docker Desktop for Windows can run inside a virtual desktop provided the virtual desktop is properly configured.](https://docs.docker.com/desktop/vm-vdi/)


## FAQs?

## Que:1  Is it possible to share containers and images between user accounts?

Containers and images created with Docker Desktop are shared between all user accounts on machines where it is installed. This is because all Windows accounts use the same VM to build and run containers. Note that it is not possible to share containers and images between user accounts when using the Docker Desktop WSL 2 backend.


