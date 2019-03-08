# Deploy the application components as Docker services

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

