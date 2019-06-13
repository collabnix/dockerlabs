# Lab07 - Cleaning Up

Execute the docker service rm sleep-app command on manager1 to remove the service called sleep-app.

```
$ docker service rm sleep-app
sleep-app
[manager1] (local) root@192.168.0.9 ~/dockerlabs/intermediate/swarm
$ docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE     PORTS
```

Execute the docker ps command on node1 to get a list of running containers.

```
docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
044bea1c2277        ubuntu              "sleep infinity"    17 minutes ago      17 minutes ag                           distracted_mayer
```


You can use the docker kill <CONTAINER ID> command on node1 to kill the sleep container we started at the beginning.

```
docker kill yourcontainerid
```

Finally, let’s remove node1, node2, and node3 from the Swarm. We can use the docker swarm leave --force command to do that.

Lets run docker swarm leave --force on all the nodes to leave swarm cluster.

```
docker swarm leave --force
```

Congratulations! You’ve completed this lab. You now know how to build a swarm, deploy applications as collections of services, and scale individual services up and down.

[Next >> ]()

