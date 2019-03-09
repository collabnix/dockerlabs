# Installing Docker Desktop for Windows

Docker Desktop for Windows is the Community Edition (CE) of Docker for Microsoft Windows. To download Docker Desktop for Windows, head to Docker Hub.

Link: https://hub.docker.com/editions/community/docker-ce-desktop-windows

The installation provides Docker Engine, Docker CLI client, Docker Compose, Docker Machine, and Kitematic. Containers and images created with Docker Desktop for Windows are shared between all user accounts on machines where it is installed. This is because all Windows accounts use the same VM to build and run containers.

Did you Know? Switch between Windows and Linux containers describes the Linux / Windows containers toggle in Docker Desktop for Windows and points you to the tutorial mentioned above.


# Pre-requisite:

- Windows 10 Laptop 10.0.143393 Build 14391
- x64 based PC
- Verify if Switch to Linux container is well selected under Preference UI

## System Requirements:

- Windows 10 64bit: Pro, Enterprise or Education (1607 Anniversary Update, Build 14393 or later).
- Virtualization is enabled in BIOS. Typically, virtualization is enabled by default. This is different from having Hyper-V enabled. For more detail see Virtualization must be enabled in Troubleshooting.
- CPU SLAT-capable feature.
- At least 4GB of RAM.


## Checking Docker Version

Run docker version to check the basic details of your deployment. You should see "Windows" listed as the operating system for the Docker client and the Docker Engine:


```
Client: Docker Engine - Community
 Version:           18.09.2
 API version:       1.39
 Go version:        go1.10.8
 Git commit:        6247962
 Built:             Sun Feb 10 04:12:31 2019
 OS/Arch:           windows/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.2
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.6
  Git commit:       6247962
  Built:            Sun Feb 10 04:13:06 2019
  OS/Arch:          linux/amd64
  Experimental:     true
 Kubernetes:
  Version:          v1.10.11
  StackAPI:         Unknown
PS C:\Users\Ajeet_Raina>

```
The OS/Arch field tells you the operating system and CPU architecture you're using. Docker is cross-platform, so you can manage Windows Docker servers from a Linux client and vice-versa, using the same docker commands.

## Running Your First NGINX application

```
PS C:\Users\Ajeet_Raina> docker run -d -p 80:80 nginx
567450d768e42e521bf3cec945d07bc3f796b6c5503d971881f5169e30a73215
```

## Running Your First Nginx based Docker Container

```
PS C:\Users\Ajeet_Raina> docker run -d -p 81:80 ajeetraina/hellowhale
33e673c86f63990cdac2c155bc6bfe20a7b7809b82434908bc38517ae029d0e8
```
![My Image](https://github.com/collabnix/dockerlabs/blob/master/beginners/install/windows/docker-desktop-for-windows/win_image2.png)

## Try running WIndows Based Docker Container

```
PS C:\Users\Ajeet_Raina> docker container run -d -p 84:80 --name iis microsoft/iis
Unable to find image 'microsoft/iis:latest' locally
latest: Pulling from microsoft/iis
C:\Program Files\Docker\Docker\Resources\bin\docker.exe: no matching manifest for unknown in the manifest list entries.
See 'C:\Program Files\Docker\Docker\Resources\bin\docker.exe run --help'.
PS C:\Users\Ajeet_Raina>
```

This was expected as we are currently switched to Linux containers


## Creating Docker Swarm Cluster on Windows 

```
PS C:\Users\Ajeet_Raina\docker101\play-with-docker\wordpress> docker swarm init
Swarm initialized: current node (29g3oqgz89f9g7gyicgq8h1o2) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-1gz58w1cgci63er4dhl6rkhhg29umkkt373ic85hpb3ywvtvqg-4ersf0a9dz00ime4xy
168.65.3:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

PS C:\Users\Ajeet_Raina\docker101\play-with-docker\wordpress>
```

## Verifying Single Node Cluster

```
PS C:\Users\Ajeet_Raina\docker101\play-with-docker\wordpress> docker node ls
ID                            HOSTNAME                STATUS              AVAILABILITY        MANAGER STATUS      ENGINE
 VERSION
29g3oqgz89f9g7gyicgq8h1o2 *   linuxkit-00155d1fffe2   Ready               Active              Leader              18.09.
2
```

## Running WordPress Application on Docker Desktop for Windows

Let us first stop the last 2 containers which listen on port 80 and 81 and then follow the below command to bring up WordPress App

```
PS C:\Users\Ajeet_Raina\docker101\play-with-docker\wordpress\example1> docker stack deploy --orchestrator=swarm -c stack.yml myapp10
.yml myapp10
Ignoring unsupported options: restart

Creating network myapp10_default
Creating service myapp10_db
Creating service myapp10_wordpress
PS C:\Users\Ajeet_Raina\docker101\play-with-docker\wordpress\example1>
```

## Verifying the Stack

```
PS C:\Users\Ajeet_Raina\docker101\play-with-docker\wordpress\example1> docker stack --orchestrator=swarm ls
NAME                SERVICES            ORCHESTRATOR
myapp10             2                   Swarm
PS C:\Users\Ajeet_Raina\docker101\play-with-docker\wordpress\example1>
```

## Running Docker Swarm Visualizer

```
PS C:\Users\Ajeet_Raina\docker101\play-with-docker\visualizer> docker-compose up -d
WARNING: Some services (visualizer) use the 'deploy' key, which will be ignored. Compose does not support 'deploy' configu
ration - use `docker stack deploy` to deploy to a swarm.
WARNING: The Docker Engine you're using is running in swarm mode.

Compose does not use swarm mode to deploy services to multiple nodes in a swarm. All containers will be scheduled on the c
urrent node.

To deploy your application across the swarm, use `docker stack deploy`.

Creating network "visualizer_default" with the default driver
Pulling visualizer (dockersamples/visualizer:stable)...
stable: Pulling from dockersamples/visualizer
88286f41530e: Pull complete
6a722742375f: Pull complete
7e9d2f284de4: Pull complete
a8a42e9e643e: Pull complete
878a9d1427c8: Pull complete
b1867f55f80a: Pull complete
1a82a234b70b: Pull complete
93d560de8dd8: Pull complete
3eb2a9bba107: Pull complete
67cde5cd35b3: Pull complete
b4376f83977c: Pull complete
730e0303ceca: Pull complete
Creating visualizer_visualizer_1 ... done
PS C:\Users\Ajeet_Raina\docker101\play-with-docker\visualizer>
```

