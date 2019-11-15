# Getting started with Container Live Migration using Docker container

## Pre-requisites
- Understanding of virtualization concepts
- Understanding of Live Migration in virtualized environment

# Introduction to the Container Live Migration:
Containers are just a linux processes running in the namespace of the underlying kernel and can be checkpointed in the form of images. Such images i.e. metadata of the checkpointed container can be copied into the another containers and can be restored there hence resuming the previously checkpointed task in the namespace of another container. 
Docker comes with the inbuilt features of checkpointing the running containers which can be performed on play-on-docker platform with some modifications on the running docker daemon.

Docker checkpoint/restore features are backed by the seperate project called Checkpoint and Restore in Userspace and abbreviated as CRIU. This project deals with checkpoint and restore of the containers as well as container migration. CRIU implements various protocols for live migration of containers i.e. lazy migration, diskless migration, zero downtime migration, etc.

For more information regarding criu project, you can visit the following link and they have seperate mailing list if you want to contribute to it. 

- [CRIU Project](https://criu.org/Main_Page) <br>

- [CRIU github](https://github.com/checkpoint-restore) <br>

# Docker Daemon modification

 For this session we have to enable experimental mode for Docker i.e.


```
echo "{\"experimental\": true}" >> /etc/docker/daemon.json
systemctl restart docker
```
In addition to having a recent version of Docker, you need CRIU 3.0 or later installed on your system. 

# Experimentation of docker checkpoint/restore . 
On the local system we run a simple shell script inside the container which display a simple loop for counting the number.i.e.

```
docker run -d --name looper --security-opt seccomp:unconfined busybox  \
         /bin/sh -c 'i=0; while true; do echo $i; i=$(expr $i + 1); sleep 1; done'
```
## Checking the logs of the running containers. 

Now the running container log can be viewed by following command. 
You can observe that the integer value is increasing if you run the following command for number of times. 

``` 
docker logs looper
```
## Checkpointing the running containers
	
```
docker checkpoint create looper checkpoint1
```
On execution of the above command, running container gets killed and loop count stop on execution.

## Restoring the checkpointed containers. 
You can restore the checkpointed containers from the last point of execution. 

```
docker start --checkpoint checkpoint1 looper
```
Now if you check the log file of container you can see the integer incrementing from the last point. 


Docker also has feature to migrate task form one containers to another containers form which we can checkpoint the currently running container.
The checkpointed metadata of the container can be stored into specific location of contaienr with the help of --checkpoint-dir option. Later  the stored metadata can be pointed form another contaienr and restore the task but unfortunately docker has removed this functionality and exported to the Moby project for further experimentation. 



## Contributor - [Yadav Lamichhane](https://www.linkedin.com/in/omegazyadav1/)
