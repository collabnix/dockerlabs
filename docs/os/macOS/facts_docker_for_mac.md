# 8 Facts About Docker for Mac that You Should Know

## Fact-1: You can use Docker for Mac with swarm mode & Kubernetes

Yes, you can use Docker for Mac to test single-node features of swarm mode introduced with Docker Engine 17.12, 
including initializing a swarm with a single node, creating services, and scaling services. Docker “Moby” on Hyperkit serves as the single swarm node. You can also use Docker Machine, which comes with Docker for Mac, to create and experiment a multi-node swarm. Check out the tutorial at Get started with swarm mode.

While testing Kubernetes, you may want to deploy some workloads in swarm mode. Use the DOCKER_ORCHESTRATOR variable to override the default orchestrator for a given terminal session or a single Docker command. This variable can be unset (the default, in which case Kubernetes is the orchestrator) or set to swarm or kubernetes. The following command 
overrides the orchestrator for a single deployment, by setting the variable at the start of the command itself.

## Fact-2: Docker for Mac support Multi-Architecture Support

Docker for Mac provides binfmt_misc multi architecture support, so you can run 
containers for different Linux architectures, such as arm, mips, ppc64le, and even s390x.

## Fact-3: Docker for Mac Support NFS Volume sharing for Swarm as well as Kubernetes


## Fact-4: Docker for Mac VM is entirely built with Linuxkit

## Fact-5: Docker for Mac uses the same Compose file to build Kubernetes Cluster

## Fact-6: Docker for Mac uses raw format VM disks for systems running APFS on SSD on High Sierra by default

## Fact-7: Docker for Mac  - DNS name docker.for.mac.host.internal should be used instead of docker.for.mac.localhost (still valid) for host resolution from containers, since since there is an RFC 
banning the use of subdomains of localhost. See https://tools.ietf.org/html/draft-west-let-localhost-be-localhost-06.

## Fact-8: Docker for Mac support context switching from docker-for-desktop to Cloud instances in a matter of click

