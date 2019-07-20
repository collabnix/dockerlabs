---
layout: default
title: Beginners Track - What happens when Containers are Launched?
description: collabnix | DockerLab | Docker - Beginners Track
---

## What happens when Containers are Launched?

Here is basically what happens when a container is launched:

1. A container is created from a container image. Images are tarballs with a JSON configuration file attached. Images are often nested: for example this Libresonic image is built on top of a Tomcat image that depends (eventually) on a base Debian image. This allows for content deduplication because that Debian image (or any intermediate step) may be the basis for other containers. A container image is typically created with a command like docker build.

2. If necessary, the runtime downloads the image from somewhere, usually some "container registry" that exposes the metadata and the files for download over a simple HTTP-based protocol. It used to be only Docker Hub, but now everyone has their own registry: for example, Red Hat has one for its OpenShift project, Microsoft has one for Azure, and GitLab has one for its continuous integration platform. A registry is the server that docker pull or push talks with, for example.

3. The runtime extracts that layered image onto a copy-on-write (CoW) filesystem. This is usually done using an overlay filesystem, where all the container layers overlay each other to create a merged filesystem. This step is not generally directly accessible from the command line but happens behind the scenes when the runtime creates a container.

4. Finally, the runtime actually executes the container, which means telling the kernel to assign resource limits, create isolation layers (for processes, networking, and filesystems), and so on, using a cocktail of mechanisms like control groups (cgroups), namespaces, capabilities, seccomp, AppArmor, SELinux, and whatnot. For Docker, docker run is what creates and runs the container, but underneath it actually calls the runc command.

Those concepts were first elaborated in Docker's Standard Container manifesto which was eventually removed from Docker, but other standardization efforts followed. The Open Container Initiative (OCI) now specifies most of the above under a few specifications:

- the Image Specification (often referred to as "OCI 1.0 images") which defines the content of container images
- the Runtime Specification (often referred to as CRI 1.0 or Container Runtime Interface) describes the "configuration, execution environment, and lifecycle of a container"
- the Container Network Interface (CNI) specifies how to configure network interfaces inside containers, though it was standardized under the Cloud Native Computing Foundation (CNCF) umbrella, not the OCI

Implementation of those standards varies among the different projects. For example, Docker is generally compatible with the standards except for the image format. Docker has its own image format that predates standardization and it has promised to convert to the new specification soon. Implementation of the runtime interface also differs as not everything Docker does is standardized, as we shall see.

# The Docker and rkt story

Since Docker was the first to popularize containers, it seems fair to start there. Originally, Docker used LXC but its isolation layers were incomplete, so Docker wrote libcontainer, which eventually became runc. Container popularity exploded and Docker became the de facto standard to deploy containers. When it came out in 2014, Kubernetes naturally used Docker, as Docker was the only runtime available at the time. But Docker is an ambitious company and kept on developing new features on its own. Docker Compose, for example, reached 1.0 at the same time as Kubernetes and there is some overlap between the two projects. While there are ways to make the two tools interoperate using tools such as Kompose, Docker is often seen as a big project doing too many things. This situation led CoreOS to release a simpler, standalone runtime in the form of rkt, that was explained this way:

Docker now is building tools for launching cloud servers, systems for clustering, and a wide range of functions: building images, running images, uploading, downloading, and eventually even overlay networking, all compiled into one monolithic binary running primarily as root on your server. The standard container manifesto was removed. We should stop talking about Docker containers, and start talking about the Docker Platform. It is not becoming the simple composable building block we had envisioned.

One of the innovations of rkt was to standardize image formats through the appc specification, something we covered back in 2015. CoreOS doesn't yet have a fully standard implementation of the runtime interfaces: at the time of writing, rkt's Kubernetes compatibility layer (rktlet), doesn't pass all of Kubernetes integration tests and is still under development. Indeed, according to Brandon Philips, CTO of CoreOS, in an email exchange:

rkt has initial support for OCI image-spec, but it is incomplete in places. OCI support is less important at the moment as the support for OCI is still emerging in container registries and is notably absent from Kubernetes. OCI runtime-spec is not used, consumed, nor handled by rkt. This is because rkt execution is based on pod semantics, while runtime-spec only covers single container execution.

However, according to Dan Walsh, head of the container team at Red Hat, in an email interview, CoreOS's efforts were vital to the standardization of the container space within the Kubernetes ecosystem: "Without CoreOS we probably would not have CNI, and CRI and would be still fighting about OCI. The CoreOS effort is under-appreciated in the market." Indeed, according to Philips, the "CNI project and specifications originated from rkt, and were later spun off and moved to CNCF. CNI is still widely used by rkt today, both internally and for user-provided configuration." At this point, however, CoreOS seems to be gearing up toward building its Kubernetes platform (Tectonic) and image distribution service (Quay) rather than competing in the runtime layer.

# CRI-O: the minimal runtime

Seeing those new standards, some Red Hat folks figured they could make a simpler runtime that would only do what Kubernetes needed. That "skunkworks" project was eventually called CRI-O and implements a minimal CRI interface. During a talk at KubeCon Austin 2017, Walsh explained that "CRI-O is designed to be simpler than other solutions, following the Unix philosophy of doing one thing and doing it well, with reusable components."

Started in late 2016 by Red Hat for its OpenShift platform, the project also benefits from support by Intel and SUSE, according to Mrunal Patel, lead CRI-O developer at Red Hat who hosted the talk. CRI-O is compatible with the CRI (runtime) specification and the OCI and Docker image formats. It can also verify image GPG signatures. It uses the CNI package for networking and supports CNI plugins, which OpenShift uses for its software-defined networking layer. It supports multiple CoW filesystems, like the commonly used overlay and aufs, but also the less common Btrfs.

One of CRI-O's most notable features, however is that it supports mixed workloads between "trusted" and "untrusted" containers. For example, CRI-O can use Clear Containers for stronger isolation promises, which is useful in multi-tenant configurations or to run untrusted code. It is currently unclear how that functionality will trickle up into Kubernetes, which currently considers all backends to be the same.

CRI-O has an interesting architecture (see the diagram below from the talk slides [PDF]). It reuses basic components like runc to start containers, and software libraries like containers/image and containers/storage, created for the skopeo project, to pull container images and create container filesystems. A separate library called oci-runtime-tool prepares the container configuration. CRI-O introduces a new daemon to handle containers called conmon. According to Patel, the program was "written in C for stability and performance" and takes care of monitoring, logging, TTY allocation, and miscellaneous hazards like out-of-memory conditions.

##  CRI-O architecture

The conmon daemon is needed here to do all of the things that systemd doesn't (want to) do. But even though CRI-O doesn't use systemd directly to manage containers, it assigns containers to systemd-compatible cgroups, so that regular systemd tools like systemctl have visibility into the container resources. Since conmon (and not the CRI daemon) is the parent process of the container, it also allows parts of CRI-O to be restarted without stopping containers, which promises smoother upgrades. This is a problem for Docker deployments right now, where a Docker upgrade requires restarting all of the containers. This is usually not much trouble for Kubernetes clusters, however, because it is easy to roll out upgrades progressively by moving containers around.

CRI-O is the first implementation of the OCI standards suite that passes all Kubernetes integration tests (apart from Docker itself). Patel demonstrated those capabilities by showing a Kubernetes cluster backed by CRI-O, in what seemed to be a routine demonstration of cluster functionalities. Dan Walsh explained CRI-O's approach in a blog post that explains how CRI-O interacts with Kubernetes:

Our number 1 goal for CRI-O, unlike other container runtimes, is to never break Kubernetes. Providing a stable and rock-solid container runtime for Kubernetes is CRI-O's only mission in life.

According to Patel, performance is comparable to a normal Docker-based deployment, but the team is working on optimizing performance to go beyond that. Debian and RPM packages are available and deployment tools like minikube, or kubeadm also support switching to the CRI-O runtime. On existing clusters, switching runtimes is straightforward: just a single environment variable changes the runtime socket, which is what Kubernetes uses to communicate with the runtime.

CRI-O 1.0 was released in October 2017 with support for Kubernetes 1.7. Since then, CRI-O 1.8 and 1.9 were released to follow the Kubernetes 1.8 and 1.9 releases (and sync version numbers). Patel considers CRI-O to be production-ready and it is already available in beta in OpenShift 3.7, released in November 2017. Red Hat will mark it as stable in the upcoming OpenShift 3.9 release and is looking at using it by default with OpenShift 3.10, while keeping Docker as a fallback. Next steps include integrating the new Kata Containers virtual-machine-based runtime, kube-spawn support, and more storage backends like NFS or GlusterFS. The team also discussed how it could support casync or libtorrent to optimize synchronization of images between nodes.

containerd: Docker's runtime gets an API
While Red Hat was working on its implementation of OCI, Docker was also working on the standard, which led to the creation of another runtime, called containerd. The new daemon is a refactoring of internal Docker components to combine the OCI-specific bits like execution, storage, and network interface management. It was already featured in the 1.12 Docker release, but wasn't completed until the containerd 1.0 release announced at KubeCon, which will be part of the upcoming Docker 17.12 (Docker has moved to version numbers based on year and month). And while we call containerd a "runtime", it doesn't directly implement the CRI interface, which is covered by another daemon called cri-containerd. So containerd needs more daemons than CRI-O for Kubernetes (five, versus three for CRI-O). Also, at the time of writing, the cri-containerd component is marked as beta but containerd itself is already used in numerous production environments through Docker, of course.

During the Node special interest group (SIG) meeting at KubeCon, Stephen Day described [Speaker Deck] containerd as "designed as a tight core of decoupled components". Unlike CRI-O, however, containerd supports workloads outside the Kubernetes ecosystem through a Go API. The API is not considered stable yet, although containerd defines a clear release process for making changes to the API and command-line tools. Like CRI-O, containerd is feature complete and passes all Kubernetes tests, but it does not interoperate with systemd's cgroups.

Next step for the project is to develop more tests and improve performance like memory usage and latency. Containerd developers are also working hard on improving stability. They want to provide Debian and RPM packages for easier installation, and integrate it with minikube and kops as well. There are also plans to integrate Kata Containers more smoothly: runc can already be replaced by Kata for basic integration but cri-containerd integration is not implemented yet.

Interoperability and defaults
All of those options are causing a certain amount of confusion in the community. At KubeCon, which runtime to use was a recurring question to speakers. Kubernetes will likely change from Docker to a different runtime, because it doesn't need all the features Docker provides, and there are concerns that the switch could cause compatibility issues because the new runtimes do not implement exactly the same interface as Docker. Log files, for example, are different in the CRI standard. Some programs also monitor the Docker socket directly, which has some non-standard behaviors that the new runtimes may implement differently, or not at all. All of this could cause some breakage when switching to a different runtime.

The question of which runtime Kubernetes will switch to (if it changes) is also open, which leads to some competition between the runtimes. There was a slight controversy related to that question at KubeCon because CRI-O wasn't mentioned during the CNCF keynote, something Vincent Batts, a senior engineer at Red Hat, mentioned on Twitter:

It is bonkers that CRI implementations containerd and rktlet are covered in KubeCon keynote, but zero mention of CRI-O, which is a Kubernetes project that's been 1.0 and actually used in production.

When I prompted him for details about this at KubeCon, Batts explained that:

Healthy competition is good, the problem is unhealthy competition. The CNCF should be better stewards of the projects under their umbrella and shouldn't fold under pressure to promote certain projects over others.

Batts explained further that Red Hat "may be at a tipping point where some apps could start being deployed as containers instead of RPMs" citing "security concerns (namely with [security] advisory tracking, which is lacking in containers as a packaging format) as the main blocker for such transitions". With Project Atomic, Red Hat seems to be pivoting toward containers, so the stakes are high for the Linux distribution.

When I talked to CNCF's COO Chris Aniszczyk at KubeCon, he explained that the CNCF "current policy is to prioritize the marketing of top-level projects":

Projects like CRIO and Helm are part of Kubernetes in some fashion and therefore part of CNCF, we just don't market them as heavily as our top level projects which have passed the CNCF TOC [Technical Oversight Committee] approval bar.

Aniszczyk added that "we want to help, we've heard the feedback and plan to address things in 2018", suggesting that one solution could be that CRI-O applies to graduate to a top-level project in CNCF.

During a container runtimes press meeting, Philips explained that the community would decide, through consensus, which runtime Kubernetes would run by default. He compared runtimes to web browsers and suggested that OCI specifications for containers be compared to the HTML5 and Javascript standards: those are evolving standards that get pushed by the different implementations. He argued that this competition is healthy and means more innovation.

A lot of the people involved in writing those new runtimes were originally Docker contributors: Patel was the initial maintainer of the original OCI implementation that led to runc, while Philips was also a core Docker contributor before starting the rkt project. Those people actively collaborate, along with Docker developers, on standardizing those interfaces and all want to see Kubernetes stabilize and improve. The goal, according to Patrick Chazenon from Docker Inc., is to "make container runtimes boring and stable to have people innovate on top of it". The developers present at the press meeting were happy and proud of what they have accomplished: they have managed to create a single, interoperable specification for containers, and that specification is expanding.

Consolidation and standardization will continue in 2018
The current big topic in container standardization is not runtimes as much as image distribution (i.e. container registries), which is likely to standardize, again, in a specification built around Docker's distribution system. There is also work needed to follow the Linux kernel changes, for example cgroups v2.

The reality is that each runtime has its own advantages: containerd has an API so it can be used to build customized platforms, while CRI-O is a simpler runtime specifically targeting Kubernetes. Docker and rkt are on another level, providing more than simply the runtime: they also provide ways of building containers or pushing to registries, for example.

Right now, most public cloud infrastructure still uses Docker as a runtime. In fact, even CoreOS uses Docker instead of rkt in its Tectonic platform. According to Philips, this is because "there is a substantial integration ecosystem around Docker Engine that our customers rely on and it is the most well-tested option across all existing Kubernetes products." Philips says that CoreOS may consider supporting alternate runtimes for Tectonic, "if alternative container runtimes provide significant improvements to Kubernetes users":

At this point containerd and CRI-O are both very young projects due to the significant amount of new code each project developed this year. Further, they need to reach the maturity of third-party integrations across the ecosystem from logging, monitoring, security, and much more.

Philips further explained CoreOS's position in this blog post:

So far the primary benefits of the CRI for the Kubernetes community have been better code organization and improved code coverage in the Kubelet itself, resulting in a code base that's both higher quality and more thoroughly tested than ever before. For nearly all deployments, however, we expect the Kubernetes community will continue to use Docker Engine in the near term.

During the discussion in the press meeting, Patel likewise said that "we don't want Kubernetes users to know what the runtime is". Indeed, as long as it works, users shouldn't care. Besides, OpenShift, Tectonic, and other platforms abstract runtime decisions away and pick their own best default matching their users' requirements. The question of which runtime Kubernetes chooses by default is therefore not really a concern for those developers, who prefer working on building consensus on standard specifications. In a world of conflict, seeing those developers working together cordially was definitely a breath of fresh air.

Reference: https://lwn.net/Articles/741897/
