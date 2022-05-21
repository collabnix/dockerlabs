# Components of Docker Enterprise 

Docker Enterprise enables deploying your workloads for high availability (HA) onto the orchestrator of your choice. Docker Enterprise system components can run on multiple manager nodes in the cluster, and if one manager node fails, another takes its place automatically, without impact to the cluster. <br>

Docker Enterprise has three major components, which together enable a full software supply chain, from image creation, to secure image storage, to secure image deployment ```Docker Engine```, ```DTR```, ```UCP```. <br>

* **Docker Engine - Enterprise**: The commercially supported Docker engine for creating images and running them in Docker containers.

* **Docker Trusted Registry (DTR)**: The production-grade image storage solution from Docker.
    DTR is designed to scale horizontally as your usage increases. You can add more replicas to make DTR scale to your demand and for high availability.
    All DTR replicas run the same set of services, and changes to their configuration are propagated automatically to other replicas.

* **Universal Control Plane (UCP)**: Deploys applications from images, by managing orchestrators, like Kubernetes and Swarm.
    UCP is designed for high availability (HA). You can join multiple UCP manager nodes to the cluster, and if one manager node fails, another takes its place automatically without impact to the cluster.
    Changes to the configuration of one UCP manager node are propagated automatically to other nodes.

* **Docker Kubernetes Service**: At Docker, we recognize that much of Kubernetes' perceived complexity stems from a lack of intuitive security and manageable configurations that most enterprises expect and require for production-grade software. Docker Kubernetes Service (DKS) is a certified Kubernetes distribution that is included with Docker Enterprise and is designed to solve this fundamental challenge. It is the only offering that integrates Kubernetes from the developer desktop to production servers. Simply put, DKS makes Kubernetes easy to use and more secure for the entire organization.
     DKS comes hardened out-of-the-box with 'sensible secure defaults' that enterprises expect and require for production-grade deployments. These include out-of-the-box configurations for security, encryption, access control, and lifecycle management — all without having to become a Kubernetes expert. DKS also allows organizations to integrate their existing LDAP and SAML-based authentication solutions with Kubernetes RBAC for simple multi-tenancy.

* **Docker Desktop Enterprise**: Docker Desktop Enterprise (DDE) is a desktop offering that is the easiest, fastest and most secure way to create and deliver production-ready containerized applications. Developers can work with frameworks and languages of their choice, while IT can securely configure, deploy and manage development environments that align to corporate standards and practices. This enables organizations to rapidly deliver containerized applications from development to production. DDE provides a secure way to configure, deploy and manage developer environments while enforcing safe development standards that align to corporate policies and practices. IT teams and application architects can present developers with application templates designed specifically for their team, to bootstrap and standardize the development process and provide a consistent environment all the way to production.
    IT desktop admins can securely deploy and manage Docker Desktop Enterprise across distributed development teams with their preferred endpoint management tools using standard MSI and PKG files. No manual intervention or extra configuration from developers is required and desktop administrators can enable or disable particular settings within Docker Desktop Enterprise to meet corporate standards and provide the best developer experience.

Together they provide an integrated solution with the following design goals:

* Agility — the Docker API is used to interface with the platform so that operational features do not slow down application delivery
* Portability — the platform abstracts details of the infrastructure for applications
* Control — the environment is secure by default, provides robust access control, and logging of all operations
To achieve these goals the platform must be resilient and highly available. This reference architecture demonstrates this robust configuration.
