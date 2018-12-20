# Docker Enterprise 2.0
# What's New in Docker Enterprise 2.0?
Docker EE 2.0 is incredibly flexible 
Flexibility is one of the biggest assets of Docker Enterprise Edition as today’s software delivery ecosystem demands freedom of choice. Organizations that are building applications on different platforms, using varied set of tools, deploying on different infrastructures and running them on different set of platforms require a huge amount of flexibility. Docker EE has addressed this concern with the following capabilities:
Multi-Linux, Multi-OS, Multi-Cloud
Many organizations have adopted a Hybrid cloud or Multi-cloud strategy, and build applications on different operating systems. Docker EE is registered across all the popular set of operating systems such as Windows, all the popular Linux distributions, Windows Server, and also on popular public clouds, enabling the users to deploy applications flexibly, wherever required.

Docker EE 2.0 is interoperable with Docker Swarm and Kubernetes
Container orchestration forms the core of DevOps and the entire ecosystem of containers revolve around Swarm or Kubernetes. Docker EE allows flexibility is switching between both these tools for application deployment and orchestration. Applications deployed on Swarm today, can be easily migrated to Kubernetes using the same compose file, making the life of developers simpler.

Accelerating agile with Docker Enterprise Edition 2.0
Docker EE focuses on monitoring and managing containers to much greater extent than the open source version of Docker. The Enterprise Edition has specialized management and monitoring platform for looking after Kubernetes cluster and also has access to Kubernetes API, CLI and interfaces.

Cluster management made simple:
•	Easy-to-use cluster management services:
o	Basic single line commands for adding cluster
o	High availability of management plane
o	Access to consoles and logs
o	Securing configurations
•	Secure application zones: With swift integration with corporate LDAPs and Active Directory system, we can divide a single cluster logically and physically into different teams. This seems to be the most convenient way to assign new namespaces to Kubernetes clusters.
•	Layer 7 routing for Swarm: The new interlock 2.0 architecture provides new and optimized enhancements for network routing in Swarm. For more information on interlock architecture, refer the official Docker blog.
•	Kubernetes: All the core components of Kubernetes environment like APIs, CLIs are available for users in a CCNF- conformant Kubernetes stack.

# How to Upgrade from Docker CE to EE

Docker Community Edition (CE) is ideal for developers and small teams looking to get started with Docker and experimenting with container-based apps. Docker Enterprise Edition (EE) is designed for enterprise development and IT teams who build, ship, and run business critical applications in production at scale. Users who start off on CE may wish to change to EE for business operational or other reasons.
Since CE and EE are distributed as separate application binaries, the migration path from CE to EE involves reinstalling Docker and cannot be performed in an existing environment without redeploying the environment.
Uninstall Docker CE, and then install Docker EE



