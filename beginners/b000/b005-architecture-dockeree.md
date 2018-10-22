# Architecture of Docker Enteprise Edition 2.0

* Docker EE is more than just a container orchestration solution.
* It is a full lifecycle management solution for the modernization of traditional applications and microservices across a broad set of infrastructure platforms. 
* It is a Containers-as-a-Service(CaaS) platform for IT that manages and secures diverse applications across disparate infrastructure, both on-premises and in the cloud. 
* Docker EE provides an integrated, tested and certified platform for apps running on enterprise Linux or Windows operating systems and Cloud providers. 
* It is tightly integrated to the underlying infrastructure to provide a native, easy to install experience and an optimized Docker environment.

Docker EE 2.0 GA consists of 3 major components which together enable a full software supply chain, from image creation, to secure image storage, to secure image deployment.

## Universal Control Plane 3.0.0 (application and cluster management):

Deploys applications from images, by managing orchestrators, like Kubernetes and Swarm. UCP is designed for high availability (HA). You can join multiple UCP manager nodes to the cluster, and if one manager node fails, another takes its place automatically without impact to the cluster.

## Docker Trusted Registry 2.5.0:

The production-grade image storage solution from Docker.

## EE Engine 17.06.2:

The commercially supported Docker engine for creating images and running them in Docker containers.

## Does Docker EE support Kubernetes?

Yes, Kubernetes in Docker EE fully supports all Docker EE features, including role-based access control, LDAP/AD integration, scanning,  signing enforcement, and security policies.

## Kubernetes features on Docker EE include:

- Kubernetes orchestration full feature set
- CNCF Certified Kubernetes conformance
- Kubernetes app deployment by using web UI or CLI
- Compose stack deployment for Swarm and Kubernetes apps
- Role-based access control for Kubernetes workloads
- Pod-based autoscaling, to increase and decrease pod count based on CPU usage
- Blue-Green deployments, for load balancing to different app versions
- Ingress Controllers with Kubernetes L7 routing
- Interoperability between Swarm and Kubernetes workloads for networking and storage.
