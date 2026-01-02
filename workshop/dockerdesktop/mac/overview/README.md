

<img width="1053" alt="image" src="https://user-images.githubusercontent.com/313480/212112707-aff57b4c-8cb5-4243-b9ba-90ea9a1c5004.png">






<img width="1004" alt="image" src="https://user-images.githubusercontent.com/313480/212114070-f87bd920-db9d-4174-b045-49368f5bb0bd.png">


At the base of architecture, we have hypervisor called Hyperkit which is derived from xhyve. The xhyve hypervisor is a port of bhyve to OS X. It is built on top of Hypervisor.framework in OS X 10.10 Yosemite and higher, runs entirely in userspace, and has no other dependencies. HyperKit is basically a toolkit for embedding hypervisor capabilities in your application. It includes a complete hypervisor optimized for lightweight virtual machines and container deployment. It is designed to be interfaced with higher-level components such as the VPNKit and DataKit.

Just sitting next to HyperKit is Filesystem sharing solution. The osxfs is a new shared file system solution, exclusive to Docker for Mac. osxfs provides a close-to-native user experience for bind mounting macOS file system trees into Docker containers. To this end, osxfs features a number of unique capabilities as well as differences from a classical Linux file system.On macOS Sierra and lower, the default file system is HFS+. On macOS High Sierra, the default file system is APFS.With the recent release, NFS Volume sharing has been enabled both for Swarm & Kubernetes.

There is one more important component sitting next to Hyperkit, rightly called as VPNKit. VPNKit is a part of HyperKit attempts to work nicely with VPN software by intercepting the VM traffic at the Ethernet level, parsing and understanding protocols like NTP, DNS, UDP, TCP and doing the “right thing” with respect to the host’s VPN configuration. VPNKit operates by reconstructing Ethernet traffic from the VM and translating it into the relevant socket API calls on OSX. This allows the host application to generate traffic without requiring low-level Ethernet bridging support.

On top of these open source components, we have LinuxKit VM which runs containerd and service containers which includes Docker Engine to run service containers. LinuxKit VM is built based on YAML file. The docker-for-mac.yml contains an example use of the open source components of Docker for Mac. The example has support for controlling dockerd from the host via vsudd and port forwarding with VPNKit. It requires HyperKit, VPNKit and a Docker client on the host to run.

https://gist.github.com/ajeetraina/ac983ea54d407ab82ba1f4d542d9c1b2

Sitting next to Docker service containers, we have kubelet binaries running inside LinuxKit VM. If you are new to K8s, kubelet is an agent that runs on each node in the cluster. It makes sure that containers are running in a pod. It basically takes a set of PodSpecs that are provided through various mechanisms and ensures that the containers described in those PodSpecs are running and healthy. The kubelet doesn’t manage containers which were not created by Kubernetes.On top of Kubelet, we have kubernetes services running. We can either run Swarm Cluster or Kubernetes Cluster. We can use the same Compose YAML file to bring up both the clusters side by side.


<img width="1052" alt="image" src="https://user-images.githubusercontent.com/313480/212114444-61cbc034-a161-41df-97b7-44d8dd211e1d.png">




