## When will K8s be appearing in Stable Release?

Still the dates has not been announced

## Is Docker for Mac replacement for Minikube?

With Docker for Mac, we talk about Developers and not Kubernetes developers. Kubernetes is just one part of Docker for Mac.
We can use Minikube too under Docker for Mac.

## When is Docker for Linux coming?

No Tentative dates

## Can we run Multiple Kubernetes Cluster using Docker for Mac?

It should be technically possible. But the general ask from the community is having a single-node cluster.

## Does Docker for Mac support NFS VOlume Sharing?

Yes. Check out the Release Notes of the latest 18.03 Release

## I dont see docker0 bridge under MacOS?

There is no docker0 bridge on macOS
Because of the way networking is implemented in Docker for Mac, you cannot see a docker0 interface on the host. This interface is actually within the virtual machine.

## I cannot ping my containers from Docker Host

Docker for Mac can’t route traffic to containers.  Per-container IP addressing is not possible
The docker (Linux) bridge network is not reachable from the macOS host.


There are two scenarios that the above limitations affect:

### I WANT TO CONNECT FROM A CONTAINER TO A SERVICE ON THE HOST

The host has a changing IP address (or none if you have no network access). From 18.03 onwards our recommendation is to connect to the special DNS name host.docker.internal, which resolves to the internal IP address used by the host.

The gateway is also reachable as gateway.docker.internal.

### I WANT TO CONNECT TO A CONTAINER FROM THE MAC

Port forwarding works for localhost; --publish, -p, or -P all work. Ports exposed from Linux are forwarded to the host.

Our current recommendation is to publish a port, or to connect from another container. This is what you need to do even on Linux if the container is on an overlay network, not a bridge network, as these are not routed.

The command to run the nginx webserver shown in Getting Started is an example of this.

```
$ docker run -d -p 80:80 --name webserver nginx
```

To clarify the syntax, the following two commands both expose port 80 on the container to port 8000 on the host:

```
$ docker run --publish 8000:80 --name webserver nginx
```
```
$ docker run -p 8000:80 --name webserver nginx
```

To expose all ports, use the -P flag. For example, the following command starts a container (in detached mode) and the -P exposes all ports on the container to random ports on the host.

```
$ docker run -d -P --name webserver nginx
```

See the run command for more details on publish options used with docker run.

