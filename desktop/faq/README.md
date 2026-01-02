# Docker Desktop FAQs

## 1. What is difference between Kubernetes & Docker Desktop built-in Kubernetes Distribution?

Docker Desktop includes Kubernetes, optimized and tuned for a fast, distraction-free developer experience. 
Docker Team track upstream Kubernetes changes and manage Kubernetes upgrades so developers can focus on their code rather than cluster administration

### Benefits:
- Docker Desktop saves developers time and effort by including an optimized distribution of the latest Kubernetes, which can be enabled with a single 
checkbox.
- Developers benefit from a fast “inner-loop” where they can “docker build” an image and then immediately test it from Kubernetes without having to push and then re-pull, all thanks to Docker’s shared image store and cri-dockerd.
- Docker Desktop automatically binds network ports on the host and tunnels traffic to Kubernetes, allowing developers to immediately interact with their applications without remembering internal IP addresses or reconfiguring their DNS.
- Docker Desktop manages all the complexity of running containers and Kubernetes, allowing developers to focus on their code rather than cluster administration. There is no need to worry about local cluster upgrades, choosing CNI plugins or container runtimes. If you’d like to know more about Docker’s built-in Kubernetes then check out the blog post “How Kubernetes works under the hood with Docker Desktop”.
- Managing a custom Kubernetes installation is a complicated task. The advantage of using Docker Desktop over a DIY solution is that the complexity is handled for you. The removal of dockershim from Kubernetes is an example. With a DIY solution you would have to sort out the migration yourself, and then deploy the solution to all your developers’ desktops: with Docker Desktop it’s all done for you. 
So your developers can focus on developing, while Docker Desktop takes care of the admin. 

## 2. As a developer using Docker Desktop, do I need to care which container runtime implementation is used in production?

No, the container “runtime” is an implementation detail of Kubernetes and you don’t need to think about it. There is no need to rebuild any images or containers. Docker pioneered the industry-standard OCI specifications to ensure that containers can run anywhere on any runtime. 

## 3. Docker Desktop has already switched from the old dockershim to the new Docker CRI implementation in version 4.7.0, so the removal of dockershim from Kubernetes does not affect Docker Desktop.

Early versions of Kubernetes created containers directly using the Docker API, through an internal Kubernetes package called “dockershim” (“shim” meaning a small glue layer between Kubernetes internal APIs and the Docker API). Later the Kubernetes project gained the ability to create containers through a new interface called the Container Runtime Interface (CRI) . Until version 1.24, Kubernetes could use the Docker Engine to manage containers in two different ways: one way using the old “dockershim” and a second way using the new Docker CRI implementation from Mirantis (see the post “The future of dockershim is cri-dockerd”). 
To make Kubernetes easier to manage and maintain, the old “dockershim” has been removed, so all container management is now through the new CRI.

## 4. What changes to containerd?


Back in 2016, Docker started working with Google on “containerd”: a container runtime that could be shared by both Docker and Kubernetes. The low-level parts of dockerd were moved to containerd. Today there is a dockerd and containerd side-by-side in every instance of Docker Desktop. Here at Docker we’re committed to improving both dockerd and containerd to bring great new features to developers.

## 5. What if I need to bind-mount the Docker socket in my container in a remote Kubernetes cluster?

Provided the Docker engine is still installed on the Kubernetes worker node, the Docker socket can be bind-mounted as before. It’s not necessary for the remote Kubernetes cluster to use the Docker runtime.

## 6. As a developer using Docker Desktop, do I need to care which container runtime implementation is used in production?

No, the container “runtime” is an implementation detail of Kubernetes and you don’t need to think about it. There is no need to rebuild any images or containers. Docker pioneered the industry-standard OCI specifications to ensure that containers can run anywhere on any runtime. 
