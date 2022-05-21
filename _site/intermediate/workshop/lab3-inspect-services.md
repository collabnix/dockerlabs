# Lab03 - Inspecting State

The Service concept allows you to inspect the health and state of your cluster and the running applications.

## Task

You can view the list of all the tasks associated with a service across the cluster. 
In this case, each task is a container, 

```
docker service ps http
```

You can view the details and configuration of a service via 

```
docker service inspect --pretty http
```

On each node, you can ask what tasks it is currently running. Self refers to the manager node Leader: 

```
docker node ps self
```

Using the ID of a node you can query individual hosts 

```
docker node ps $(docker node ls -q | head -n1)
```

In the next step, we will scale the service to run more instances of the container.

[Lab4 - Scale Services](lab4-scaling-services.md)
