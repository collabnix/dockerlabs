
# Understanding Difference between Docker Swarm(Classic), Swarm Mode & SwarmKit


**Docker Swarm**  is an older (2014) Docker native orchestration tool. It is _standalone_ from the Docker engine and serves to connect Docker engines together to form a cluster. It&#39;s then possible to connect to the Swarm and run containers on the cluster. Swarm has a few features:

- Allows us to specify a discovery service
- Some control over where containers are placed (using filters / constraints / distribution strategies, etc...)
- Exposes the same API as the Docker engine itself, allowing 3rd-party tools to interact seamlessly

**Swarmkit**  is a new (2016) tool developed by the Docker team which provides functionality for running a cluster and distributing tasks to the machines in the cluster. Here are the main features:

- Distributed: SwarmKit uses the Raft Consensus Algorithm in order to coordinate and does not rely on a single point of failure to perform decisions.
- Secure: Node communication and membership within a Swarm are secure out of the box. SwarmKit uses mutual TLS for node authentication, role authorization and transport encryption, automating both certificate issuance and rotation.
- Simple: SwarmKit is operationally simple and minimizes infrastructure dependencies. It does not need an external database to operate.

**Docker Swarm Mode (Version 1.12 >)** _uses_ Swarmkit libraries &amp; functionality in order to make container orchestration over multiple hosts (a cluster) very simple &amp; secure to operate. There is a new set of features (the main one being docker swarm) which are now built into Docker itself to allow us to initiate a new Swarm and deploy _tasks_ to that cluster.

**Docker Swarm** is not being deprecated, and is still a viable method for Docker multi-host orchestration, but  **Docker Swarm Mode**  (which uses the  **Swarmkit**  libraries under the hood) is the recommended way to begin a new Docker project where orchestration over multiple hosts is required.

One of the big features in Docker 1.12 release is Swarm mode. Docker had Swarm available for Container orchestration from 1.6 release. Docker released Swarmkit as an opensource project for orchestrating distributed systems few weeks before Docker 1.12(RC) release.

&quot;Swarm&quot; refers to traditional Swarm functionality, &quot;Swarm Mode&quot; refers to new Swarm mode added in 1.12, &quot;Swarmkit&quot; refers to the plumbing open source orchestration project.

### Swarm, Swarm Mode and Swarmkit

Following table compares Swarm and Swarm Mode :

| **Swarm** | **Swarm Mode** |
| --- | --- |
| Separate from Docker Engine and can run as Container | Integrated inside Docker engine |
| Needs external KV store like Consul | No need of separate external KV store |
| Service model not available | Service model is available. This provides features like scaling, rolling update, service discovery, load balancing and routing mesh |
| Communication not secure | Both control and data plane is secure |
| Integrated with machine and compose | Not yet integrated with machine and compose as of release 1.12. Will be integrated in the upcoming releases |

Following table compares Swarmkit and Swarm Mode:

| **Swarmkit** | **Swarm Mode** |
| --- | --- |
| Plumbing opensource project | Swarmkit used within Swarm Mode and tightly integrated with Docker Engine |
| Swarmkit needs to built and run separately | Docker 1.12 comes integrated with Swarm Mode |
| No service discovery, load balancing and routing mesh | Service discovery, load balancing and routing mesh available |
| Use swarmctl CLI | Use regular Docker CLI |

Swarmkit has primitives to handle orchestration features like node management, discovery, security and scheduling.

[Proceed >> How Docker Swarm Mode works](https://github.com/collabnix/dockerlabs/blob/master/intermediate/swarm/how-docker-swarm-mode-works.md)
