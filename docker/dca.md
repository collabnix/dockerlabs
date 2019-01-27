# Docker Certified Associate Exam Preparation Guide (v1.0.1)

This guide is intended to be a point of knowledge for everyone who wants to pass [Docker Certified Associate Exam](https://blog.docker.com/2017/09/introducing-docker-global-professional-certification-program/). The main idea is to provide the right answer/link to every "question" in every domain. Feel free to add useful links below. 

## Table of Contents:
1. [Orchestration](https://github.com/Evalle/DCA/blob/master/README.md#domain-1-orchestration-25-of-exam)
2. [Image Creation, Management, and Registry](https://github.com/Evalle/DCA/blob/master/README.md#domain-2-image-creation-management-and-registry-20-of-exam)
3. [Installation and Configuration](https://github.com/Evalle/DCA/blob/master/README.md#domain-3-installation-and-configuration-15-of-exam)
4. [Networking](https://github.com/Evalle/DCA/blob/master/README.md#domain-4-networking-15-of-exam)
5. [Security](https://github.com/Evalle/DCA/blob/master/README.md#domain-5-security-15-of-exam)
6. [Storage and Volumes](https://github.com/Evalle/DCA/blob/master/README.md#domain-6-storage-and-volumes-10-of-exam)
7. [Links](https://github.com/evalle/dca#links)

## Content

### Domain 1: Orchestration (25% of exam)
- [Complete the setup of a swarm mode cluster, with managers and worker nodes](https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/)
- [State the differences between running a container vs running a service](https://stackoverflow.com/a/43408904)
- [Demonstrate steps to lock a swarm cluster](https://docs.docker.com/engine/swarm/swarm_manager_locking/)
- [Extend the instructions to run individual containers into running services under swarm](https://docs.docker.com/engine/swarm/swarm-tutorial/deploy-service/)
- [Interpret the output of "docker inspect" commands](https://docs.docker.com/engine/swarm/swarm-tutorial/inspect-service/)
- [Convert an application deployment into a stack file using a YAML compose file with
"docker stack deploy"](https://docs.docker.com/engine/reference/commandline/stack_deploy/)
- [Manipulate a running stack of services](https://docs.docker.com/engine/reference/commandline/stack_services/#related-commands)
- [Increase number of replicas](https://docs.docker.com/engine/reference/commandline/service_scale/)
- [Illustrate running a replicated vs global service](https://docs.docker.com/engine/swarm/how-swarm-mode-works/services/#replicated-and-global-services)
- [Mount volumes](https://docs.docker.com/engine/admin/volumes/volumes/)
- [Add networks, publish ports](https://docs.docker.com/engine/userguide/networking/)
- [Identify the steps needed to troubleshoot a service not deploying](https://docs.docker.com/engine/swarm/swarm-tutorial/deploy-service/)
- [Apply node labels to demonstrate placement of tasks](https://docs.docker.com/engine/reference/commandline/node_update/)
- [Sketch how a Dockerized application communicates with legacy systems](https://docs.docker.com/config/containers/container-networking/)
- [Paraphrase the importance of quorum in a swarm cluster](https://docs.docker.com/engine/swarm/raft/)
- [Demonstrate the usage of templates with "docker service create"](https://docs.docker.com/engine/reference/commandline/service_create/#create-services-using-templates)

### Domain 2: Image Creation, Management, and Registry (20% of exam)
- [Describe Dockerfile options(add, copy, volumes, expose, entrypoint, etc)](https://docs.docker.com/engine/reference/builder/#from)
- [Show the main parts of a Dockerfile](https://docs.docker.com/engine/reference/builder/#dockerfile-examples)
- [Give examples on how to create an efficient image via a Dockerfile](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/)
- [Use CLI commands such as list, delete, prune, rmi, etc to manage images](https://docs.docker.com/engine/reference/commandline/image/#usage)
- [Inspect images and report specific attributes using filter and format](https://docs.docker.com/engine/reference/commandline/inspect/#extended-description)
- [Demonstrate tagging an image](https://docs.docker.com/engine/reference/commandline/tag/)
- [Utilize a registry to store an image](https://docs.docker.com/registry/deploying/#copy-an-image-from-docker-hub-to-your-registry)
- [Display layers of a Docker image](http://blog.arungupta.me/show-layers-of-docker-image/)
- [Apply a file to create a Docker image](https://docs.docker.com/engine/reference/commandline/image_load/)
- [Modify an image to a single layer](https://tuhrig.de/flatten-a-docker-container-or-image/)
- [Describe how image layers work](https://medium.com/@jessgreb01/digging-into-docker-layers-c22f948ed612)
- [Deploy a registry (not architect)](https://docs.docker.com/registry/deploying/)
- [Configure a registry](https://docs.docker.com/registry/configuration/)
- [Log into a registry](https://docs.docker.com/engine/reference/commandline/login/#parent-command)
- [Utilize search in a registry](https://docs.docker.com/engine/reference/commandline/search/)
- [Tag an image](https://docs.docker.com/engine/reference/commandline/tag/)
- [Push an image to a registry](https://docs.docker.com/engine/reference/commandline/push/)
- [Sign an image in a registry](https://docs.docker.com/datacenter/dtr/2.4/guides/user/manage-images/sign-images/)
- [Pull an image from a registry](https://docs.docker.com/engine/reference/commandline/pull/)
- [Describe how image deletion works](https://docs.docker.com/engine/reference/commandline/rmi/)
- [Delete an image from a registry](https://docs.docker.com/datacenter/dtr/2.0/repos-and-images/delete-an-image/)

### Domain 3: Installation and Configuration (15% of exam)
- [Demonstrate the ability to upgrade the Docker engine](https://askubuntu.com/questions/472412/how-do-i-upgrade-docker)
- [Complete setup of repo, select a storage driver, and complete installation of Docker
engine on multiple platforms](https://docs.docker.com/install/#server)
- [Configure logging drivers (splunk, journald, etc)](https://docs.docker.com/engine/admin/logging/overview/)
- [Setup swarm, configure managers, add nodes, and setup backup schedule](https://docs.docker.com/engine/swarm/admin_guide/)
- [Create and manager user and teams](https://docs.docker.com/datacenter/dtr/2.4/guides/admin/manage-users/create-and-manage-teams/)
- [Interpret errors to troubleshoot installation issues without assistance](https://docs.docker.com/config/daemon/)
- [Outline the sizing requirements prior to installation](https://docs.docker.com/datacenter/ucp/2.2/guides/admin/install/system-requirements/#hardware-and-software-requirements)
- [Understand namespaces, cgroups, and configuration of certificates](https://docs.docker.com/engine/docker-overview/#namespaces)
- [Use certificate-based client-server authentication to ensure a Docker daemon has the
rights to access images on a registry](https://docs.docker.com/engine/security/certificates/)
- Consistently repeat steps to deploy Docker engine, UCP, and DTR on AWS and on
premises in an HA config [1,](https://docs.docker.com/datacenter/dtr/2.3/guides/admin/install/) [2,](https://docs.docker.com/ee/ucp/) [3](https://docs.docker.com/docker-for-aws/)
- [Complete configuration of backups for UCP and DTR](https://docs.docker.com/datacenter/ucp/2.2/guides/admin/backups-and-disaster-recovery/)
- [Configure the Docker daemon to start on boot](https://docs.docker.com/engine/installation/linux/linux-postinstall//)

### Domain 4: Networking (15% of exam)
- [Create a Docker bridge network for a developer to use for their containers](https://docs.docker.com/network/bridge/)
- [Troubleshoot container and engine logs to understand a connectivity issue between
containers](https://docs.docker.com/docker-for-windows/troubleshoot/)
- [Publish a port so that an application is accessible externally](https://github.com/wsargent/docker-cheat-sheet#exposing-ports)
- [Identify which IP and port a container is externally accessible on](https://docs.docker.com/engine/reference/commandline/port/#examples)
- [Describe the different types and use cases for the built-in network drivers](https://blog.docker.com/2016/12/understanding-docker-networking-drivers-use-cases/)
- [Understand the Container Network Model and how it interfaces with the Docker engine
and network and IPAM drivers](https://success.docker.com/article/networking/)
- [Configure Docker to use external DNS](https://gist.github.com/Evalle/7b21e0357c137875a03480428a7d6bf6)
- [Use Docker to load balance HTTP/HTTPs traffic to an application (Configure L7 load
balancing with Docker EE)](https://docs.docker.com/datacenter/ucp/2.2/guides/admin/configure/use-a-load-balancer/#configuration-examples)
- [Understand and describe the types of traffic that flow between the Docker engine,
registry, and UCP controllers](https://success.docker.com/article/networking/)
- [Deploy a service on a Docker overlay network](https://docs.docker.com/network/overlay/)
- Describe the difference between "host" and "ingress" port publishing mode ([Host](https://docs.docker.com/engine/swarm/services/#publish-a-services-ports-directly-on-the-swarm-node), [Ingress](https://docs.docker.com/engine/swarm/ingress/))

### Domain 5: Security (15% of exam)
- [Describe the process of signing an image](https://docs.docker.com/engine/security/trust/content_trust/#push-trusted-content)
- [Demonstrate that an image passes a security scan](https://docs.docker.com/docker-cloud/builds/image-scan/)
- [Enable Docker Content Trust](https://docs.docker.com/engine/security/trust/content_trust/)
- [Configure RBAC in UCP](https://docs.docker.com/datacenter/ucp/2.2/guides/access-control/)
- [Integrate UCP with LDAP/AD](https://docs.docker.com/datacenter/ucp/2.2/guides/admin/configure/external-auth/)
- [Demonstrate creation of UCP client bundles](https://blog.docker.com/2017/09/get-familiar-docker-enterprise-edition-client-bundles/)
- [Describe default engine security](https://docs.docker.com/engine/security/security/)
- [Describe swarm default security](https://docs.docker.com/engine/swarm/how-swarm-mode-works/pki/)
- [Describe MTLS](https://diogomonica.com/2017/01/11/hitless-tls-certificate-rotation-in-go/)

### Domain 6: Storage and Volumes (10% of exam)
- [State which graph driver should be used on which OS](https://docs.docker.com/engine/userguide/storagedriver/selectadriver/)
- [Demonstrate how to configure devicemapper](https://docs.docker.com/engine/userguide/storagedriver/device-mapper-driver/)
- [Compare object storage to block storage, and explain which one is preferable when
available](http://rancher.com/block-object-file-storage-containers/)
- [Summarize how an application is composed of layers and where those layers reside on
the filesystem](https://medium.com/@jessgreb01/digging-into-docker-layers-c22f948ed612)
- [Describe how volumes are used with Docker for persistent storage](https://docs.docker.com/engine/admin/volumes/volumes/)
- [Identify the steps you would take to clean up unused images on a filesystem, also on
DTR](https://docs.docker.com/engine/reference/commandline/image_prune/)
- [Demonstrate how storage can be used across cluster nodes](https://docs.docker.com/engine/extend/legacy_plugins/#volume-plugins)
- [Identity roles](https://docs.docker.com/datacenter/ucp/2.2/guides/access-control/permission-levels/#roles)
- [Describe the difference between UCP workers and managers](https://docs.docker.com/datacenter/ucp/2.2/guides/architecture/)
- Describe process to use external certificates with UCP and DTR (**UCP** [from cli](https://success.docker.com/article/how-do-i-provide-an-externally-generated-security-certificate-during-the-ucp-command-line-installation), [from GUI](https://docs.docker.com/ee/ucp/admin/configure/use-your-own-tls-certificates/#configure-ucp-to-use-your-own-tls-certificates-and-keys), [print the public certificates](https://docs.docker.com/reference/ucp/3.0/cli/dump-certs/)), [**DTR**](https://docs.docker.com/ee/dtr/))

## Links

- [Basic info](https://success.docker.com/Certification) about Exam
- Study guide (pdf) can be found [here](https://docker.cdn.prismic.io/docker%2Fa2d454ff-b2eb-4e9f-af0e-533759119eee_dca+study+guide+v1.0.1.pdf)

## Credits

https://github.com/Evalle/DCA/graphs/contributors


