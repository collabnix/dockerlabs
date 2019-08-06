# How to setup 3 Node Docker Enterprise 3.0 Cluster on Bare Metal System

## Pre-Requisite:

- Docker Enterprise 3.0 Manager Node should have minimal of 4.00 GB RAM for Universal Control Plane
- Go to https://hub.docker.com/my-content.
- Each subscription or trial you have access to is listed. Click the Setup button for Docker Enterprise Edition for Ubuntu.
- Copy the URL from the field labeled Copy and paste this URL to download your Edition.


## Install packages to allow apt to use a repository over HTTPS:


```
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
```

## Adding $DOCKER_EE_URL variable into your environment

Replace <DOCKER-EE-URL> with the URL you noted down in the prerequisites.
Replace sub-xxx too.

```
curl -fsSL https://storebits.docker.com/ee/m/sub-XXX-44fb-XXX-b6bf-XXXXXX/ubuntu/gpg | sudo apt-key add -
```

## Adding the stable Repository

```
sudo add-apt-repository \
   "deb [arch=amd64] https://storebits.docker.com/ee/m/sub-XXX-44fb-XXX-b6bf-XXXXXX/ubuntu \
   $(lsb_release -cs) \
   stable-19.03"
```

## Installing Docker Enterprise

```
sudo apt-get install docker-ee docker-ee-cli containerd.io
```

## Verifying Docker Enterprise Version

```
cse@ubuntu1804-1:~$ sudo docker version
Client: Docker Engine - Enterprise
 Version:           19.03.1
 API version:       1.40
 Go version:        go1.12.5
 Git commit:        f660560
 Built:             Thu Jul 25 20:59:23 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Enterprise
 Engine:
  Version:          19.03.1
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.5
  Git commit:       f660560
  Built:            Thu Jul 25 20:57:45 2019
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.6
  GitCommit:        894b81a4b802e4eb2a91d1ce216b8817763c29fb
 runc:
  Version:          1.0.0-rc8
  GitCommit:        425e105d5a03fabd737a126ad93d62a9eeede87f
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
cse@ubuntu1804-1:~$
```

## Testing the Hello World Example

```
cse@ubuntu1804-1:~$ apt-cache madison docker-ee
 docker-ee | 5:19.03.1~3-0~ubuntu-bionic | https://storebits.docker.com/ee/m/sub-1fc9752c-44fb-4d19-b6bf-51856a05b325/ubuntu bionic/stable-19.03 amd64 Packages
 docker-ee | 5:19.03.0~3-0~ubuntu-bionic | https://storebits.docker.com/ee/m/sub-1fc9752c-44fb-4d19-b6bf-51856a05b325/ubuntu bionic/stable-19.03 amd64 Packages
cse@ubuntu1804-1:~$ sudo docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
1b930d010525: Pull complete
Digest: sha256:6540fc08ee6e6b7b63468dc3317e3303aae178cb8a45ed3123180328bcc1d20f
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

cse@ubuntu1804-1:~$
```

## Installing Universal Control Plane

```
docker container run --rm -it --name ucp \
  -v /var/run/docker.sock:/var/run/docker.sock \
  docker/ucp:3.2.0 install \
  --host-address <node-ip-address> \
  --interactive
```

```
@ubuntu1804-1:~$ sudo docker container run --rm -it --name ucp \
>   -v /var/run/docker.sock:/var/run/docker.sock \
>   docker/ucp:3.2.0 install \
>   --host-address 100.98.26.115 \
>   --interactive
Unable to find image 'docker/ucp:3.2.0' locally
3.2.0: Pulling from docker/ucp
050382585609: Pull complete
de0f2e3c5141: Pull complete
ef4440c639ab: Pull complete
Digest: sha256:f9049801c3fca01f1f08772013911bd8f9b616224b9f8d5252d91faec316424a
Status: Downloaded newer image for docker/ucp:3.2.0
INFO[0000] Your Docker daemon version 19.03.1, build f660560 (4.15.0-29-generic) is compatible with UCP 3.2.0 (586d782)
INFO[0000] Initializing New Docker Swarm
Admin Username: ajeetraina
Admin Password:
Confirm Admin Password:
WARN[0014] None of the Subject Alternative Names we'll be using in the UCP certificates ["ubuntu1804-1"] contain a domain component. Your generated certs may fail TLS validation unless you only use one of these shortnames or IP addresses to connect. You can use the --san flag to add more aliases

You may enter additional aliases (SANs) now or press enter to proceed with the above list.
Additional aliases:
INFO[0019] Checking required ports for connectivity
INFO[0035] Checking required container images
INFO[0035] Pulling required images... (this may take a while)
INFO[0035] Pulling image: docker/ucp-agent:3.2.0
INFO[0042] Pulling image: docker/ucp-auth:3.2.0
INFO[0049] Pulling image: docker/ucp-auth-store:3.2.0
INFO[0061] Pulling image: docker/ucp-azure-ip-allocator:3.2.0
INFO[0067] Pulling image: docker/ucp-calico-cni:3.2.0
INFO[0079] Pulling image: docker/ucp-calico-kube-controllers:3.2.0
INFO[0092] Pulling image: docker/ucp-calico-node:3.2.0
INFO[0102] Pulling image: docker/ucp-cfssl:3.2.0
INFO[0113] Pulling image: docker/ucp-compose:3.2.0
5
INFO[0180] Pulling image: docker/ucp-controller:3.2.0
INFO[0197] Pulling image: docker/ucp-dsinfo:3.2.0
INFO[0201] Pulling image: docker/ucp-etcd:3.2.0
INFO[0230] Pulling image: docker/ucp-hyperkube:3.2.0
INFO[0266] Pulling image: docker/ucp-interlock:3.2.0
INFO[0272] Pulling image: docker/ucp-interlock-extension:3.2.0
INFO[0278] Pulling image: docker/ucp-interlock-proxy:3.2.0
INFO[0287] Pulling image: docker/ucp-kube-compose:3.2.0
INFO[0293] Pulling image: docker/ucp-kube-compose-api:3.2.0
INFO[0301] Pulling image: docker/ucp-kube-dns:3.2.0
INFO[0307] Pulling image: docker/ucp-kube-dns-dnsmasq-nanny:3.2.0
INFO[0314] Pulling image: docker/ucp-kube-dns-sidecar:3.2.0
INFO[0321] Pulling image: docker/ucp-metrics:3.2.0
INFO[0343] Pulling image: docker/ucp-pause:3.2.0
INFO[0348] Pulling image: docker/ucp-swarm:3.2.0
INFO[0354] Completed pulling required images
INFO[0357] Running install agent container ...
INFO[0000] Loading install configuration
INFO[0000] Running Installation Steps
INFO[0000] Step 1 of 35: [Setup Internal Cluster CA]
INFO[0003] Step 2 of 35: [Setup Internal Client CA]
INFO[0003] Step 3 of 35: [Initialize etcd Cluster]
INFO[0007] Step 4 of 35: [Set Initial Config in etcd]
INFO[0007] Step 5 of 35: [Deploy RethinkDB Server]
INFO[0010] Step 6 of 35: [Initialize RethinkDB Tables]
INFO[0030] Step 7 of 35: [Create Auth Service Encryption Key Secret]
INFO[0030] Step 8 of 35: [Deploy Auth API Server]
INFO[0039] Step 9 of 35: [Setup Auth Configuration]
INFO[0040] Step 10 of 35: [Deploy Auth Worker Server]
INFO[0046] Step 11 of 35: [Deploy UCP Proxy Server]
INFO[0047] Step 12 of 35: [Initialize Swarm v1 Node Inventory]
INFO[0047] Step 13 of 35: [Deploy Swarm v1 Manager Server]
INFO[0048] Step 14 of 35: [Deploy Internal Cluster CA Server]
INFO[0050] Step 15 of 35: [Deploy Internal Client CA Server]
INFO[0052] Step 16 of 35: [Deploy UCP Controller Server]
INFO[0058] Step 17 of 35: [Deploy Kubernetes API Server]
INFO[0067] Step 18 of 35: [Deploy Kubernetes Controller Manager]
INFO[0073] Step 19 of 35: [Deploy Kubernetes Scheduler]
INFO[0078] Step 20 of 35: [Deploy Kubelet]
INFO[0079] Step 21 of 35: [Deploy Kubernetes Proxy]
INFO[0081] Step 22 of 35: [Wait for Healthy UCP Controller and Kubernetes API]
INFO[0082] Step 23 of 35: [Create Kubernetes Pod Security Policies]
INFO[0085] Step 24 of 35: [Install Kubernetes CNI Plugin]
INFO[0113] Step 25 of 35: [Install KubeDNS]
INFO[0121] Step 26 of 35: [Create UCP Controller Kubernetes Service Endpoints]
INFO[0124] Step 27 of 35: [Install Metrics Plugin]
INFO[0131] Step 28 of 35: [Install Kubernetes Compose Plugin]
INFO[0142] Step 29 of 35: [Deploy Manager Node Agent Service]
INFO[0142] Step 30 of 35: [Deploy Worker Node Agent Service]
INFO[0142] Step 31 of 35: [Deploy Windows Worker Node Agent Service]
INFO[0142] Step 32 of 35: [Deploy Cluster Agent Service]
INFO[0142] Step 33 of 35: [Set License]
INFO[0142] Step 34 of 35: [Set Registry CA Certificates]
INFO[0142] Step 35 of 35: [Wait for All Nodes to be Ready]
INFO[0147]     Waiting for 1 nodes to be ready
INFO[0152] All Installation Steps Completed
cse@ubuntu1804-1:~$
```

```

cse@ubuntu1804-1:~$ sudo docker ps
CONTAINER ID        IMAGE                         COMMAND                  CREATED              STATUS                   PORTS                                                                             NAMES
f8c4666a7646        docker/ucp-agent:3.2.0        "/bin/ucp-agent node…"   58 seconds ago       Up 56 seconds            2376/tcp                                                                          ucp-manager-agent.z5m50h0rl2kh4jehuoe76hj8k.tj89jrf9xkxmw0t42oec3xkb0
611ca05ab239        docker/ucp-agent:3.2.0        "/bin/ucp-agent clus…"   58 seconds ago       Up 56 seconds            2376/tcp                                                                          ucp-cluster-agent.1.omzv7veky1kbmzgl78g25surq
df16260783ea        50810572f8d1                  "/compose-controller…"   About a minute ago   Up About a minute                                                                                          k8s_ucp-kube-compose_compose-57cc55c56d-n7klp_kube-system_a7af24f5-b83b-11e9-86e4-0242ac11000b_0
5079f9dc068d        7f719dba281f                  "/api-server --kubec…"   About a minute ago   Up About a minute                                                                                          k8s_ucp-kube-compose-api_compose-api-556c6d8c86-xf9hc_kube-system_a7aefd70-b83b-11e9-86e4-0242ac11000b_0
506abc0ef18c        9fdd9422f8b8                  "/bin/proxy"             About a minute ago   Up About a minute                                                                                          k8s_ucp-metrics-proxy_ucp-metrics-c7zpb_kube-system_a565c9f2-b83b-11e9-86e4-0242ac11000b_0
a99093a69d39        9fdd9422f8b8                  "/bin/prometheus.sh …"   About a minute ago   Up About a minute                                                                                          k8s_ucp-metrics-prometheus_ucp-metrics-c7zpb_kube-system_a565c9f2-b83b-11e9-86e4-0242ac11000b_0
8d3bd381cdd4        9fdd9422f8b8                  "/bin/sh -c 'while :…"   About a minute ago   Up About a minute                                                                                          k8s_ucp-metrics-inventory_ucp-metrics-c7zpb_kube-system_a565c9f2-b83b-11e9-86e4-0242ac11000b_0
93544ed4f512        docker/ucp-pause:3.2.0        "/pause"                 About a minute ago   Up About a minute                                                                                          k8s_POD_compose-api-556c6d8c86-xf9hc_kube-system_a7aefd70-b83b-11e9-86e4-0242ac11000b_0
579b68869229        docker/ucp-pause:3.2.0        "/pause"                 About a minute ago   Up About a minute                                                                                          k8s_POD_compose-57cc55c56d-n7klp_kube-system_a7af24f5-b83b-11e9-86e4-0242ac11000b_0
3182cfcded2c        docker/ucp-pause:3.2.0        "/pause"                 About a minute ago   Up About a minute                                                                                          k8s_POD_ucp-metrics-c7zpb_kube-system_a565c9f2-b83b-11e9-86e4-0242ac11000b_0
2c88d0f54623        435d88fe6b45                  "/sidecar --v=2 --lo…"   About a minute ago   Up About a minute                                                                                          k8s_ucp-kubedns-sidecar_kube-dns-84cd964544-pljlj_kube-system_a0bb52b9-b83b-11e9-86e4-0242ac11000b_0
add0887ce338        ec8b25117519                  "/dnsmasq-nanny -v=2…"   About a minute ago   Up About a minute                                                                                          k8s_ucp-dnsmasq-nanny_kube-dns-84cd964544-pljlj_kube-system_a0bb52b9-b83b-11e9-86e4-0242ac11000b_0
4bb226feb0af        28b1e608dc41                  "/kube-dns --domain=…"   About a minute ago   Up About a minute                                                                                          k8s_ucp-kubedns_kube-dns-84cd964544-pljlj_kube-system_a0bb52b9-b83b-11e9-86e4-0242ac11000b_0
028ecd2f4ba8        docker/ucp-pause:3.2.0        "/pause"                 About a minute ago   Up About a minute                                                                                          k8s_POD_kube-dns-84cd964544-pljlj_kube-system_a0bb52b9-b83b-11e9-86e4-0242ac11000b_0
529aed9d12fc        eb607f503ccd                  "/usr/bin/kube-contr…"   About a minute ago   Up About a minute                                                                                          k8s_calico-kube-controllers_calico-kube-controllers-5589844c6c-gx7x8_kube-system_8edd2b9f-b83b-11e9-86e4-0242ac11000b_0
a77e677d8688        docker/ucp-pause:3.2.0        "/pause"                 About a minute ago   Up About a minute                                                                                          k8s_POD_calico-kube-controllers-5589844c6c-gx7x8_kube-system_8edd2b9f-b83b-11e9-86e4-0242ac11000b_0
e065fac81ef2        6904e301c3a7                  "/install-cni.sh"        About a minute ago   Up About a minute                                                                                          k8s_install-cni_calico-node-blhvh_kube-system_8e9166f2-b83b-11e9-86e4-0242ac11000b_0
c65d50dafef4        697d2c1dea15                  "start_runit"            About a minute ago   Up About a minute                                                                                          k8s_calico-node_calico-node-blhvh_kube-system_8e9166f2-b83b-11e9-86e4-0242ac11000b_0
1f478e937ee2        docker/ucp-pause:3.2.0        "/pause"                 About a minute ago   Up About a minute                                                                                          k8s_POD_calico-node-blhvh_kube-system_8e9166f2-b83b-11e9-86e4-0242ac11000b_0
56ef4c6e7449        docker/ucp-hyperkube:3.2.0    "kube-proxy --cluste…"   2 minutes ago        Up 2 minutes                                                                                               ucp-kube-proxy
ae412f355aaa        docker/ucp-hyperkube:3.2.0    "/bin/kubelet_entryp…"   2 minutes ago        Up 2 minutes                                                                                               ucp-kubelet
93c0fb13401a        docker/ucp-hyperkube:3.2.0    "kube-scheduler --ku…"   2 minutes ago        Up 2 minutes (healthy)                                                                                     ucp-kube-scheduler
e20bfdd75b9a        docker/ucp-hyperkube:3.2.0    "/bin/controller_man…"   2 minutes ago        Up 2 minutes (healthy)                                                                                     ucp-kube-controller-manager
46aee6f0c836        docker/ucp-hyperkube:3.2.0    "/bin/apiserver_entr…"   2 minutes ago        Up 2 minutes (healthy)   0.0.0.0:12388->12388/tcp                                                          ucp-kube-apiserver
5ad4de889f26        docker/ucp-controller:3.2.0   "/bin/controller ser…"   2 minutes ago        Up 2 minutes (healthy)   0.0.0.0:443->8080/tcp, 0.0.0.0:6443->8081/tcp                                     ucp-controller
b4788ba1fb8f        docker/ucp-cfssl:3.2.0        "/bin/ucp-ca serve -…"   2 minutes ago        Up 2 minutes (healthy)   0.0.0.0:12382->12382/tcp                                                          ucp-client-root-ca
4d54f68a269d        docker/ucp-cfssl:3.2.0        "/bin/ucp-ca serve -…"   2 minutes ago        Up 2 minutes (healthy)   0.0.0.0:12381->12381/tcp                                                          ucp-cluster-root-ca
80c74028f856        docker/ucp-swarm:3.2.0        "/bin/swarm manage -…"   2 minutes ago        Up 2 minutes (healthy)   0.0.0.0:2376->2375/tcp                                                            ucp-swarm-manager
2df245efdbd5        docker/ucp-agent:3.2.0        "/bin/ucp-agent prox…"   2 minutes ago        Up 2 minutes (healthy)   0.0.0.0:6444->6444/tcp, 0.0.0.0:12378->12378/tcp, 0.0.0.0:12376->2376/tcp         ucp-proxy
d1fb6f51567e        docker/ucp-auth:3.2.0         "/usr/local/bin/enzi…"   2 minutes ago        Up 2 minutes (healthy)                                                                                     ucp-auth-worker.z5m50h0rl2kh4jehuoe76hj8k.soauyq1ovtbzu5dsvqm1aulrl
e12173e6f7b9        docker/ucp-auth:3.2.0         "/usr/local/bin/enzi…"   2 minutes ago        Up 2 minutes (healthy)                                                                                     ucp-auth-api.z5m50h0rl2kh4jehuoe76hj8k.zbx3dkew00pro3s76s321wqgs
06667a03ffea        docker/ucp-auth-store:3.2.0   "/bin/entrypoint.sh …"   3 minutes ago        Up 3 minutes (healthy)   0.0.0.0:12383-12384->12383-12384/tcp                                              ucp-auth-store
40d316287979        docker/ucp-etcd:3.2.0         "/bin/entrypoint.sh …"   3 minutes ago        Up 3 minutes (healthy)   2380/tcp, 4001/tcp, 7001/tcp, 0.0.0.0:12380->12380/tcp, 0.0.0.0:12379->2379/tcp   ucp-kv
cse@ubuntu1804-1:~$
```

## Accessing the UCP

Now you should be able to access Docker Univeral Control Plane via https://<node-ip>
    

    

