# Lab04 - Scale Service

A Service allows us to scale how many instances of a task is running across the cluster. 
As it understands how to launch containers and which containers are running, it can easily start, or remove, containers as required. 
At the moment the scaling is manual. However, the API could be hooked up to an external system such as a metrics dashboard.

# Task

At present, we have two load-balanced containers running, which are processing our requests curl docker

The command below will scale our http service to be running across five containers.

```
docker service scale http=5
```

```
 docker service scale http=5
http scaled to 5
overall progress: 5 out of 5 tasks
1/5: running   [==================================================>]
2/5: running   [==================================================>]
3/5: running   [==================================================>]
4/5: running   [==================================================>]
5/5: running   [==================================================>]
verify: Waiting 4 seconds to verify that tasks are stable...
verify: Service converged
[manager1] (local) root@192.168.0.4 ~
$
[manager1] (local) root@192.168.0.4 ~
```

On each host, you will see additional nodes being started docker ps

The load balancer will automatically be updated. Requests will now be processed across the new containers. 
Try issuing more commands via 

```
curl your_machine_ip:80
```

Try scaling the service down to see the result.

```
docker service scale http=2
```

[Next >> Lab05 - Deploy Applications Components as Docker Services](https://github.com/collabnix/dockerlabs/blob/master/intermediate/swarm/lab05-deploy-application-components-as-docker-services.md)
