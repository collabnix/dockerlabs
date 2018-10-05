# How to install Docker EE on Ubuntu 16.04?


## Pre-requisite

1. Remove Older Docker packages

```
$ sudo apt-get remove docker docker-engine docker-ce docker.io
```


```
dockerworxinc@instance-1:~$ cat /etc/os-release
NAME="Ubuntu"
VERSION="16.04.4 LTS (Xenial Xerus)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 16.04.4 LTS"
VERSION_ID="16.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=xenial
UBUNTU_CODENAME=xenial
```

For Ubuntu 16.04 and higher, the Linux kernel includes support for overlay2, and Docker EE uses it as the default storage driver. 
If you need to use aufs instead, you need to configure it manually. 

```
sudo apt update
```

```
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
```

## Adding DOCKER_EE_URL variable

You can temporarily add a $DOCKER_EE_URL variable into your environment. 
This only persists until you log out of the session. Replace <DOCKER-EE-URL> with the URL you noted down in the prerequisites.

```
DOCKER_EE_URL=stable-17.06
76d"
```

## 

```
curl -fsSL "${DOCKER_EE_URL}/ubuntu/gpg" | sudo apt-key add -
OK
```

##

Verify that you now have the key with the fingerprint DD91 1E99 5A64 A202 E859 07D6 BC14 F10B 6D08 5F96, by searching for the last eight characters of the fingerprint. Use the command as-is. 
It works because of the variable you set earlier.


```
sudo apt-key fingerprint 6D085F96
pub   4096R/6D085F96 2017-02-22
      Key fingerprint = DD91 1E99 5A64 A202 E859  07D6 BC14 F10B 6D08 5F96
uid                  Docker Release (EE deb) <docker@docker.com>
sub   4096R/91A29FA3 2017-02-22
```

##

Use the following command to set up the stable repository. Use the command as-is. It works because of the variable you set earlier.


```
$ sudo add-apt-repository \
>    "deb [arch=amd64] $DOCKER_EE_URL/ubuntu \
>    $(lsb_release -cs) \
>    $DOCKER_EE_VERSION"
```

## Run the below commands:

```

apt update
apt install docker-ee

```

## Verifying Docker Version

```
openusm@node-e1:~$ sudo docker version
Client: Docker Enterprise Edition (EE) 2.0
 Version:      17.06.2-ee-16
 API version:  1.30
 Go version:   go1.8.7
 Git commit:   9ef4f0a
 Built:        Thu Jul 26 16:41:28 2018
 OS/Arch:      linux/amd64
Server: Docker Enterprise Edition (EE) 2.0
 Engine:
  Version:      17.06.2-ee-16
  API version:  1.30 (minimum version 1.12)
  Go version:   go1.8.7
  Git commit:   9ef4f0a
  Built:        Thu Jul 26 16:40:18 2018
  OS/Arch:      linux/amd64
  Experimental: false
```


## 

On production systems, you should install a specific version of Docker EE instead of always using the latest. This output is truncated. List the available versions.

```
$ apt-cache madison docker-ee
 docker-ee | 3:18.03.1~ee~2~3-0~ubuntu | https://storebits.docker.com/ee/ubuntu/sub-6f046f55-8d6c-4dfb-a5b0-06d710c8676
d/ubuntu xenial/stable-18.03 amd64 Packages
 docker-ee | 3:18.03.1~ee~1~3-0~ubuntu | https://storebits.docker.com/ee/ubuntu/sub-6f046f55-8d6c-4dfb-a5b0-06d710c8676
d/ubuntu xenial/stable-18.03 amd64 Packages


```

##

```
$ sudo docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
9db2ca6ccae0: Pull complete 
Digest: sha256:4b8ff392a12ed9ea17784bd3c9a8b1fa3299cac44aca35a85c90c5e3c7afacdc
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
 https://docs.docker.com/engine/userguide/

```

##  Manage Docker as a non-root user

The docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user root and other users can only access it using sudo. ```The docker daemon always runs as the root user.```

If you don’t want to use sudo when you use the docker command, create a Unix group called docker and add users to it. When the docker daemon starts, it makes the ownership of the Unix socket read/writable by the docker group.

## Configure Docker to start on boot

Most current Linux distributions (RHEL, CentOS, Fedora, Ubuntu 16.04 and higher) use systemd to manage which services start when the system boots. Ubuntu 14.10 and below use upstart.

## systemd

```
$ sudo systemctl enable docker
````

To disable this behavior, use disable instead.

```
$ sudo systemctl disable docker
```

If you need to add an HTTP Proxy, set a different directory or partition for the Docker runtime files, or make other customizations, see customize your systemd Docker daemon options.

## upstart

Docker is automatically configured to start on boot using upstart. To disable this behavior, use the following command:

```
$ echo manual | sudo tee /etc/init/docker.override
```
## chkconfig

```
$ sudo chkconfig docker on
```

## Installing UCP

Ensure that you have atleast 4GB RAM.

```
sudo docker container run --rm -it --name ucp   -v /var/run/docker.sock:/var/run/docker.sock   docker/ucp:3
.0.5 install   --host-address 10.140.0.4 --interactive
INFO[0000] Your engine version 17.06.2-ee-16, build 9ef4f0a (4.15.0-1021-gcp) is compatible with UCP 3.0.5 (f588f8a) 
Admin Username: ajeetraina
Admin Password: 
Confirm Admin Password: 
INFO[0009] Pulling required images... (this may take a while) 
INFO[0009] Pulling docker/ucp-metrics:3.0.5             
INFO[0020] Pulling docker/ucp-swarm:3.0.5               
INFO[0026] Pulling docker/ucp-calico-cni:3.0.5          
INFO[0039] Pulling docker/ucp-hyperkube:3.0.5           
INFO[0062] Pulling docker/ucp-dsinfo:3.0.5              
INFO[0069] Pulling docker/ucp-etcd:3.0.5                
INFO[0078] Pulling docker/ucp-pause:3.0.5               
INFO[0082] Pulling docker/ucp-interlock-extension:3.0.5 
INFO[0085] Pulling docker/ucp-auth:3.0.5                
INFO[0091] Pulling docker/ucp-cfssl:3.0.5               
INFO[0098] Pulling docker/ucp-kube-dns-sidecar:3.0.5    
INFO[0105] Pulling docker/ucp-interlock-proxy:3.0.5     
INFO[0109] Pulling docker/ucp-kube-compose:3.0.5        
INFO[0116] Pulling docker/ucp-kube-dns:3.0.5            
INFO[0123] Pulling docker/ucp-kube-dns-dnsmasq-nanny:3.0.5 
INFO[0131] Pulling docker/ucp-controller:3.0.5 
INFO[0145] Pulling docker/ucp-agent:3.0.5               
INFO[0152] Pulling docker/ucp-calico-kube-controllers:3.0.5 
INFO[0167] Pulling docker/ucp-calico-node:3.0.5         
INFO[0188] Pulling docker/ucp-compose:3.0.5             
INFO[0193] Pulling docker/ucp-interlock:3.0.5           
WARN[0199] None of the hostnames we'll be using in the UCP certificates [node-e1 127.0.0.1 172.17.0.1 10.140.0.4] contain a domain component.  Your generated certs may fail TLS validation unless you only use one of these shortnames or IPs to connect.  You can use the --san flag to add more aliases 

You may enter additional aliases (SANs) now or press enter to proceed with the above list.
Additional aliases: 
INFO[0000] Initializing a new swarm at 10.140.0.4       
INFO[0013] Installing UCP with host address 10.140.0.4 - If this is incorrect, please specify an alternative address with the '--host-address' flag 
INFO[0013] Deploying UCP Service...
```

## Troubleshooting

```
{"level":"error","msg":"unable to wait for addon calico to deploy: Timed out while waiting for kube node node-e1 to become re
ady","time":"2018-10-05T15:44:40Z"}
{"level":"fatal","msg":"unable to reconcile state of Kubernetes CNI Plugin component: unable to wait for addon calico to depl
oy: Timed out while waiting for kube node node-e1 to become ready","time":"2018-10-05T15:44:40Z"}
{"level":"info","msg":"ucp-reconcile container exited with status code: 1","time":"2018-10-05T15:44:40Z"}
{"level":"info","msg":"Completed state reconciliation, system is ready.","time":"2018-10-05T15:44:40Z"}
ERRO[0658] Unable to successfully setup local node. Run "docker logs ucp-reconcile" for more details 
FATA[0658] reconcile exited with non-zero status: 1 
```

To fix this issue, increase 1vCPU to 2vCPU.

```
{"level":"info","msg":"successfully reconciled state of eNZi Worker x86_64 service component. This component will enable eNZi workers on x86_64 linux nodes if they are added to 
the cluster","time":"2018-10-05T16:24:05Z"}
{"level":"info","msg":"successfully reconciled state of Concurrent [eNZi Worker x86_64 service eNZi Worker s390x service] component","time":"2018-10-05T16:24:05Z"}
{"level":"debug","msg":"Initialing UCP auth service configuration","time":"2018-10-05T16:24:06Z"}
{"level":"debug","msg":"Writing out initial configuration to KV store","time":"2018-10-05T16:24:06Z"}
{"level":"debug","msg":"creating new KV object","time":"2018-10-05T16:24:06Z"}
{"level":"debug","msg":"Auth API component reconciled successfully","time":"2018-10-05T16:24:07Z"}
{"level":"info","msg":"successfully reconciled state of eNZi API x86_64 service component. This component will enable eNZi API servers on x86_64 linux nodes if they are added to
 the cluster","time":"2018-10-05T16:24:07Z"}
{"level":"info","msg":"successfully reconciled state of Concurrent [eNZi API x86_64 service eNZi API s390x service] component","time":"2018-10-05T16:24:07Z"}
{"level":"info","msg":"successfully reconciled state of [etcd Exclusive RethinkDB etcdmigration eNZi Secret Concurrent [Swarm-Classic Manager Concurrent [eNZi API x86_64 service
 eNZi API s390x service] Concurrent [eNZi Worker x86_64 service eNZi Worker s390x service] Kubernetes Scheduler Kubernetes Controller Manager]] component","time":"2018-10-05T16:
24:07Z"}
{"level":"info","msg":"Reconciling state of component Concurrent [Kubernetes API Server UCP Controller]","time":"2018-10-05T16:24:07Z"}
{"level":"debug","msg":"Node already has master config on disk","time":"2018-10-05T16:24:07Z"}
{"level":"debug","msg":"Deploying UCP Controller Container","time":"2018-10-05T16:24:07Z"}
{"level":"debug","msg":"Starting UCP controller","time":"2018-10-05T16:24:07Z"}
{"level":"debug","msg":"creating new KV object","time":"2018-10-05T16:24:07Z"}
{"level":"debug","msg":"Attempting to remove any previous ucp-kube-apiserver container, if it exists","time":"2018-10-05T16:24:07Z"}
{"level":"info","msg":"Starting up ucp-kube-apiserver container","time":"2018-10-05T16:24:07Z"}
{"level":"debug","msg":"Checking for liveness of https://10.140.0.4:443/_ping","time":"2018-10-05T16:24:07Z"}
{"level":"info","msg":"successfully reconciled state of Kubernetes API Server component","time":"2018-10-05T16:24:08Z"}
{"level":"debug","msg":"Connected to https://10.140.0.4:443/_ping","time":"2018-10-05T16:24:14Z"}
{"level":"debug","msg":"Controller component reconciled successfully","time":"2018-10-05T16:24:14Z"}
{"level":"info","msg":"successfully reconciled state of UCP Controller component","time":"2018-10-05T16:24:14Z"}
{"level":"info","msg":"Reconciling state of component Kubernetes CNI Plugin","time":"2018-10-05T16:24:14Z"}
{"level":"debug","msg":"No CNI Installer URL configuration detected, reconciling as an addon","time":"2018-10-05T16:24:14Z"}
{"level":"info","msg":"Deploying addon calico","time":"2018-10-05T16:24:17Z"}
{"level":"info","msg":"Waiting for kubernetes node node-e1 to become ready","time":"2018-10-05T16:24:22Z"}
{"level":"info","msg":"Addon calico was deployed successfully","time":"2018-10-05T16:24:22Z"}
{"level":"info","msg":"Reconciling state of component Kubernetes addons","time":"2018-10-05T16:24:22Z"}
{"level":"info","msg":"Deploying addon compose","time":"2018-10-05T16:24:22Z"}
{"level":"info","msg":"Deploying addon kubedns","time":"2018-10-05T16:24:27Z"}
{"level":"info","msg":"Addon kubedns was deployed successfully","time":"2018-10-05T16:24:30Z"}
{"level":"info","msg":"Addon compose was deployed successfully","time":"2018-10-05T16:24:30Z"}
DEBU[0069] Changing admin temp password to given password 
{"level":"info","msg":"Completed state reconciliation, system is ready.","time":"2018-10-05T16:24:30Z"}
DEBU[0070] creating new KV object                       
DEBU[0070] node-e1 (node a0cy301twurh8na6xngp6obmt) has joined the swarm classic cluster with URL tcp://10.140.0.4:12376 
INFO[0070] Installation completed on node-e1 (node a0cy301twurh8na6xngp6obmt) 
INFO[0070] UCP Instance ID: b92spaikb3jc6u6lt3yfwxtpk   
INFO[0070] UCP Server SSL: SHA-256 Fingerprint=B4:5C:23:B7:81:10:90:BC:67:70:94:2B:41:05:C9:55:4F:6F:16:9F:E3:1E:A5:23:99:41:8A:A5:2C:86:69:E5 
INFO[0070] Login to UCP at https://10.140.0.4:443       
INFO[0070] Username: openusm                            
INFO[0070] Password: (your admin password)
```

## Uninstalling 

```

openusm@node-e1:~$ sudo docker container run --rm -it --name ucp   -v /var/run/docker.sock:/var/run/docker.sock   docker/ucp:
3.0.5 uninstall-ucp  --id b92spaikb3jc6u6lt3yfwxtpk
INFO[0000] Your engine version 17.06.2-ee-16, build 9ef4f0a (4.15.0-1021-gcp) is compatible with UCP 3.0.5 (f588f8a) 
INFO[0000] Uninstalling UCP on each node...             
INFO[0020] UCP has been removed from this cluster successfully. 
INFO[0022] Removing UCP Services   

```
