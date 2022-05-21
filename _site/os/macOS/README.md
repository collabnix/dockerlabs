# Curated List of Docker for Mac Tutorials


[Docker for Mac is built with LinuxKit. How to access the LinuxKit VM](https://github.com/ajeetraina/docker101/blob/master/for-mac/linuxkit.md)<br>
[Top 5 Exclusive Features of Docker for Mac That you can't afford to ignore](http://collabnix.com/top-5-exclusive-features-of-docker-for-mac-that-you-cant-afford-to-miss/)<br>
[5 Minutes to Bootstrap Kubernetes Cluster on GKE using Docker for Mac 18.03.0](http://collabnix.com/bootstrapping-kubernetes-cluster-using-docker-for-mac-18-03-0-ce-edition/)<br>
[Context Switching Made Easy under Kubernetes powered Docker for Mac 18.02.0](http://collabnix.com/namespace-context-toggling-made-easy-under-docker-for-mac-18-02-release/)<br>
[2-minutes to Kubernetes Cluster on Docker for Mac 18.01 using Swarm CLI](http://collabnix.com/running-kubernetes-cluster-on-docker-for-mac-18-01-using-swarm-cli/)<br>
[Docker For Mac 1.13.0 brings support for macOS Sierra, now runs ARM & AARCH64 based Docker containers](http://collabnix.com/running-docker-engine-1-13-0-on-apple-mac-os-x-sierra/)<br>
[Docker for Mac 18.03.0 now comes with NFS Volume Sharing Support for Kubernetes](https://github.com/ajeetraina/docker101/blob/master/for-mac/nfs/README.md)<br>

# Docker for Mac Tips & Tricks

## #1: How to change hostname of Swarm Node under Docker for Mac?

```
docker run -it --privileged --pid=host justincormack/nsenter1 /bin/sh -c "hostname foobar"
```

```

DOCKER_ORCHESTRATOR=swarm docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
oumrrgu03r2r8ml7zlec5kozb *   foobar              Ready               Active              Leader              18.05.0-ce-rc1
```

## #2: How to fix "docker node ls is not supported" error?

```
[Captains-Bay]🚩 >  docker node ls
docker node ls is only supported on a Docker cli with swarm features enabled
```
```
[Captains-Bay]🚩 DOCKER_ORCHESTRATOR=swarm docker node ls
ID                            HOSTNAME                STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
oumrrgu03r2r8ml7zlec5kozb *   linuxkit-025000000001   Ready               Active              Leader              18.05.0-ce-rc1
```

## #3: If Docker for Mac is built with LinuxKit. How shall I verify that the service container is running inside Linuxkit VM?


You can enter into LinuxKit VM with the below command:

```
screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty

```


```
ctr -n services.linuxkit tasks ls
TASK                    PID     STATUS
acpid                   854     RUNNING
diagnose                898     RUNNING
docker-ce               936     RUNNING
host-timesync-daemon    984     RUNNING
ntpd                    1025    RUNNING
trim-after-delete       1106    RUNNING
vpnkit-forwarder        1157    RUNNING
vsudd                   1198    RUNNING
```

## #4:  How to use `docker-clean` utility?

```

$brew install docker-clean
```

```
[Captains-Bay]🚩 >  docker-clean
No images to delete!
No dangling volumes!
Removing empty networks..
```

## #5: I dont see Kubernetes Option listed under Preference Pane. What shall I do?

For those folks experiencing difficulty with Kubernetes, or for issues where Kubernetes is not showing up as an icon in the Docker menu/or Docker dialogue box, I'm providing information on how to install/set-up Kubernetes on your Mac operating system.

1). Kubernetes is only available in Docker-for-Mac 17.12 CE and higher, ONLY on the edge channel.

2). Docker-for-Mac 17.12 CE and higher, Edge includes a standalone Kubernetes server that runs on Mac, so that you can test deploy your workloads on Kubernetes. The client command, kubectl is included in your package and configured to connect to your Kubernetes server. What most folks fail to do after installation is to check to verify that kubectl is installed and pointing to Docker-for desktop. Sometimes, due to configurations, or due to mishaps, kubectl ends up pointing to the wrong environment, which could cause a whole host of issues. If kubectl is pointing toward another environment you have to change context to get it pointing to the correct environment. If you install kubectl with homebrew or some other method other than Docker-for-Mac, and you are experiencing difficulties, remove /usr/local/bin//kubectl. To enable Kubernetes, click on enable Kubernetes, and click the apply and restart button.

3). For those of you not seeing a Kubernetes icon after installation, you can still install Kubernetes as a standalone, if need be, for developmental purposes only. Install NodeJS & Docker Runtime for Mac.
4). Install Homebrew.
5). Install Xyve Driver (or Hyperkit Driver).
6). Install Minikube.
7). Install Kubectl.
8). Start Minikube.
9). Access Kubernetes Dashboard.
10). Minikube Commands for Kubernetes.

## #7: How shall I run Docker Diagnostic using CLI?


```
/Applications/Docker.app/Contents/Resources/bin/docker-diagn
macOS: version 10.13.3 (build: 17D47)
Docker.app: version: 18.05.0-ce-rc1-mac63 (7e2bb492d35dc35ec0037d8024b7e7be57fc72a9)
Local time: Sat May 12 10:54:45 IST 2018
UTC:        Sat May 12 05:24:46 UTC 2018
Timestamp:  20180512-105445
Running diagnostic tests:
[OK]      Files
[OK]      Docker CLI
[OK]      /Users/ajeetraina/Library/Containers/com.docker.docker/Data/vms/0/console-ring exists
[OK]      driver.amd64-linux
[OK]      vmnetd
[OK]      osxfs
[OK]      VPNKit
[OK]      Disk
```

## #8: Docker is not VM. Why we are trying to run it?

Correct, containers are not VM’s, and containers share the same kernel (and resources).

However, Docker for Mac enables you to run Linux containers on a macOS machine; for that, it needs a Linux kernel to run those containers, and a very minimal VM (based on LinuxKit) is used.

## #9: What is LinuxKit VM in terms of D4M?

It is a lightweight virtual machine, which stores the entire state of any number of operating systems and user land applications in a single file. That file is called Docker.raw which is a sparse file on newer macOS SSDs.

## #10: What is the disk image?

The containers and images are stored in a disk image named Docker.raw or Docker.qcow2 depending on your settings (see below). By default, the disk image is stored in ~/Library/Containers/com.docker.docker/Data/vms/0.

```
[Captains-Bay]🚩 >  pwd
/Users/ajeetraina/Library/Containers/com.docker.docker/Data/vms/0
[Captains-Bay]🚩 >  ls
00000002.000005f4	config.iso		hyperkit.json
00000002.00001000	connect			hyperkit.pid
00000003.000005f5	console-ring		log
00000003.00000948	guest.000005f5		nic1.uuid
Docker.qcow2		guest.00000948		tty
[Captains-Bay]🚩 >
```

## #11: What format does Docker uses? - Qcow2 or Raw?

Starting with High Sierra with Apple Filesystem (APFS) enabled, Docker uses disk images in the “raw” format (Docker.raw), otherwise in the Qcow2 format (Docker.qcow2). As shown above, I have qcow2 format by default in MacOS.

## #12: Docker.raw consumes an insane amount of disk space!


This is an illusion. Docker uses the raw format on Macs running the Apple Filesystem (APFS). APFS supports sparse files, which compress long runs of zeroes representing unused space. The output of ls is misleading, because it lists the logical size of the file rather than its physical size. To see the physical size, add the -ks switch; to see the logical size in human readable form, add -lh:

```
$ cd ~/Library/Containers/com.docker.docker/Data/vms/0
$ ls -klsh Docker.raw
2333548 -rw-r--r--@ 1 akim  staff    64G Dec 13 17:42 Docker.raw
In this listing, the logical size is 64GB, but the physical size is only 2.3GB.
```

Alternatively, you may use du (disk usage):

```
$ du -h Docker.raw
2,2G	Docker.raw
```

## #13: How do I reduce the size of Docker.qcow2?

If your Docker for Mac uses the Qcow format, the disk image file is Docker.qcow2. This file grows on-demand up to a default maximum file size of 64GiB.

In Docker 1.12 the only way to free space on the host is to delete this file and restart the app. Unfortunately this removes all images and containers.

In Docker 1.13 there is preliminary support for “TRIM” to non-destructively free space on the host. First free space within the Docker.qcow2 by removing unneeded containers and images with the following commands:

docker ps -a: list all containers
docker image ls: list all images
docker system prune: (new in 1.13): deletes all stopped containers, all volumes not used by at least one container, and all images without at least one referring container.
Note the Docker.qcow2 does not shrink in size immediately. In 1.13 a background cron job runs fstrim every 15 minutes. If the space needs to be reclaimed sooner, run this command:

$ docker run --rm -it --privileged --pid=host walkerlee/nsenter -t 1 -m -u -i -n fstrim /var
Once the fstrim has completed, restart the app. When the app shuts down, it compacts the file and free up space. The app takes longer than usual to restart because it must wait for the compaction to complete.

## #14:What is HyperKit?

HyperKit is a hypervisor built on top of the Hypervisor.framework in macOS. It runs entirely in userspace and has no other dependencies.

We use HyperKit to eliminate the need for other VM products, such as Oracle Virtualbox or VMWare Fusion.

## #15: What is the benefit of HyperKit?

It is thinner than VirtualBox and VMWare fusion, and the version we include is tailor made for Docker workloads on the Mac.

## #16: Why is com.docker.vmnetd running after I quit the app?

The privileged helper process com.docker.vmnetd is started by launchd and runs in the background. The process does not consume any resources unless Docker.app connects to it, so it’s safe to ignore.

## #17: Q: How do I get the Stable or Edge version of Docker for Mac?

Use the download links for the channels given in the topic Download Docker for Mac.



## #18: What is the difference between the Stable and Edge versions of Docker for Mac?

Two different download channels are available for Docker for Mac:

The Stable channel provides a general availability release-ready installer for a fully baked and tested, more reliable app. The Stable version of Docker for Mac comes with the latest released version of Docker Engine. The release schedule is synched with Docker Engine releases and hotfixes. On the Stable channel, you can select whether to send usage statistics and other data.

The Edge channel provides an installer with new features we are working on, but is not necessarily fully tested. It comes with the experimental version of Docker Engine. Bugs, crashes, and issues are more likely to occur with the Edge app, but you get a chance to preview new functionality, experiment, and provide feedback as the apps evolve. Releases are typically more frequent than for Stable, often one or more per month. Usage statistics and crash reports are sent by default. You do not have the option to disable this on the Edge channel.

## #19: What is difference between Docker running on LInux Vs Mac/Windows?

On Linux systems, Docker directly leverages the kernel of the host system, and file system mounts are native.
On Windows and Mac, it’s slightly different. These operating systems do not provide a Linux Kernel, so Docker starts a virtual machine with a small Linux installed and runs Docker containers in there. File system mounts are also not possible natively and need a helper-system in between, which both Docker and Cachalot provide.

## #20: How to Tune with consistent, cached, and delegated configurations

Fortunately, in many cases where the performance degradation is most severe, perfect consistency between container and host is unnecessary. In particular, in many cases there is no need for writes performed in a container to be immediately reflected on the host. For example, while interactive development requires that writes to a bind-mounted directory on the host immediately generate file system events within a container, there is no need for writes to build artifacts within the container to be immediately reflected on the host file system. Distinguishing between these two cases makes it possible to significantly improve performance.

There are three broad scenarios to consider, based on which you can dial in the level of consistency you need. In each case, the container has an internally-consistent view of bind-mounted directories, but in two cases temporary discrepancies are allowed between container and host.

## consistent: perfect consistency (host and container have an identical view of the mount at all times)

## cached: the host’s view is authoritative (permit delays before updates on the host appear in the container)

## delegated: the container’s view is authoritative (permit delays before updates on the container appear in the host)

## Examples:

Each of these configurations (consistent, cached, delegated) can be specified as a suffix to the -v option of docker run. 
For example, to bind-mount /Users/yallop/project in a container under the path /project, you might run the following command:

```
docker run -v /Users/yallop/project:/project:cached alpine command
```
The caching configuration can be varied independently for each bind mount, so you can mount each directory in a different mode:

```
docker run -v /Users/yallop/project:/project:cached \
 -v /host/another-path:/mount/another-point:consistent
 alpine command
```

Semantics

The semantics of each configuration is described as a set of guarantees relating to the observable effects of file system operations. In this specification, “host” refers to the file system of the user’s Docker client.

## delegated

The delegated configuration provides the weakest set of guarantees. For directories mounted with delegated the container’s view of the file system is authoritative, and writes performed by containers may not be immediately reflected on the host file system. In situations such as NFS asynchronous mode, if a running container with a delegated bind mount crashes, then writes may be lost.

However, by relinquishing consistency, delegated mounts offer significantly better performance than the other configurations. Where the data written is ephemeral or readily reproducible, such as from scratch space or build artifacts, delegated may be the right choice.

A delegated mount offers the following guarantees, which are presented as constraints on the container run-time:

If the implementation offers file system events, the container state as it relates to a specific event must reflect the host file system state at the time the event was generated if no container modifications pertain to related file system state.

If flush or sync operations are performed, relevant data must be written back to the host file system.Between flush or sync operations containers may cache data written, metadata modifications, and directory structure changes.

All containers hosted by the same runtime must share a consistent cache of the mount.

When any container sharing a delegated mount terminates, changes to the mount must be written back to the host file system. If this writeback fails, the container’s execution must fail via exit code and/or Docker event channels.

If a delegated mount is shared with a cached or a consistent mount, those portions that overlap must obey cached or consistent mount semantics, respectively.

Besides these constraints, the delegated configuration offers the container runtime a degree of flexibility:

Containers may retain file data and metadata (including directory structure, existence of nodes, etc) indefinitely and this cache may desynchronize from the file system state of the host. Implementors should expire caches when host file system changes occur, but this may be difficult to do on a guaranteed timeframe due to platform limitations.

If changes to the mount source directory are present on the host file system, those changes may be lost when the delegated mount synchronizes with the host source directory.

Behaviors 6-7 do not apply to the file types of socket, pipe, or device.

## cached

The cached configuration provides all the guarantees of the delegated configuration, and some additional guarantees around the visibility of writes performed by containers. As such, cached typically improves the performance of read-heavy workloads, at the cost of some temporary inconsistency between the host and the container.

For directories mounted with cached, the host’s view of the file system is authoritative; writes performed by containers are immediately visible to the host, but there may be a delay before writes performed on the host are visible within containers.

Tip: To learn more about cached, see the article on User-guided caching in Docker for Mac.
Implementations must obey delegated Semantics 1-5.

If the implementation offers file system events, the container state as it relates to a specific event must reflect the host file system state at the time the event was generated.

Container mounts must perform metadata modifications, directory structure changes, and data writes consistently with the host file system, and must not cache data written, metadata modifications, or directory structure changes.

If a cached mount is shared with a consistent mount, those portions that overlap must obey consistent mount semantics.

Some of the flexibility of the delegated configuration is retained, namely:

Implementations may permit delegated Semantics 6.

## consistent

The consistent configuration places the most severe restrictions on the container run-time. For directories mounted with consistent the container and host views are always synchronized: writes performed within the container are immediately visible on the host, and writes performed on the host are immediately visible within the container.

The consistent configuration most closely reflects the behavior of bind mounts on Linux. However, the overheads of providing strong consistency guarantees make it unsuitable for a few use cases, where performance is a priority and maintaining perfect consistency has low priority.

Implementations must obey cached Semantics 1-4.

Container mounts must reflect metadata modifications, directory structure changes, and data writes on the host file system immediately.

## default

The default configuration is identical to the consistent configuration except for its name. Crucially, this means that cached Semantics 4 and delegated Semantics 5 that require strengthening overlapping directories do not apply to default mounts. This is the default configuration if no state flags are supplied.

## #21: Tell me about Docker Networking under D4M?

Docker for Mac provides several networking features to make it easier to use.

### VPN Passthrough

Docker for Mac’s networking can work when attached to a VPN. To do this, Docker for Mac intercepts traffic from the containers and injects it into Mac as if it originated from the Docker application.

### Port Mapping

When you run a container with the -p argument, for example:

```
$ docker run -p 80:80 -d nginx
```

Docker for Mac makes whatever is running on port 80 in the container (in this case, nginx) available on port 80 of localhost. In this example, the host and container ports are the same. What if you need to specify a different host port? If, for example, you already have something running on port 80 of your host machine, you can connect the container to a different port:

```
$ docker run -p 8000:80 -d nginx
```

Now, connections to localhost:8000 are sent to port 80 in the container. The syntax for -p is HOST_PORT:CLIENT_PORT.

HTTP/HTTPS Proxy Support
See Proxies.

### Known limitations, use cases, and workarounds

Following is a summary of current limitations on the Docker for Mac networking stack, along with some ideas for workarounds.

## There is no docker0 bridge on macOS

Because of the way networking is implemented in Docker for Mac, you cannot see a docker0 interface on the host. This interface is actually within the virtual machine.

## I cannot ping my containers

Docker for Mac can’t route traffic to containers.

## Per-container IP addressing is not possible

The docker (Linux) bridge network is not reachable from the macOS host.

## Use cases and workarounds

There are two scenarios that the above limitations affect:

## I WANT TO CONNECT FROM A CONTAINER TO A SERVICE ON THE HOST

The host has a changing IP address (or none if you have no network access). From 18.03 onwards our recommendation is to connect to the special DNS name host.docker.internal, which resolves to the internal IP address used by the host. This is for development purpose and will not work in a production environment outside of Docker for Mac.

The gateway is also reachable as gateway.docker.internal.

## I WANT TO CONNECT TO A CONTAINER FROM THE MAC

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

## #22:I have Docker for Mac installed running K8s 1.9.6. Can I install Kubectl 1.10 version? 

```
Error: kubernetes-cli 1.9.2 is already installed
To upgrade to 1.10.2, run `brew upgrade kubernetes-cli`
[Captains-Bay]🚩 >  brew upgrade kubernetes-cli
==> Upgrading 1 outdated package, with result:
kubernetes-cli 1.9.2 -> 1.10.2
==> Upgrading kubernetes-cli
==> Downloading https://homebrew.bintray.com/bottles/kubernetes-cli-1.10.2.high_sierra.bottle.tar.gz
######################################################################## 100.0%
==> Pouring kubernetes-cli-1.10.2.high_sierra.bottle.tar.gz
Error: The `brew link` step did not complete successfully
The formula built, but is not symlinked into /usr/local
Could not symlink bin/kubectl
Target /usr/local/bin/kubectl
already exists. You may want to remove it:
  rm '/usr/local/bin/kubectl'

To force the link and overwrite all conflicting files:
  brew link --overwrite kubernetes-cli

To list all files that would be deleted:
  brew link --overwrite --dry-run kubernetes-cli

Possible conflicting files are:
/usr/local/bin/kubectl -> /Applications/Docker.app/Contents/Resources/bin/kubectl
==> Caveats
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

zsh completions have been installed to:
  /usr/local/share/zsh/site-functions
==> Summary
🍺  /usr/local/Cellar/kubernetes-cli/1.10.2: 178 files, 52.8MB
```


