
# What is Docker Enterprise and why do we need it?

In March 2017, Docker Inc. announced the immediate availability Docker Enterprise Edition (EE), a new version of the Docker platform
optimized for business-critical deployments.

Docker Enterprise Edition (EE) is an integrated, supported and certified container platform for:

- CentOS
- Microsoft Windows Server 2016
- Oracle Linux

![My image](https://github.com/collabnix/dockerlabs/blob/master/advanced/enterprise/dockerlabs1.png)

•	Red Hat Enterprise Linux (RHEL)
•	SUSE Linux Enterprise Server
•	Ubuntu
•	IBM Z


It also supports both AWS and Microsoft Azure cloud providers. Docker released the following three versions:

- Docker EE – Basic (commercial support)
•	Docker EE – Standard (workflow and management)
•	Docker EE – Advanced (workflow, management, and security scanning)

##  Benefits

The best benefit of Docker EE is certification. Certification equals trust. Now when enterprises run Docker EE on a certified platform, they will have confirmation that the release is production grade. That means both Docker and the underlying infrastructure partner worked together to release a robust, tested version they will support and fix if needed.


# What are components of Docker Enterprise?

Docker Enterprise has three major components, which together enable a full software supply chain, from image creation, to secure image storage, to secure image deployment.


- Docker Engine - Enterprise: The commercially supported Docker engine for creating images and running them in Docker containers.
- 	Docker Trusted Registry (DTR): The production-grade image storage solution from Docker.

DTR is designed to scale horizontally as your usage increases. You can add more replicas to make DTR scale to your demand and for high availability.

All DTR replicas run the same set of services, and changes to their configuration are propagated automatically to other replicas.

-	Universal Control Plane (UCP): Deploys applications from images, by managing orchestrators, like Kubernetes and Swarm.
UCP is designed for high availability (HA). You can join multiple UCP manager nodes to the cluster, and if one manager node fails, another takes its place automatically without impact to the cluster.

## Overview of Universal Control Plane

- 	Docker UCP is a containerized application that runs on Docker Engine - Enterprise and extends its functionality to make it easier to deploy, configure, and monitor our applications at scale.
- 	Docker Universal Control Plane (UCP) is the enterprise-grade cluster management solution from Docker. We can install it on-premises or in the virtual private cloud, and it helps us manage our Docker cluster and applications through a single interface

## Deep Dive into Docker Enterprise Architecture

Docker Enterprise enables deploying our workloads for high availability (HA) onto the orchestrator of our choice. Docker Enterprise system components can run on multiple manager nodes in the cluster, and if one manager node fails, another takes its place automatically, without impact to the cluster.

## Choosing our orchestrator:

Docker Enterprise provides access to the full API sets of three popular orchestrators:
•	Kubernetes: Full YAML object support
•	SwarmKit: Service-centric, Compose file version 3
•	“Classic” Swarm: Container-centric, Compose file version 2

 



