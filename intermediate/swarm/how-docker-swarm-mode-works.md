# How Docker Swarm Mode Works?

Let us first understand what is Swarm Mode and what are its key concepts.

In 1.12, Docker introduced Swarm Mode. Swarm Mode enables the ability to deploy containers across multiple Docker hosts, using overlay networks for service discovery with a built-in load balancer for scaling the services.

Swarm Mode is managed as part of the Docker CLI, making it a seamless experience to the Docker ecosystem.

## Key Concepts

Docker Swarm Mode introduces three new concepts which we'll explore in this scenario.

### Node: 

A Node is an instance of the Docker Engine connected to the Swarm. Nodes are either managers or workers. Managers schedules which containers to run where. Workers execute the tasks. By default, Managers are also workers.

### Services: 

A service is a high-level concept relating to a collection of tasks to be executed by workers. An example of a service is an HTTP Server running as a Docker Container on three nodes.

### Load Balancing: 

Docker includes a load balancer to process requests across all containers in the service.

## Step 1 - Initialise Swarm Mode

Turn single host Docker host into a Multi-host Docker Swarm Mode. Becomes Manager By default, Docker works as an isolated single-node. All containers are only deployed onto the engine. Swarm Mode turns it into a multi-host cluster-aware engine.

The first node to initialise the Swarm Mode becomes the manager. As new nodes join the cluster, they can adjust their roles between managers or workers. You should run 3-5 managers in a production environment to ensure high availability.



```
docker swarm init
```

After running the command, the Docker Engine knows how to work with a cluster and becomes the manager. The results of an initialisation is a token used to add additional nodes in a secure fashion. 

## Task: Create Swarm Mode Cluster

Swarm Mode is built into the Docker CLI. You can find an overview the possibility commands via docker swarm --help

The most important one is how to initialise Swarm Mode. Initialisation is done via init.

## Step 2 - Join Cluster

With Swarm Mode enabled, it is possible to add additional nodes and issues commands across all of them. If nodes happen to disappear, for example, because of a crash, the containers which were running on those hosts will be automatically rescheduled onto other available nodes. The rescheduling ensures you do not lose capacity and provides high-availability.

On each additional node, you wish to add to the cluster, use the Docker CLI to join the existing group. Joining is done by pointing the other host to a current manager of the cluster. In this case, the first host.

Swarm Mode is built into the Docker CLI. You can find an overview the possibility commands via docker swarm --help




[Next >> Deploy Application Components as Docker Services ](https://github.com/collabnix/dockerlabs/blob/master/intermediate/swarm/lab01-deploy-application-components-as-docker-services.md)




