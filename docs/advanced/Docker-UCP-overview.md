# Universal Control Plane overview
Universal Control Plane is a containerized application that runs on
**Docker Enterprise Edition**, extending its functionality
to simplify the deployment, configuration, and monitoring of your applications at scale.

![](https://github.com/apurvabhandari/images/blob/master/ucp-architecture.svg)

Once Universal Control Plane (UCP) instance is deployed, developers and IT
operations no longer interact with Docker Engine directly, but interact with
UCP instead. Since UCP exposes the standard Docker API, this is all done
transparently, so that you can use the tools you already know and love, like
the Docker CLI client and Docker Compose.

## Features <br>
* **Docker Universal Control Plane (UCP)** is the enterprise-grade cluster management solution from Docker. You install it on-premises or in your virtual private cloud, and it helps you manage your Docker cluster and applications through a single interface.
* **Centralized cluster management**
With Docker, you can join up to thousands of physical or virtual machines together to create a container cluster that allows you to deploy your applications at scale. Docker Universal Control Plane extends the functionality provided by Docker to make it easier to manage your cluster from a centralized place.
* **Deploy, manage, and monitor**
With Docker UCP, you can manage from a centralized place all of the computing resources you have available, like nodes, volumes, and networks.
You can also deploy and monitor your applications and services.
* **Built-in security and access control**
Docker UCP has its own built-in authentication mechanism and integrates with LDAP services. It also has role-based access control (RBAC), so that you can control who can access and make changes to your cluster and applications. 
Docker UCP integrates with **Docker Trusted Registry** so that you can keep the Docker images you use for your applications behind your firewall, where they are safe and can’t be tampered with.
You can also enforce security policies and only allow running applications that use Docker images you know and trust.

## UCP Dashboard 
![img](https://raw.githubusercontent.com/apurvabhandari/images/master/overview-1.png) <br>

## Under the hood

Docker UCP leverages the clustering and orchestration functionality provided
by Docker.

![](https://github.com/apurvabhandari/images/blob/master/ucp-arch(1).svg)

A swarm is a collection of nodes that are in the same Docker cluster.
`Node` in a Docker swarm operate in one of two
modes: Manager or Worker. If nodes are not already running in a swarm when
installing UCP, nodes will be configured to run in swarm mode.

When you deploy UCP, it starts running a globally scheduled service called
`ucp-agent`. This service monitors the node where it's running and starts
and stops UCP services, based on whether the node is a
`manager or a worker node`.

If the node is a:

* **Manager**: the `ucp-agent` service automatically starts serving all UCP
  components, including the UCP web UI and data stores used by UCP. The
  `ucp-agent` accomplishes this by
  `deploying several containers`
  on the node. By promoting a node to manager, UCP automatically becomes
  highly available and fault tolerant.
* **Worker**: on worker nodes, the `ucp-agent` service starts serving a proxy
  service that ensures only authorized users and other UCP services can run
  Docker commands in that node. The `ucp-agent` deploys a
  `subset of containers` on worker nodes.


## How you interact with UCP

There are two ways to interact with UCP: the web UI or the CLI.

You can use the UCP web UI to manage your swarm, grant and revoke user
permissions, deploy, configure, manage, and monitor your applications.

![](https://github.com/apurvabhandari/images/blob/master/ucp-arch(2).svg)

UCP also exposes the standard Docker API, so you can continue using existing
tools like the Docker CLI client. Since UCP secures your cluster with role-based
access control, you need to configure your Docker CLI client and other client
tools to authenticate your requests using
`client certificates` that you can download
from your UCP profile page.


## Use the Docker CLI client
Because UCP exposes the standard Docker API, you can continue using the tools you already know, including the Docker CLI client, to deploy and manage your applications.

For example, you can use the docker info command to check the status of a cluster that’s managed by UCP:

```docker info```
This command produces the output that you expect from the Docker EE Engine:

```
Containers: 38
Running: 23
Paused: 0
Stopped: 15
Images: 17
Server Version: 17.06
...
Swarm: active
NodeID: ocpv7el0uz8g9q7dmw8ay4yps
Is Manager: true
ClusterID: tylpv1kxjtgoik2jnrg8pvkg6
Managers: 
```
