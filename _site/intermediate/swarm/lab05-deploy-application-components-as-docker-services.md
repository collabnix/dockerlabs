# Lab #05 - Deploy the application components as Docker services

Our sleep application is becoming very popular on the internet (due to hitting Reddit and HN). 
People just love it. So, you are going to have to scale your application to meet peak demand. 
You will have to do this across multiple hosts for high availability too. 
We will use the concept of Services to scale our application easily and manage many containers as a single entity.

Services were a new concept in Docker 1.12. They work with swarms and are intended for long-running containers.

Let’s deploy sleep as a Service across our Docker Swarm.



```
$ docker service create --name sleep-app ubuntu sleep infinity
k70j90k9cp5n2bxsq72tjdmxs
overall progress: 1 out of 1 tasks
1/1: running
verify: Service converged
```

Verify that the service create has been received by the Swarm manager.

```
$ docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE
     PORTS
k70j90k9cp5n        sleep-app           replicated          1/1                 ubuntu:latest

```

The state of the service may change a couple times until it is running. The image is being downloaded from Docker Store to the other engines in the Swarm. Once the image is downloaded the container goes into a running state on one of the three nodes.

At this point it may not seem that we have done anything very differently than just running a docker run. We have again deployed a single container on a single host. The difference here is that the container has been scheduled on a swarm cluster.

Well done. You have deployed the sleep-app to your new Swarm using Docker services.


# Scaling the Application

Demand is crazy! Everybody loves your sleep app! It’s time to scale out.

One of the great things about services is that you can scale them up and down to meet demand. In this step you’ll scale the service up and then back down.

You will perform the following procedure from node1.

Scale the number of containers in the sleep-app service to 7 with the docker service update --replicas 7 sleep-app command. Replicas is the term we use to describe identical containers providing the same service.

```
$ docker service update --replicas 7 sleep-app
sleep-app
overall progress: 7 out of 7 tasks
1/7: running
2/7: running
3/7: running
4/7: running
5/7: running
6/7: running
7/7: running
verify: Service converged
```

```
$ docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE     PORTS
k70j90k9cp5n        sleep-app           replicated          7/7                 ubuntu:latest
```

The Swarm manager schedules so that there are 7 sleep-app containers in the cluster. These will be scheduled evenly across the Swarm members.

We are going to use the docker service ps sleep-app command. If you do this quick enough after using the --replicas option you can see the containers come up in real time.

```
$ docker service ps sleep-app
ID                  NAME                IMAGE               NODE                DESIRED STATE     CURRENT STATE                ERROR               PORTS
bv6ofc6x6moq        sleep-app.1         ubuntu:latest       manager1            Running     Running 6 minutes ago
5gj1ql7sjt14        sleep-app.2         ubuntu:latest       manager2            Running     Running about a minute ago
p01z0tchepwa        sleep-app.3         ubuntu:latest       worker2             Running     Running about a minute ago
x3kwnjcwxnb0        sleep-app.4         ubuntu:latest       worker2             Running     Running about a minute ago
c98vxyeefmru        sleep-app.5         ubuntu:latest       manager1            Running     Running about a minute ago
kwmey288bkhp        sleep-app.6         ubuntu:latest       manager3            Running     Running about a minute ago
vu78hp6bhauq        sleep-app.7         ubuntu:latest       worker1             Running     Running about a minute ago
```

Notice that there are now 7 containers listed. It may take a few seconds for the new containers in the service to all show as RUNNING. The NODE column tells us on which node a container is running.

Scale the service back down to just four containers with the docker service update --replicas 4 sleep-app command.

```
$ docker service update --replicas 4 sleep-app
sleep-app
overall progress: 4 out of 4 tasks
1/4: running
2/4: running
3/4: running
4/4: running
verify: Service converged
```

```
[manager1] (local) root@192.168.0.9 ~/dockerlabs/intermediate/swarm
$ docker service ps sleep-app
ID                  NAME                IMAGE               NODE                DESIRED STATE     CURRENT STATE           ERROR               PORTS
bv6ofc6x6moq        sleep-app.1         ubuntu:latest       manager1            Running     Running 7 minutes ago
5gj1ql7sjt14        sleep-app.2         ubuntu:latest       manager2            Running     Running 2 minutes ago
p01z0tchepwa        sleep-app.3         ubuntu:latest       worker2             Running     Running 2 minutes ago
kwmey288bkhp        sleep-app.6         ubuntu:latest       manager3            Running     Running 2 minutes ago
```

You have successfully scaled a swarm service up and down.


[Next >> Lab06 - Drain a Node and Reschedule the Containers ](https://github.com/collabnix/dockerlabs/blob/master/intermediate/swarm/lab06-drain-a-node-and-reschedule-the-containers.md)
