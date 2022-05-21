# Lab2 - Deploy Service

By default, Docker uses a spread replication model for deciding which containers should run on which hosts. 
The spread approach ensures that containers are deployed across the cluster evenly. This means that if one of the nodes is removed from 
the cluster,  the instances would be already running on the other nodes. There workload on the removed node would be rescheduled across 
the remaining available nodes.

A new concept of Services is used to run containers across the cluster. This is a higher-level concept than containers.
A service allows you to define how applications should be deployed at scale. By updating the service, Docker updates the container 
required in a managed way.

## Task

In this case, we are deploying the Docker Image ajeetraina/hellowhale. We are defining a friendly name of a service called 
http and that it should be attached to the newly created collabnet network.

For ensuring replication and availability, we are running two instances, of replicas, of the container across our cluster.

Finally, we load balance these two containers together on port 80. Sending an HTTP request to any of the nodes in the cluster will process the request by one of the containers within the cluster.
The node which accepted the request might not be the node where the container responds. Instead, Docker load-balances requests across all available containers.

```
docker service create --name http --network collabnet --replicas 2 -p 80:80 ajeetraina/hellowhale
```

You can view the services running on the cluster using the CLI command docker service ls

As containers are started you will see them using the ps command. You should see one instance of the container on each host.

List containers on the first host - 

```
docker ps
```

List containers on the second host - 

```
docker ps
```

If we issue an HTTP request to the public port, it will be processed by the two containers  

```
 curl your_machine_ip:80
```
[Lab3 - Inspecting State](lab3-inspect-services.md)
