# Can container communication cross over to noncontainerized apps?

## Que: Can an application have Python as a container, run SQL queries on an external Microsoft SQL database and publish the results on an Apache web server container?

Containers resemble VMs in that they get full network access and can connect to any other service on the internet as long as the containers are configured to do so.


For example, containers on the AWS Fargate compute engine for containers and Kubernetes can have their own IP addresses and be used to network with any service that is internet-enabled. Containers can also exist behind virtual private clouds (VPCs) -- which are walled-off dedicated resources on AWS or another public cloud host -- or other network firewalls that isolate and protect them from outside connections. Container communication isn't much different than other application deployment strategies, as long as you understand the options.

In addition to containers' ability to connect to anything outside of their environment through traditional networks, they can also use Docker's bridge networks to connect to other Docker containers running on the same physical system. They can also employ overlay networks to connect to services running on other Docker hosts.

Although no longer recommended, Docker links can also join multiple containers together to provide one service. Consider how a Python container can run SQL queries against a Docker container that's running Microsoft SQL, and publish those results to an Apache web server in another container.

* Please Note - Docker Inc. states that the functionality of Docker links was incorporated into Docker networks, adding capabilities and integrating with the network options for better security, multihost overlay networking, DNS, automatic load balancing and simpler configuration. Docker links is still available as a legacy feature but not recommended by the company.

To make much of this container communication in networking easier, services like AWS Fargate enable developers to run multiple containers within the same task and automatically link them.


Containers and VMs differ in many key ways, but in terms of network communication, they're surprisingly similar.
When the workload moves around as described, security for container communication is not different from when it stays within the container deployment. The only real concern is if the workload gets passed over the open web -- just like with any other app. However, if the deployment uses a VPC -- or the containers communicate through Docker links -- security is not really an issue.

There's a wide range of networking options for different container communication setups with Docker. Some allow just connecting to outside services, and others create a private internal connection to other Docker containers. In general, anything you can do with a traditional VM can be done with a Docker container. You can make networking with Docker as complex, or simple, as the application requires
