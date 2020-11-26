

# Docker Interview Questions

Docker is getting a lot of traction in the industry because of its performance-savvy and universal replicability architecture, while providing the following four cornerstones of modern application development: autonomy, decentralization, parallelism & isolation. 
Below are top 50 interview questions for candidates who want to prepare on Docker Container Technology:


# What are 5 similarities between Docker & Virtual Machine?

Docker is not quite like a VM. It uses the host kernel & can’t boot a different operating system. Below are 5 similarities between Docker & VIrtual Machine:
 
 ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/Picture1.png)

# How is Docker different from Virtual Machine?
 
Figure: Docker Vs VM
Below are list of 6 difference between Docker container & VM:
![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview2.png)
 

# What is the difference between Container Networking & VM Networking?
 ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-3.png)



# Is it possible to run multiple process inside Docker container?
Yes, you can run multiple processes inside Docker container. This approach is discouraged for most use cases. For maximum efficiency and isolation, each container should address one specific area of concern. However, if you need to run multiple services within a single container, you can use tools like supervisor.
Supervisor is a moderately heavy-weight approach that requires you to package supervisord and its configuration in your image (or base your image on one that includes supervisord), along with the different applications it manages. Then you start supervisord, which manages your processes for you. 
Example: Here is a Dockerfile using this approach, that assumes the pre-written supervisord.conf, my_first_process, and my_second_process files all exist in the same directory as your Dockerfile.
 ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-4.png)
 

# Does Docker run on Linux, macOS and Windows?
You can run both Linux and Windows programs and executables in Docker containers. The Docker platform runs natively on Linux (on x86-64, ARM and many other CPU architectures) and on Windows (x86-64). Docker Inc. builds products that let you build and run containers on Linux, Windows and macOS.

#  What is DockerHub?

DockerHub is a cloud-based registry service which allows you to link to code repositories, build your images and test them, stores manually pushed images, and links to Docker cloud so you can deploy images to your hosts. It provides a centralized resource for container image discovery, distribution and change management, user and team collaboration, and workflow automation throughout the development pipeline.

# What is Dockerfile?

Docker builds images automatically by reading the instructions from a text file called Dockerfile. It contains all commands, in order, needed to build a given image. A Dockerfile adheres to a specific format and set of instructions which you can find here.

#  How is Dockerfile different from Docker Compose?

A Dockerfile is a simple text file that contains the commands a user could call to assemble an image whereas Docker Compose is a tool for defining and running multi-container Docker applications. Docker Compose define the services that make up your app in docker-compose.yml so they can be run together in an isolated environment. It get an app running in one command by just running  docker-compose up.
Docker compose uses the Dockerfile if one add the build command to your project's docker-compose.yml. Your Docker workflow should be to build a suitable Dockerfile for each image you wish to create, then use compose to assemble the images using the build command.

# Can I use JSON instead of YAML for my Docker Compose file?
Yes. Yaml is a superset of json so any JSON file should be valid Yaml. To use a JSON file with Compose, specify the filename to use, for example:
docker-compose -f docker-compose.json up

You can use json instead of yaml for your compose file, to use json file with compose, specify the filename to use for eg:
docker-compose -f docker-compose.json up

# How to create Docker container?

We can use Docker image to create Docker container by using the below command:

```
$ docker run -t -i command name
```

This command will create and start a container.If you want to verify the list of all running container with the status on a host use the below command:
```
$ docker ps -a
```

# What is maximum number of container you can run per host?
This really depends on your environment. The size of your applications as well as the amount of available resources (i.e like CPU) will all affect the number of containers that can be run in your environment. Containers unfortunately are not magical. They can’t create new CPU from scratch. They do, however, provide a more efficient way of utilizing your resources. The containers themselves are super lightweight (remember, shared OS vs individual OS per container) and only last as long as the process they are running. 

# Is it possible to have my own private Docker registry?
Yes, it is possible today using Docker own registry server. if you want to use 3rd party tool, see Portus.
TBA

# Does Docker container package up the entire OS?
Docker containers do not package up the OS. They package up the applications with everything that the application needs to run. The engine is installed on top of the OS running on a host. Containers share the OS kernel allowing a single host to run multiple containers.

# Describe how many ways are available to configure Docker daemon?
There are two ways to configure the Docker daemon:
-	Using a JSON configuration file. 
This is the preferred option, since it keeps all configurations in a single place.
-	Using flags when starting dockerd.
You can use both of these options together as long as you don’t specify the same option both as a flag and in the JSON file. If that happens, the Docker daemon won’t start and prints an error message.
$ dockerd --debug   --tls=true  --tlscert=/var/docker/server.pem --tlskey=/var/docker/serverkey.pem \
  --host tcp://<Host_IP>:2376
15. Can you list reasons why Container Networking is so important?
Below are top 5 reasons why we need container networking:
-	Containers need to talk to external world. 
-	Reach Containers from external world to use the service that Containers provides. 
-	Allows Containers to talk to host machine. 
-	Inter-container connectivity in same host and across hosts. 
-	Discover services provided by containers automatically. 
-	Load balance traffic between different containers in a service.
-	Provide secure multi-tenant services.

# What does CNM refers to? What are its components? ![img](
 ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-5.png)
 
CNM refers to Container Networking Model. The Container Network Model (CNM) is a standard or specification from Docker, Inc. that forms the basis of container networking in a Docker environment.It is Docker’s approach to providing container networking with support for multiple network drivers. The CNM provides the following contract between networks and containers:
-	All containers on the same network can communicate freely with each other
-	Multiple networks are the way to segment traffic between containers and should be supported by all drivers
-	Multiple endpoints per container are the way to join a container to multiple networks
-	An endpoint is added to a network sandbox to provide it with network connectivity

The major components of the CNM are:
-	 Network, 
-	Sandbox and 
-	Endpoint.
Sandbox is a generic term that refers to OS specific technologies used to isolate networks stacks on a Docker host. Docker on Linux uses kernel namespaces to provide this sandbox functionality. Networks “stacks” inside of sandboxes include interfaces, routing tables, DNS etc. A network in CNM terms is one or more endpoints that can communicate.All endpoints on the same network can communicate with each other.Endpoints on different networks cannot communicate without external routing.
  ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-6.png)

# What are different types of Docker Networking drivers? 
 ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-7.png)

Docker’s networking subsystem is pluggable using drivers. Several drivers exist by default, and provide core networking functionality. Below is the snapshot of difference of various Docker networking drivers.

 



Below are details of Docker networking drivers:
Bridge: The default network driver. If you don’t specify a driver, this is the type of network you are creating. Bridge networks are usually used when your applications run in standalone containers that need to communicate. 

Host: For standalone containers, remove network isolation between the container and the Docker host, and use the host’s networking directly. host is only available for swarm services on Docker 17.06 and higher. 

Overlay: Overlay networks connect multiple Docker daemons together and enable swarm services to communicate with each other. You can also use overlay networks to facilitate communication between a swarm service and a standalone container, or between two standalone containers on different Docker daemons. This strategy removes the need to do OS-level routing between these containers. See overlay networks.

MacVLAN: Macvlan networks allow you to assign a MAC address to a container, making it appear as a physical device on your network. The Docker daemon routes traffic to containers by their MAC addresses. Using the macvlan driver is sometimes the best choice when dealing with legacy applications that expect to be directly connected to the physical network, rather than routed through the Docker host’s network stack. 

None: For this container, disable all networking. Usually used in conjunction with a custom network driver. none is not available for swarm services. 


# What features are possible only under Docker Enterprise Edition in comparison to Docker Community Edition?
 The following two features are only possible when using Docker EE and managing your Docker services using Universal Control Plane (UCP):
The HTTP routing mesh allows you to share the same network IP address and port among multiple services. UCP routes the traffic to the appropriate service using the combination of hostname and port, as requested from the client.
Session stickiness allows you to specify information in the HTTP header which UCP uses to route subsequent requests to the same service task, for applications which require stateful sessions.


# How is Docker Bridge network different from traditional Linux bridge ?
![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-8.png)
 
In terms of networking, a bridge network is a Link Layer device which forwards traffic between network segments. A bridge can be a hardware device or a software device running within a host machine’s kernel.
In terms of Docker, a bridge network uses a software bridge which allows containers connected to the same bridge network to communicate, while providing isolation from containers which are not connected to that bridge network. The Docker bridge driver automatically installs rules in the host machine so that containers on different bridge networks cannot communicate directly with each other.

# How to create a user-defined Bridge network ?
To create a user-defined bridge network, one can use the docker network create command - 

```$ docker network create mynet```

![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-9.png)
 
You can specify the subnet, the IP address range, the gateway, and other options. See the docker network create reference or the output of docker network create --help for details.

# How to delete a user-defined Bridge network ?
Use the docker network rm command to remove a user-defined bridge network. If containers are currently connected to the network, disconnect them first.

```$ docker network rm mynet```
![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-10.png)

 
# How to connect Docker container to user-defined bridge network?

![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-11.png)
 
When you create a new container, you can specify one or more --network flags. This example connects a Nginx container to the my-net network. It also publishes port 80 in the container to port 8080 on the Docker host, so external clients can access that port. Any other container connected to the my-net network has access to all ports on the my-nginx container, and vice versa.
```
$ docker create --name my-nginx \
  --network my-net \
  --publish 8080:80 \
  nginx:latest
```
To connect a running container to an existing user-defined bridge, use the docker network connect command. The following command connects an already-running my-nginx container to an already-existing my-net network:
```
$ docker network connect my-net my-nginx

```



# Does Docker support IPv6?

![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-12.png)

 
Yes, Docker support IPv6.  IPv6 networking is only supported on Docker daemons running on Linux hosts.Support for IPv6 address has been there since Docker Engine 1.5 release.To enable IPv6 support in the Docker daemon, you need to edit ```/etc/docker/daemon.json ```and set the ipv6 key to true.
```
{
  "ipv6": true
}
```
Ensure that you reload the Docker configuration file.
```
$ systemctl reload docker
```
You can now create networks with the` --ipv6 `flag and assign containers IPv6 addresses using the `--ip6` flag.

# Does Docker Compose file format support IPv6 protocol?
Yes.

# How is overlay network different from bridge network?
![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-13.png)
 
Bridge networks connect two networks while creating a single aggregate network from multiple communication networks or network segments, hence the name bridge.
Overlay networks are usually used to create a virtual network between two separate hosts. Virtual, since the network is build over an existing network.
Bridge networks can cater to single host, while overlay networks are for multiple hosts.

26. What networks are affected when you join a Docker host to an existing Swarm?
When you initialize a swarm or join a Docker host to an existing swarm, two new networks are created on that Docker host:
-	an overlay network called ingress, which handles control and data traffic related to swarm services. When you create a swarm service and do not connect it to a user-defined overlay network, it connects to the ingress network by default.
-	a bridge network called docker_gwbridge, which connects the individual Docker daemon to the other daemons participating in the swarm.

# How shall you disable the networking stack on a container?
![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-14.png)
If you want to completely disable the networking stack on a container, you can use the --network none flag when starting the container. Within the container, only the loopback device is created. The following example illustrates this.
 

# How can one create MacVLAN network for Docker container?
To create a Macvlan network which bridges with a given physical network interface, once can use --driver macvlan with the docker network create command. You also need to specify the parent, which is the interface the traffic will physically go through on the Docker host.
```
$ docker network create -d macvlan \
  --subnet=172.16.86.0/24 \
  --gateway=172.16.86.1  \
  -o parent=eth0 collabnet
```

# Is it possible to exclude IP address from being used in MacVLAN network?
If you need to exclude IP addresses from being used in the Macvlan network, such as when a given IP address is already in use, use ```--aux-addresses```:
```
$ docker network create -d macvlan  \
  --subnet=192.168.32.0/24  \
  --ip-range=192.168.32.128/25 \
  --gateway=192.168.32.254  \
  --aux-address="my-router=192.168.32.129" \
  -o parent=eth0 collabnet32
```
# Do I lose my data when the container exits?
Not at all! Any data that your application writes to disk gets preserved in its container until you explicitly delete the container. The file system for the container persists even after the container halts.
# Does Docker Enterprise Edition support Kubernetes?
Yes, Docker Enterprise Edition(rightly called EE) support Kubernetes. EE 2.0 allows users to choose either Kubernetes or Swarm at the orchestration layer.
# What is Docker Swarm?
Docker Swarm is native clustering for Docker. It turns a pool of Docker hosts into a single, virtual Docker host. Docker Swarm serves the standard Docker API, any tool that already communicates with a Docker daemon can use Swarm to transparently scale to multiple hosts.




# What is `--memory-swap` flag?
`--memory-swap` is a modifier flag that only has meaning if `--memory `is also set. Using swap allows the container to write excess memory requirements to disk when the container has exhausted all the RAM that is available to it. There is a performance penalty for applications that swap memory to disk often.

# Can you explain different volume mount types  available in Docker?
There are three mount types available in Docker   	
· Volumes are stored in a part of the host filesystem which is managed by Docker (`/var/lib/docker/volumes/` on Linux). Non-Docker processes should not modify this part of the filesystem. Volumes are the best way to persist data in Docker.
·  Bind mounts may be stored anywhere on the host system. They may even be important system files or directories. Non-Docker processes on the Docker host or a Docker container can modify them at any time.
·   tmpfs mounts are stored in the host system’s memory only, and are never written to the host system’s filesystem.
 
#  How to share data among DockerHost?
Ways to achieve this when developing your applications. One is to add logic to your application to store files on a cloud object storage system like Amazon S3. Another is to create volumes with a driver that supports writing files to an external storage system like NFS or Amazon S3.
Volume drivers allow you to abstract the underlying storage system from the application logic. For example, if your services use a volume with an NFS driver, you can update the services to use a different driver, as an example to store data in the cloud, without changing the application logic.
 
# How to Backup, Restore, or Migrate data volumes under Docker container?
 
Steps to Backup a container
1)      Launch a new container and mount the volume from the dbstore container
2)      Mount a local host directory as /backup
3)      Pass a command that tars the contents of the dbdata volume to a backup.tar file inside our /backup directory.
`$ docker run --rm --volumes-from dbstore -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /dbdata`
 Restore container from backup
With the backup just created, you can restore it to the same container, or another that you made elsewhere.
For example, create a new container named dbstore2:
`$ docker run -v /dbdata --name dbstore2 ubuntu /bin/bash`

Then un-tar the backup file in the new container`s data volume:
```
$ docker run --rm --volumes-from dbstore2 -v $(pwd):/backup ubuntu bash -c "cd /dbdata && tar xvf /backup/backup.tar --strip 1
```

#  How to Configure Automated Builds on DockerHub
You can build your images automatically from a build context stored in a repository. A build context is a Dockerfile and any files at a specific location. For an automated build, the build context is a repository containing a Dockerfile. 

# How to configure the default logging driver under Docker?

To configure the Docker daemon to default to a specific logging driver, set the value of log-driver to the name of the logging driver in the daemon.json file, which is located in /etc/docker/ on Linux hosts or C:\ProgramData\docker\config\ on Windows server hosts. The default logging driver is json-file.


# Why do my services take 10 seconds to recreate or stop?

Compose stop attempts to stop a container by sending a SIGTERM. It then waits for a default timeout of 10 seconds. After the timeout, a SIGKILL is sent to the container to forcefully kill it. If you are waiting for this timeout, it means that your containers aren’t shutting down when they receive the SIGTERM signal.

# How do I run multiple copies of a Compose file on the same host?

Compose uses the project name to create unique identifiers for all of a project’s containers and other resources. To run multiple copies of a project, set a custom project name using the -command line option or the COMPOSE_PROJECT_NAME environment variable.

# What’s the difference between up, run, and start under Docker Compose?

Typically, you want docker-compose up. Use up to start or restart all the services defined in a docker-compose.yml. In the default “attached” mode, you see all the logs from all the containers. In “detached” mode (-d), Compose exits after starting the containers, but the containers continue to run in the background.

The docker-compose run command is for running “one-off” or “adhoc” tasks. It requires the service name you want to run and only starts containers for services that the running service depends on. Use run to run tests or perform an administrative task such as removing or adding data to a data volume container. The run command acts like docker run -ti in that it opens an interactive terminal to the container and returns an exit status matching the exit status of the process in the container.
The docker-compose start command is useful only to restart containers that were previously created, but were stopped. It never creates new containers.

#  What is Docker Trusted Registry?
Docker Trusted Registry (DTR) is the enterprise-grade image storage solution from Docker. You install it behind your firewall so that you can securely store and manage the Docker images you use in your applications.

# How to declare default environment variables under Docker Compose?


Compose supports declaring default environment variables in an environment file named .env placed in the folder where the docker-compose command is executed (current working directory).
Example: The below example demonstrate how to declare default environmental variable for Docker Compose.
![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-16.png)

 
When you run docker-compose up, the web service defined above uses the image alpine:v3.4. You can verify this with the `docker-compose config` command which prints your resolved application config to the terminal:
![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-17.png)

 

# Can you list out ways to share Compose configurations between files and projects under Docker Compose?

Compose supports two methods of sharing common configuration:
1.	Extending an entire Compose file by using multiple Compose files
2.	Extending individual services with the extends field

# What is the role of .dockerignore file?
To understand the role of .dockerignore file, let us take a practical example. You may have noticed that if you put a Dockerfile in your home directory and launch a docker build you will see a message uploading context. Right? This means docker creates a .tar with all the files in your home and in all the subdirectories, and uploads this tar to the docker daemon. If you have some huge files, this may take a long time.
In order to avoid this, you might need to create a specific directory, where you put your Dockerfile, and all what is needed for your build. It becomes necessary to tell docker to ignore some files during the build. Hence, you need to put in the .dockerignore all the files not needed for your build
Before the docker CLI sends the context to the docker daemon, it looks for a file named .dockerignore in the root directory of the context. If this file exists, the CLI modifies the context to exclude files and directories that match patterns in it. This helps to avoid unnecessarily sending large or sensitive files and directories to the daemon and potentially adding them to images using ADD or COPY.

# What is the purpose of EXPOSE command in Dockerfile?
When writing your Dockerfiles, the instruction EXPOSE tells Docker the running container listens on specific network ports. This acts as a kind of port mapping documentation that can then be used when publishing the ports.

`EXPOSE <port> [<port>/<protocol>...]`
![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-18.png)
 
You can also specify this within a docker run command, such as:

`docker run --expose=1234 my_app`

Please note that EXPOSE will not allow communication via the defined ports to containers outside of the same network or to the host machine. To allow this to happen you need to publish the ports.

# How is ENTRYPOINT instruction under Dockerfile different from RUN instruction?
ENTRYPOINT is meant to provide the executable while CMD is to pass the default arguments to the executable.
To understand it clearly, let us consider the below Dockerfile:
 ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-19.png)

If you try building this Docker image using `docker build command` -

  ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-21.png)

 Let us run this image without any argument.
  ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-22.png)

 

Let's run it passing a command line argument
  ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-23.png)
 
This clearly state that ENTRYPOINT is meant to provide the executable while CMD is to pass the default arguments to the executable.
# Why Build cache in Docker is so important? 
If the objects on the file system that Docker is about to produce are unchanged between builds, reusing a cache of a previous build on the host is a great time-saver. It makes building a new container really, really fast. None of those file structures have to be created and written to disk this time — the reference to them is sufficient to locate and reuse the previously built structures.
# Why Docker Monitoring is necessary?
●	Monitoring helps to identify issues proactively that would help to avoid system outages.
●	The monitoring time-series data provide insights to fine-tune applications for better performance and robustness.
●	With full monitoring in place, changes could be rolled out safely as issues will be caught early on and be resolved quickly before that transforms into root-cause for an outage.
●	The changes are inherent in container based environments and impact of that too gets monitored indirectly.
 

# Difference between Windows Containers and Hyper-V Containers
  ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-24.png)

Underlying is the architecture laid out by the Microsoft for the Windows and Hyper-V Containers
 
Here are few of the differences between them,
Differences:
  ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-25.png)
 

# What are main difference between Swarm & Kubernetes?
Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications. It  was built by Google based on their experience running containers in production using an internal cluster management system called Borg (sometimes referred to as Omega). In the other hand, a Swarm cluster consists of Docker Engine deployed on multiple nodes. Manager nodes perform orchestration and cluster management. Worker nodes receive and execute tasks 
Below are the major list of differences between Docker Swarm & Kubernetes:
 ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-26.png)
 

 	 
Applications are deployed in the form of  services (or “microservices”) in a Swarm cluster. Docker Compose is a tool which is majorly  used to deploy the app. 	Applications are deployed in the form of a combination of pods, deployments, and services (or “microservices”). 
Autoscaling feature is not available either in  Docker Swarm (Classical) or Docker Swarm 	Auto-scaling feature is available  under K8s. It   uses a simple number-of-pods target which is defined declaratively using deployments. CPU-utilization-per-pod target is available. 


Docker Swarm support rolling updates features. At rollout time, you can apply rolling updates to services. The Swarm manager lets you control the delay between service deployment to different sets of nodes, thereby updating only 1 task at a time.	Under kubernetes, the deployment controller  supports both “rolling-update” and “recreate” strategies. Rolling updates can  specify maximum number of pods unavailable or maximum number running during the process.
Under Docker Swarm Mode, the node joining a Docker Swarm cluster creates an overlay network for services that span all of the hosts in the Swarm and a host only Docker bridge network for containers.
By default, nodes in the Swarm cluster encrypt overlay control and management traffic between themselves. Users can choose to encrypt container data traffic when creating an overlay network by themselves.
	Under K8s, the networking model is a flat network, enabling all pods to communicate with one another. Network policies specify how pods communicate with each other. The flat network is typically implemented as an overlay.

Docker Swarm health checks are limited to services. If a container backing the service does not come up (running state), a new container is kicked off.
Users can embed health check functionality into their Docker images using the HEALTHCHECK instruction.
	Under K8s, the health checks are of two kinds: liveness (is app responsive) and readiness (is app responsive, but busy preparing and not yet able to serve)
Out-of-the-box K8S provides a basic logging mechanism to pull aggregate logs for a set of containers that make up a pod.




#  Is it possible to run Kubernetes on Docker EE 2.0 Platform?
Yes, it is possible to run Kubernetes under Docker EE 2.0 platform. Docker Enterprise Edition (EE) 2.0 is the only platform that manages and secures applications on Kubernetes in multi-Linux, multi-OS and multi-cloud customer environments. As a complete platform that integrates and scales with your organization, Docker EE 2.0 gives you the most flexibility and choice over the types of applications supported, orchestrators used, and where it’s deployed. It also enables organizations to operationalize Kubernetes more rapidly with streamlined workflows and helps you deliver safer applications through integrated security solutions.

# Can you use Docker Compose to build up Swarm/Kubernetes Cluster?
Yes, one can deploy a stack on Kubernetes with docker stack deploy command, the docker-compose.yml file, and the name of the stack.
Example:
$docker stack deploy --compose-file /path/to/docker-compose.yml mystack
                   $docker stack services mystack
You can see the service deployed with the kubectl get services command
                  $kubectl get svc,po,deploy

# What is 'docker stack deploy' command meant for?
The ‘docker stack deploy’ is a command to deploy a new stack or update an existing stack. A stack is a collection of services that make up an application in a specific environment. A stack file is a file in YAML format that defines one or more services, similar to a docker-compose.yml file for Docker Compose but with a few extensions. 
 ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-27.png)
 
# List down major components of Docker EE 2.0?
Docker EE is more than just a container orchestration solution; it is a full lifecycle management solution for the modernization of traditional applications and microservices across a broad set of infrastructure platforms. It is a Containers-as-a-Service(CaaS) platform for IT that manages and secures diverse applications across disparate infrastructure, both on-premises and in the cloud. Docker EE provides an integrated, tested and certified platform for apps running on enterprise Linux or Windows operating systems and Cloud providers. It is tightly integrated to the underlying infrastructure to provide a native, easy to install experience and an optimized Docker environment.
Docker EE 2.0 GA consists of 3 major components which together enable a full software supply chain, from image creation, to secure image storage, to secure image deployment.
●	Universal Control Plane 3.0.0 (application and cluster management) – Deploys applications from images, by managing orchestrators, like Kubernetes and Swarm. UCP is designed for high availability (HA). You can join multiple UCP manager nodes to the cluster, and if one manager node fails, another takes its place automatically without impact to the cluster.
●	Docker Trusted Registry 2.5.0 – The production-grade image storage solution from Docker &
●	EE Engine 17.06.2- The commercially supported Docker engine for creating images and running them in Docker containers.

# Explain the concept of HA under Swarm Mode?
HA refers to High Availability. High Availability is a feature where you have multiple instances of your applications running in parallel to handle increased load or failures. These two paradigms fit perfectly into Docker Swarm, the built-in orchestrator that comes with Docker. Deploying your applications like this will improve your uptime which translates to happy users.
For creating a high availability container in the Docker Swarm, we need to deploy a docker service to the swarm with nginx image. This can be done by using docker swarm create command as specified above.
# docker service create --name nginx --publish 80:80 nginx
 ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-29.png)
 
# Can you explain what is Routing Mesh under Docker Swarm Mode?
Routing Mesh is a feature which make use of Load Balancer concepts.It provides global publish port for a given service. The routing mesh uses port based service discovery and load balancing. So to reach any service from outside the cluster you need to expose ports and reach them via the Published Port.
Docker Engine swarm mode makes it easy to publish ports for services to make them available to resources outside the swarm. All nodes participate in an ingress routing mesh. The routing mesh enables each node in the swarm to accept connections on published ports for any service running in the swarm, even if there’s no task running on the node. The routing mesh routes all incoming requests to published ports on available nodes to an active container.
 ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-30.png)
 
# Is Routing Mesh a Load Balancer? 
Routing Mesh is not Load-Balancer. It makes use of LB concepts.It provides global publish port for a given service. The routing mesh uses port based service discovery and load balancing. So to reach any service from outside the cluster you need to expose ports and reach them via the Published Port.
In simple words, if you had 3 swarm nodes, A, B and C, and a service which is running on nodes A and C and assigned node port 30000, this would be accessible via any of the 3 swarm nodes on port 30000 regardless of whether the service is running on that machine and automatically load balanced between the 2 running containers. I will talk about Routing Mesh in separate blog if time permits.

# Is it possible to run MacVLAN under Docker Swarm Mode? What features does it offer?
Starting Docker CE 17.06 release, Docker provides support for local scope networks in Swarm. This includes any local scope network driver. Some examples of these are bridge, host, and macvlan though any local scope network driver, built-in or plug-in, will work with Swarm. Previously only swarm scope networks like overlay were supported. 
 ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-31.png)
 
MACVLAN offers a number of unique features and capabilities. It has positive performance implications by virtue of having a very simple and lightweight architecture. It’s use cases includes very low latency applications and networking design that requires containers be on the same subnet as and using IPs as the external host network.The macvlan driver uses the concept of a parent interface. This interface can be a physical interface such as eth0, a sub-interface for 802.1q VLAN tagging like eth0.10 (.10 representing VLAN 10), or even a bonded host adaptor which bundles two Ethernet interfaces into a single logical interface.







# What are Docker secrets and why is it necessary
In Docker there are three key components to container security and together they result in inherently safer apps.
  ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-32.png)
Docker Secrets, a container native solution that strengthens the Trusted Delivery component of container security by integrating secret distribution directly into the container platform.
By integrating secrets into Docker orchestration, we are able to deliver a solution for the secrets management problem that follows these exact principles.
The following diagram provides a high-level view of how the Docker swarm mode architecture is applied to securely deliver a new type of object to our containers: a secret object.
 

 ![img](https://raw.githubusercontent.com/collabnix/dockerlabs/master/docker/img/docker-interview-33.png)



.











# Serverless Interview Questions

## What is Serverless and why is it important?

Serverless allows you to build and run applications and services without thinking about servers. It eliminates infrastructure management tasks such as server or cluster provisioning, patching, operating system maintenance, and capacity provisioning. You can build them for nearly any type of application or backend service, and everything required to run and scale your application with high availability is handled for you.

## Why use serverless?

Serverless enables you to build modern applications with increased agility and lower total cost of ownership. Building serverless applications means that your developers can focus on their core product instead of worrying about managing and operating servers or runtimes, either in the cloud or on-premises. This reduced overhead lets developers reclaim time and energy that can be spent on developing great products which scale and that are reliable.

## What are the benefits of serverless?

- NO SERVER MANAGEMENT

There is no need to provision or maintain any servers. There is no software or runtime to install, maintain, or administer


- FLEXIBLE SCALING

Your application can be scaled automatically or by adjusting its capacity through toggling the units of consumption (e.g. throughput, memory) rather than units of individual servers.

- PAY FOR VALUE

Pay for consistent throughput or execution duration rather than by server unit.

- AUTOMATED HIGH AVAILABILITY

Serverless provides built-in availability and fault tolerance. You don't need to architect for these capabilities since the services running the application provide them by default.

# Tell something about the AWS Serverless Platform?

AWS provides a set of fully managed services that you can use to build and run serverless applications. Serverless applications don’t require provisioning, maintaining, and administering servers for backend components such as compute, databases, storage, stream processing, message queueing, and more. You also no longer need to worry about ensuring application fault tolerance and availability. Instead, AWS handles all of these capabilities for you. This allows you to focus on product innovation while enjoying faster time-to-market.

## COMPUTE

### AWS Lambda

AWS Lambda lets you run code without provisioning or managing servers. You pay only for the compute time you consume - there is no charge when your code is not running.

### AWS Fargate

AWS Fargate is a purpose-built serverless compute engine for containers. Fargate scales and manages the infrastructure required to run your containers.


## STORAGE

Amazon Simple Storage Service (Amazon S3) provides developers and IT teams with secure, durable, highly-scalable object storage. Amazon S3 is easy to use, with a simple web service interface to store and retrieve any amount of data from anywhere on the web.

## Amazon Elastic File System (Amazon EFS) 

It provides simple, scalable, elastic file storage. It is built to elastically scale on demand, growing and shrinking automatically as you add and remove files. 

## DATA STORES

Amazon DynamoDB is a fast and flexible NoSQL database service for all applications that need consistent, single-digit millisecond latency at any scale.

## API PROXY

Amazon API Gateway is a fully managed service that makes it easy for developers to create, publish, maintain, monitor, and secure APIs at any scale. It offers a comprehensive platform for API management. API Gateway allows you to process hundreds of thousands of concurrent API calls and handles traffic management, authorization and access control, monitoring, and API version management.

## APPLICATION INTEGRATION

Amazon SNS is a fully managed pub/sub messaging service that makes it easy to decouple and scale microservices, distributed systems, and serverless applications.

## ORCHESTRATION

AWS Step Functions makes it easy to coordinate the components of distributed applications and microservices using visual workflows. Building applications from individual components that each perform a discrete function lets you scale and change applications quickly. Step Functions is a reliable way to coordinate components and step through the functions of your application.

## ANALYTICS

Amazon Kinesis is a platform for streaming data on AWS, offering powerful services to make it easy to load and analyze streaming data, and also providing the ability for you to build custom streaming data applications for specialized needs.

## DEVELOPER TOOLING

AWS provides tools and services that aid developers in the serverless application development process. AWS and its partner ecosystem offer tools for continuous integration and delivery, testing, deployments, monitoring and diagnostics, SDKs, frameworks, and integrated development environment (IDE) plugins.


# DCA Mock questions

## 1. How can we limit the number of CPUs provided to a container?

a) Using `--cap-add CPU` . <br>
b) Using` --cpuset-cpus` . <br>
c) Using` --cpus `. <br>
d) It is not possible to specify the number of CPUs;we have to use `--cpu-shares` and define the CPU slices. <br>


## 2. How can we limit the amount of memory available to a container?
a) It is not possible to limit the amount of memory available to a container.<br>
b) Using `--cap-drop MEM `.<br>
c) Using `--memory` .<br>
d) Using `--memory-reservation` .<br>

## 3.What environment variables should be exported to start using a trusted environment with the Docker client?
a) `export DOCKER_TRUSTED_ENVIRONMENT=1 `<br>
b) `export DOCKER_CONTENT_TRUST=1`<br>
c) `export DOCKER_TRUST=1`<br>
d) `export DOCKER_TRUSTED=1`<br>
