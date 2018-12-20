# Running Cron Jobs container on Docker Swarm Cluster

A Docker Swarm consists of multiple Docker hosts which run in swarm mode and act as managers (to manage membership and delegation) and workers (which run swarm services).
When you create a service, you define its optimal state (number of replicas, network and storage resources available to it, ports the service exposes to the outside world, and more). Docker works to maintain that desired state. For instance, if a worker node becomes unavailable, Docker schedules that node’s tasks on other nodes. 
A task is a running container which is part of a swarm service and managed by a swarm manager, as opposed to a standalone container.

Let us talk a bit more about Services...

A Swarm service is a 1st class citizen and is the definition of the tasks to execute on the manager or worker nodes. It is the central structure of the swarm system and the primary root of user interaction with the swarm. When one create a service, you specify which container image to use and which commands to execute inside running containers.Swarm mode allows users to specify a group of homogenous containers which are meant to be kept running with the docker service CLI. Its ever running process.This abstraction which is undoubtedly powerful, may not be the right fit for containers which are intended to eventually terminate or only run periodically.
Hence, one might need to run some containers for specific period of time and terminate it acccordingly.

Let us consider few example:

- You are a System Administrator who wishes to allow users to submit long-running compiler jobs on a Swarm cluster
- A website which needs to process all user uploaded images into thumbnails of various sizes
- An operator who wishes to periodically run docker rmi $(docker images --filter dangling=true -q) on each machine

Today Docker Swarm doesn't come with this feature by default. But there are various workaround to make it work.
Under this tutorial, we will show you how to run on-off cron-job on 5-Node Swarm Mode Cluster.


## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Play with Docker</b></td>
    <td class="tg-yw4l"><b>5</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Spanner** on the left side of the screen to bring up 5-Node Swarm Mode Cluster


## Verifying 5-Node Swarm Mode Cluster

```
$ docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS
 ENGINE VERSION
y2ewcgx27qs4qmny9840zj92p *   manager1            Ready               Active              Leader
 18.06.1-ce
qog23yabu33mpucu9st4ibvp5     manager2            Ready               Active              Reachable
 18.06.1-ce
tq0ed0p2gk5n46ak4i1yek9yc     manager3            Ready               Active              Reachable
 18.06.1-ce
tmbcma9d3zm8jcx965ucqu2mf     worker1             Ready               Active
 18.06.1-ce
dhht9gr8lhbeilrbz195ffhrn     worker2             Ready               Active
 18.06.1-ce
 ```
 
 ## Cloning the Repository
 
 ```
 git clone https://github.com/crazy-max/swarm-cronjob
 cd swarm-cronjob/.res/example
 ```
 
 ## Bring up Swarm Cronjob
 
 ```
 docker stack deploy -c swarm_cronjob.yml swarm_cronjob
 ```
 
 ## Listing Docker Services
 
 ```
 $ docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE
   PORTS

qsmd3x69jds1        myswarm_app         replicated          1/1                 crazymax/swarm-cronjob:latest

```
## Visualizing the Swarm Cluster running Cronjob container

```
git clone https://github.com/collabnix/dockerlabs
cd dockerlabs/intermediate/swarm/visualizer/
```

```
docker-compose up -d
```



![My image](https://github.com/collabnix/dockerlabs/blob/master/intermediate/swarm/images/app1.png)

## Example #1: Running Date container every 5 seconds

![My image](https://github.com/collabnix/dockerlabs/blob/master/intermediate/swarm/images/cronjobapp.png)

Edit date.yml file to change cronjob from * to */5 to run every 5 seconds as shown:

```
$ cd .res/example/
$ cat date.yml
version: "3.2"
services:  test:    image: busybox    command: date    deploy:
      labels:
        - "swarm.cronjob.enable=true"
        - "swarm.cronjob.schedule=*/5 * * * *"
        - "swarm.cronjob.skip-running=false"
      replicas: 0
      restart_policy:
        condition: none
[manager1] (local) roo
```

## Bringing up App Stack

```
docker stack deploy -c date.yml date
```


![My image](https://github.com/collabnix/dockerlabs/blob/master/intermediate/swarm/images/app2.png)

## Contributor

- [Ajeet Sing Raina](ajeetraina@gmail.com)

## Special Credits

https://github.com/crazy-max/swarm-cronjob




  
  
  
  
