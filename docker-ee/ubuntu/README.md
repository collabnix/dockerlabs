# Setting up Docker EE 2.0 on Ubuntu 18.04 


## Scripting Method

## Cloning the Repository

```
git clone https://github.com/ajeetraina/docker101
cd docker101/docker-ee/ubuntu
```

## Installing Docker EE

Get 1 Month Trial Version of Docker EE. You will get access to URL. Copy the section from URL starting from sub

```
https://storebits.docker.com/ee/ubuntu/sub-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx
```

## Exporting URL

```
export eeid=sub-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx
```

## Installing Docker EE

```
sh bootstrap.sh provision_dockeree
```

## Setting up UCP

```
sudo sh bootstrap.sh provision_ucp
```

```
openusm@master01:~/test/docker101/docker-ee/ubuntu$ sudo sh bootstrap.sh provision_ucp
Unable to find image 'docker/ucp:3.0.5' locally
3.0.5: Pulling from docker/ucp
ff3a5c916c92: Pull complete 
a52011fa0ead: Pull complete 
87e35eb74a08: Pull complete 
Digest: sha256:c8a609209183561de7779e5d32abc5fd9125944c67e8daf262dcbb9f2b1e44ff
Status: Downloaded newer image for docker/ucp:3.0.5
INFO[0000] Your engine version 17.06.2-ee-16, build 9ef4f0a (4.15.0-1021-gcp) is compatible with UCP 3.0.5 (f588f8a) 
Admin Username: collabnix
Admin Password: 
Confirm Admin Password: 
INFO[0043] Pulling required images... (this may take a while) 
INFO[0043] Pulling docker/ucp-auth:3.0.5                
INFO[0049] Pulling docker/ucp-hyperkube:3.0.5           
INFO[0064] Pulling docker/ucp-etcd:3.0.5                
INFO[0070] Pulling docker/ucp-interlock-proxy:3.0.5     
INFO[0086] Pulling docker/ucp-agent:3.0.5               
INFO[0092] Pulling docker/ucp-kube-compose:3.0.5        
INFO[0097] Pulling docker/ucp-dsinfo:3.0.5              
INFO[0104] Pulling docker/ucp-cfssl:3.0.5               
INFO[0107] Pulling docker/ucp-kube-dns-sidecar:3.0.5    
INFO[0112] Pulling docker/ucp-interlock:3.0.5           
INFO[0115] Pulling docker/ucp-kube-dns:3.0.5            
INFO[0120] Pulling docker/ucp-controller:3.0.5          
INFO[0128] Pulling docker/ucp-pause:3.0.5               
INFO[0132] Pulling docker/ucp-calico-kube-controllers:3.0.5 
INFO[0136] Pulling docker/ucp-auth-store:3.0.5          
INFO[0142] Pulling docker/ucp-calico-cni:3.0.5          
INFO[0149] Pulling docker/ucp-calico-node:3.0.5         
INFO[0158] Pulling docker/ucp-kube-dns-dnsmasq-nanny:3.0.5 
INFO[0163] Pulling docker/ucp-compose:3.0.5             
INFO[0167] Pulling docker/ucp-swarm:3.0.5               
INFO[0173] Pulling docker/ucp-metrics:3.0.5             
INFO[0179] Pulling docker/ucp-interlock-extension:3.0.5 
WARN[0183] None of the hostnames we'll be using in the UCP certificates [master01 127.0.0.1 172.17.0.1 10.140.0.2] contain a domain component.  Your generated certs may fail TLS validation unless you only use one of these shortnames or IPs to connect.  You can use the --san flag to add more aliases 

You may enter additional aliases (SANs) now or press enter to proceed with the above list.
Additional aliases: 
INFO[0000] Initializing a new swarm at 10.140.0.2 
Additional aliases: 
INFO[0000] Initializing a new swarm at 10.140.0.2       
INFO[0009] Installing UCP with host address 10.140.0.2 - If this is incorrect, please specify an alternative address with the '--host-address' flag 
INFO[0009] Deploying UCP Service...                     
INFO[0068] Installation completed on master01 (node slsvy00m1khejbo5itmupk034) 
INFO[0068] UCP Instance ID: omz7lso0zpeyzk17gxubvz72r   
INFO[0068] UCP Server SSL: SHA-256 Fingerprint=24:9B:51:4E:E2:F1:CD:1B:DE:E0:86:0F:DC:E7:29:B5:1E:0E:6B:0C:BF:24:CC:27:85:91:35:A1:6A:39:37:C6 
INFO[0068] Login to UCP at https://10.140.0.2:443       
INFO[0068] Username: collabnix                          
INFO[0068] Password: (your admin password) 
```

## Logging in Docker EE 

By now, you should be able to login to Docker EE Window using browser. Upload the license and you should be good to see the UCP console.


## Installing Kubectl

```
sudo sh bootstrap.sh install_kubectl
```

## Verify Kubectl Version

```
@master01:~$ kubectl version
Client Version: version.Info{Major:"1", Minor:"8", GitVersion:"v1.8.11", GitCommit:"1df6a8381669a6c753f79cb31ca2e3d57ee7c8a3", GitTreeState:"clean", BuildDate:"2018-04-05T17:24:
03Z", GoVersion:"go1.8.3", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"8+", GitVersion:"v1.8.11-docker-8d637ae", GitCommit:"8d637aedf46b9c21dde723e29c645b9f27106fa5", GitTreeState:"clean", BuildDate:"2
018-04-26T16:51:21Z", GoVersion:"go1.8.3", Compiler:"gc", Platform:"linux/amd64"}
```

## Verifying Docker Version

```
 docker version
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
 Universal Control Plane:
  Version:       3.0.5
  ApiVersion:                   1.30
  Arch:                         amd64
  BuildTime:                    Thu Aug 30 17:47:03 UTC 2018
  GitCommit:                    f588f8a
  GoVersion:                    go1.9.4
  MinApiVersion:                1.20
  Os:                           linux
 Kubernetes:
  Version:      1.8+
  buildDate:                   2018-04-26T16:51:21Z
  compiler:                    gc
  gitCommit:                   8d637aedf46b9c21dde723e29c645b9f27106fa5
  gitTreeState:                clean
  gitVersion:                  v1.8.11-docker-8d637ae
  goVersion:                   go1.8.3
  major:                       1
  minor:                       8+
  platform:                    linux/amd64
 Calico:
  Version:          v3.0.8
  cni:                             v2.0.6
  kube-controllers:                v2.0.5
  node:                            v3.0.8
  ```



## Verifying the Kubernetes Nodes
```
@master01:~/test/docker101/docker-ee/ubuntu$ kubectl get nodes
NAME       STATUS    ROLES     AGE       VERSION
master01   Ready     master    20m       v1.8.11-docker-8d637ae
```

## Adding Worker Nodes


```
m@master01:~$ sudo docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS
av668en5dinpin5jpi6ro0yfs     worker01            Ready               Active              
k4grcnyl6vbf0z17bh67cz9l5     worker02            Ready               Active              
slsvy00m1khejbo5itmupk034 *   master01            Ready               Active              Leader

@master01:~$ kubectl get nodes
NAME       STATUS     ROLES     AGE       VERSION
master01   Ready      master    1h        v1.8.11-docker-8d637ae
worker01   NotReady   <none>    28s       v1.8.11-docker-8d637ae
worker02   Ready      <none>    3m        v1.8.11-docker-8d637ae
openusm@master01:~$ 
```

## Installing Helm

```
openusm@master01:~$ curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > install-helm.sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  7230  100  7230    0     0  17173      0 --:--:-- --:--:-- --:--:-- 17132
openusm@master01:~$ chmod u+x install-helm.sh
openusm@master01:~$ ./install-helm.sh
Downloading https://kubernetes-helm.storage.googleapis.com/helm-v2.11.0-linux-amd64.tar.gz
Preparing to install helm and tiller into /usr/local/bin
helm installed into /usr/local/bin/helm
tiller installed into /usr/local/bin/tiller
Run 'helm init' to configure helm.
openusm@master01:~$ helm init
Creating /home/openusm/.helm 
Creating /home/openusm/.helm/repository 
Creating /home/openusm/.helm/repository/cache 
Creating /home/openusm/.helm/repository/local 
Creating /home/openusm/.helm/plugins 
Creating /home/openusm/.helm/starters 
Creating /home/openusm/.helm/cache/archive 
Creating /home/openusm/.helm/repository/repositories.yaml 
Adding stable repo with URL: https://kubernetes-charts.storage.googleapis.com 
Adding local repo with URL: http://127.0.0.1:8879/charts 
$HELM_HOME has been configured at /home/openusm/.helm.
Tiller (the Helm server-side component) has been installed into your Kubernetes Cluster.
Please note: by default, Tiller is deployed with an insecure 'allow unauthenticated users' policy.
To prevent this, run `helm init` with the --tiller-tls-verify flag.
For more information on securing your installation see: https://docs.helm.sh/using_helm/#securing-your-helm-installation
Happy Helming!
openusm@master01:~$
```

## Verifying Helm Version

```
helm version
Client: &version.Version{SemVer:"v2.11.0", GitCommit:"2e55dbe1fdb5fdb96b75ff144a339489417b146b", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.11.0", GitCommit:"2e55dbe1fdb5fdb96b75ff144a339489417b146b", GitTreeState:"clean"}

```

## Installing MYSQL using Helm

```
helm install --name mysql stable/mysql
Error: release mysql failed: namespaces "default" is forbidden: User "system:serviceaccount:kube-system:default" cannot get namespaces in the namespace "default": access denied
```

## Troubleshooting

```
openusm@master01:~$ kubectl create serviceaccount --namespace kube-system tiller
serviceaccount "tiller" created
```

Follow the below steps:

```
openusm@master01:~$  kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
deployment "tiller-deploy" patched
```

```
openusm@master01:~$ helm init --service-account tiller
$HELM_HOME has been configured at /home/openusm/.helm.
Warning: Tiller is already installed in the cluster.
(Use --client-only to suppress this message, or --upgrade to upgrade Tiller to the current version.)
Happy Helming!
```

```
openusm@master01:~$ helm install --name mysql stable/mysql
NAME:   mysql
LAST DEPLOYED: Thu Oct 11 13:37:52 2018
NAMESPACE: default
STATUS: DEPLOYED
RESOURCES:
==> v1/Pod(related)
NAME                    READY  STATUS   RESTARTS  AGE
mysql-694696f6d5-w4j5n  0/1    Pending  0         1s
==> v1/Secret
NAME   AGE
mysql  1s
==> v1/ConfigMap
mysql-test  1s
==> v1/PersistentVolumeClaim
mysql  1s
==> v1/Service
mysql  1s
==> v1beta1/Deployment
mysql  1s
NOTES:
MySQL can be accessed via port 3306 on the following DNS name from within your cluster:
mysql.default.svc.cluster.local
To get your root password run:
    MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace default mysql -o jsonpath="{.data.mysql-root-password}" | base64 --decode; echo)
To connect to your database:
1. Run an Ubuntu pod that you can use as a client:
    kubectl run -i --tty ubuntu --image=ubuntu:16.04 --restart=Never -- bash -il
2. Install the mysql client:
    $ apt-get update && apt-get install mysql-client -y
3. Connect using the mysql cli, then provide your password:
    $ mysql -h mysql -p
To connect to your database directly from outside the K8s cluster:
    MYSQL_HOST=127.0.0.1
    MYSQL_PORT=3306
    # Execute the following command to route the connection:
    kubectl port-forward svc/mysql 3306
    mysql -h ${MYSQL_HOST} -P${MYSQL_PORT} -u root -p${MYSQL_ROOT_PASSWORD}
    

```


# Manual Method(Step-by-Step)

## Tested Infra

This guide uses the below configuration: - 

- Docker Enterprise Edition 17.06.2-ee-16
- Linux kernel 4.15.0-1021-gcp
- 8 GB of RAM
- 30 GB of available disk space
- Installed Kubectl Version(installation steps below)
- Google Cloud Platform

```
Client Version: version.Info{Major:"1", Minor:"8", GitVersion:"v1.8.11", GitCommit:"1df6a8381669a6c753f79cb31ca2e3d57ee7c8a3", GitTreeState:"clean", BuildDate:"2018-04-05T17:24:
03Z", GoVersion:"go1.8.3", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"8+", GitVersion:"v1.8.11-docker-8d637ae", GitCommit:"8d637aedf46b9c21dde723e29c645b9f27106fa5", GitTreeState:"clean", BuildDate:"2
018-04-26T16:51:21Z", GoVersion:"go1.8.3", Compiler:"gc", Platform:"linux/amd64"}
```

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
You may enter additional aliases (SANs) now or press enter to proceed with the above list.

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

## Adding Worker Nodes

Now its time to add worker nodes. Install Docker EE using install-ee.sh under the same repository
Ensure that you put correct DOCKER_EE_URL

```
openusm@node-e2:~$ sudo docker swarm join --token SWMTKN-1-XXX 10.140.0.4:2377
This node joined a swarm as a worker.
```

By now, you should be able to see 1 Master and 2 Worker Node.


## Installing Kubectl

```
 sudo snap install kubectl --classic
kubectl 1.11.3 from Canonical✓ installed

```

## Using kubectl with a Docker EE cluster

Docker Enterprise Edition provides users unique certificates and keys to authenticate against the Docker and Kubernetes APIs. Instructions on how to download these certificates and how to configure kubectl to use them can be found in CLI-based access.

Now you need to install k8s client bundle for kubectl to point it from local to UCP 

```
openusm@node-e1:~$ AUTHTOKEN=$(curl -sk -d '{"username":"openusm","password":"xxx"}' https://10.140.0.4/auth/login | j
q -r .auth_token)
openusm@node-e1:~$ sudo curl -k -H "Authorization: Bearer $AUTHTOKEN" https://10.140.0.4/api/clientbundle -o bundle.zip
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  9857  100  9857    0     0   150k      0 --:--:-- --:--:-- --:--:--  150k
openusm@node-e1:~$ unzip bundle.zip
Archive:  bundle.zip
 extracting: ca.pem                  
 extracting: cert.pem                
 extracting: key.pem                 
 extracting: cert.pub                
 extracting: env.ps1                 
 extracting: env.cmd                 
 extracting: kube.yml                
 extracting: env.sh                  
openusm@node-e1:~$ 

```

```
node-e1:~$ eval "$(<env.sh)"
Cluster "ucp_10.140.0.4:6443_openusm" set.
User "ucp_10.140.0.4:6443_openusm" set.
Context "ucp_10.140.0.4:6443_openusm" created.
```

Now kubectl should detect your kubernetes cluster

```
@node-e1:~$ kubectl get nodes
NAME       STATUS    ROLES     AGE       VERSION
node-e1    Ready     master    1h        v1.8.11-docker-8d637ae
node-e2    Ready     <none>    35m       v1.8.11-docker-8d637ae
node-ee3   Ready     <none>    34m       v1.8.11-docker-8d637ae
```

```
 kubectl version
Client Version: version.Info{Major:"1", Minor:"8", GitVersion:"v1.8.11", GitCommit:"1df6a8381669a6c753f79cb31ca2e3d57ee7c8a3", GitTreeState:"clean", BuildDate:"2018-04-05T17:24:
03Z", GoVersion:"go1.8.3", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"8+", GitVersion:"v1.8.11-docker-8d637ae", GitCommit:"8d637aedf46b9c21dde723e29c645b9f27106fa5", GitTreeState:"clean", BuildDate:"2
018-04-26T16:51:21Z", GoVersion:"go1.8.3", Compiler:"gc", Platform:"linux/amd64"}
```
## Verify K8s 

```
bernetes master is running at https://10.140.0.4:6443
KubeDNS is running at https://10.140.0.4:6443/api/v1/namespaces/kube-system/services/kube-dns/proxy
To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

## Installing Helm
```
openusm@node-e1:~$ curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > install-helm.sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  7230  100  7230    0     0  17548      0 --:--:-- --:--:-- --:--:-- 17548
openusm@node-e1:~$ chmod u+x install-helm.sh

openusm@node-e1:~$ ./install-helm.sh
Downloading https://kubernetes-helm.storage.googleapis.com/helm-v2.11.0-linux-amd64.tar.gz
Preparing to install helm and tiller into /usr/local/bin
helm installed into /usr/local/bin/helm
tiller installed into /usr/local/bin/tiller
Run 'helm init' to configure helm.
openusm@node-e1:~$ helm init
$HELM_HOME has been configured at /home/openusm/.helm.
Warning: Tiller is already installed in the cluster.
(Use --client-only to suppress this message, or --upgrade to upgrade Tiller to the current version.)
Happy Helming!
```

## Installing Tiller Account

```
openusm@node-e1:~$ kubectl -n kube-system create serviceaccount tiller
serviceaccount "tiller" created
```

```
@node-e1:~/install-istio/istio-1.0.2$ kubectl get po,svc,deploy
NAME                                   READY     STATUS    RESTARTS   AGE
po/nginx-deployment-76dcc8c697-2t4sq   1/1       Running   0          54m
po/nginx-deployment-76dcc8c697-c5c65   1/1       Running   0          54m
NAME             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
svc/kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP        1h
svc/nginx        NodePort    10.96.203.209   <none>        80:32768/TCP   53m
NAME                      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deploy/nginx-deployment   2         2         2            2           54m
```

## Installing Istio

```
openusm@node-e1:~$ sudo curl -L https://git.io/getLatestIstio | sudo sh -
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100  1456  100  1456    0     0   1743      0 --:--:-- --:--:-- --:--:--  1743
Downloading istio-1.0.2 from https://github.com/istio/istio/releases/download/1.0.2/istio-1.0.2-linux.tar.gz ...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   614    0   614    0     0    741      0 --:--:-- --:--:-- --:--:--   740
100 14.1M  100 14.1M    0     0   823k      0  0:00:17  0:00:17 --:--:--  959k
Downloaded into istio-1.0.2:
LICENSE  README.md  bin  install  istio.VERSION  samples  tools
Add /home/openusm/istio-1.0.2/bin to your path; e.g copy paste in your shell and/or ~/.profile:
export PATH="$PATH:/home/openusm/istio-1.0.2/bin"
```

```
openusm@node-e1:~/install-istio$ istioctl  version
Version: 1.0.2
GitRevision: d639408fded355fb906ef2a1f9e8ffddc24c3d64
User: root@66ce69d4a51e
Hub: gcr.io/istio-release
GolangVersion: go1.10.1
BuildStatus: Clean

```

## Configure Istio CRD

Istio has extended Kubernetes via Custom Resource Definitions (CRD). Deploy the extensions by applying crds.yaml.


```
$kubectl apply -f install/kubernetes/helm/istio/templates/crds.yaml -n istio-system
customresourcedefinition "envoyfilters.networking.istio.io" configured
customresourcedefinition "policies.authentication.istio.io" created
customresourcedefinition "meshpolicies.authentication.istio.io" created
customresourcedefinition "httpapispecbindings.config.istio.io" configured
customresourcedefinition "httpapispecs.config.istio.io" configured
customresourcedefinition "quotaspecbindings.config.istio.io" configured
customresourcedefinition "quotaspecs.config.istio.io" configured
customresourcedefinition "rules.config.istio.io" configured
customresourcedefinition "attributemanifests.config.istio.io" configured
customresourcedefinition "bypasses.config.istio.io" configured
customresourcedefinition "circonuses.config.istio.io" configured
customresourcedefinition "deniers.config.istio.io" configured
customresourcedefinition "fluentds.config.istio.io" configured
customresourcedefinition "kubernetesenvs.config.istio.io" configured
customresourcedefinition "listcheckers.config.istio.io" configured
customresourcedefinition "memquotas.config.istio.io" configured
customresourcedefinition "noops.config.istio.io" configured
customresourcedefinition "opas.config.istio.io" configured
customresourcedefinition "prometheuses.config.istio.io" configured
customresourcedefinition "rbacs.config.istio.io" configured
customresourcedefinition "redisquotas.config.istio.io" configured
customresourcedefinition "servicecontrols.config.istio.io" configured
customresourcedefinition "signalfxs.config.istio.io" configured
customresourcedefinition "solarwindses.config.istio.io" configured
customresourcedefinition "stackdrivers.config.istio.io" configured
customresourcedefinition "statsds.config.istio.io" configured
customresourcedefinition "stdios.config.istio.io" configured
customresourcedefinition "apikeys.config.istio.io" configured
customresourcedefinition "authorizations.config.istio.io" configured
customresourcedefinition "checknothings.config.istio.io" configured
customresourcedefinition "kuberneteses.config.istio.io" configured
customresourcedefinition "listentries.config.istio.io" configured
customresourcedefinition "logentries.config.istio.io" configured
customresourcedefinition "edges.config.istio.io" configured
customresourcedefinition "metrics.config.istio.io" configured
customresourcedefinition "quotas.config.istio.io" configured
customresourcedefinition "reportnothings.config.istio.io" configured
customresourcedefinition "servicecontrolreports.config.istio.io" configured
customresourcedefinition "tracespans.config.istio.io" configured
customresourcedefinition "rbacconfigs.rbac.istio.io" configured
customresourcedefinition "serviceroles.rbac.istio.io" configured
customresourcedefinition "servicerolebindings.rbac.istio.io" configured
customresourcedefinition "adapters.config.istio.io" configured
customresourcedefinition "instances.config.istio.io" configured
customresourcedefinition "templates.config.istio.io" configured
customresourcedefinition "handlers.config.istio.io" configured
@node-e1:~/istio-1.0.2$ 
```


## Install Istio with default mutual TLS authentication

To Install Istio and enforce mutual TLS authentication by default, use the yaml istio-demo-auth.yaml:

```
kubectl apply -f install/kubernetes/istio-demo-auth.yaml --validate=false
...
...
service "jaeger-query" unchanged
service "jaeger-collector" unchanged
service "jaeger-agent" unchanged
service "zipkin" unchanged
service "tracing" unchanged
attributemanifest "istioproxy" created
attributemanifest "kubernetes" created
stdio "handler" created
logentry "accesslog" created
logentry "tcpaccesslog" created
rule "stdio" created
rule "stdiotcp" created
metric "requestcount" created
metric "requestduration" created
metric "requestsize" created
metric "responsesize" created
metric "tcpbytesent" created
metric "tcpbytereceived" created
prometheus "handler" created
rule "promhttp" created
rule "promtcp" created
kubernetesenv "handler" created
rule "kubeattrgenrulerule" created
rule "tcpkubeattrgenrulerule" created
kubernetes "attributes" created
destinationrule "istio-policy" created
destinationrule "istio-telemetry" created
Error from server (Invalid): error when creating "install/kubernetes/istio-demo-auth.yaml": Service "istio-ingressgateway" is invalid: spec.ports[0].nodePort: Invalid value: 313
80: provided port is not in the valid range. The range of valid ports is 32768-35535
[unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole, unable to recognize "install/kubernetes/istio-demo-a
uth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding, unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k
8s.io/, Kind=ClusterRole, unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding, unable to recognize 
"install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole, unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches
 for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding, unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterR
ole, unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole, unable to recognize "install/kubernetes/istio-de
mo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole, unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.
io/, Kind=ClusterRole, unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole, unable to recognize "install/k
ubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole, unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.
authorization.k8s.io/, Kind=ClusterRole, unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole, unable to re
cognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding, unable to recognize "install/kubernetes/istio-demo-auth.ya
ml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding, unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/
, Kind=ClusterRoleBinding, unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding, unable to recognize
 "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding, unable to recognize "install/kubernetes/istio-demo-auth.yaml": no
 matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding, unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=
ClusterRoleBinding, unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding, unable to recognize "insta
ll/kubernetes/istio-demo-auth.yaml": no matches for admissionregistration.k8s.io/, Kind=MutatingWebhookConfiguration]
```

How to fix this issue?

Change all ports above 30xxx to 33xxx

```
service "tracing" unchanged
attributemanifest "istioproxy" configured
attributemanifest "kubernetes" configured
stdio "handler" configured
logentry "accesslog" configured
logentry "tcpaccesslog" configured
rule "stdio" configured
rule "stdiotcp" configured
metric "requestcount" configured
metric "requestduration" configured
metric "requestsize" configured
metric "responsesize" configured
metric "tcpbytesent" configured
metric "tcpbytereceived" configured
prometheus "handler" configured
rule "promhttp" configured
rule "promtcp" configured
kubernetesenv "handler" configured
rule "kubeattrgenrulerule" configured
rule "tcpkubeattrgenrulerule" configured
kubernetes "attributes" configured
destinationrule "istio-policy" configured
destinationrule "istio-telemetry" configured
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRole
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for rbac.authorization.k8s.io/, Kind=ClusterRoleBinding
unable to recognize "install/kubernetes/istio-demo-auth.yaml": no matches for admissionregistration.k8s.io/, Kind=MutatingWebhookConfiguration
```



Additional:

## Uninstalling 

```

@node-e1:~$ sudo docker container run --rm -it --name ucp   -v /var/run/docker.sock:/var/run/docker.sock   docker/ucp:
3.0.5 uninstall-ucp  --id b92spaikb3jc6u6lt3yfwxtpk
INFO[0000] Your engine version 17.06.2-ee-16, build 9ef4f0a (4.15.0-1021-gcp) is compatible with UCP 3.0.5 (f588f8a) 
INFO[0000] Uninstalling UCP on each node...             
INFO[0020] UCP has been removed from this cluster successfully. 
INFO[0022] Removing UCP Services   

```

## Troubleshooting

In case you get the below error message

```
kubectl version
Client Version: version.Info{Major:"1", Minor:"8", GitVersion:"v1.8.11", GitCommit:"1df6a8381669a6c753f79cb31ca2e3d57ee7c8a3", GitTreeState:"clean", BuildDate:"2018-04-05T17:24:
03Z", GoVersion:"go1.8.3", Compiler:"gc", Platform:"linux/amd64"}
The connection to the server localhost:8080 was refused - did you specify the right host or port?
```


```
openusm@master01:~/test/docker101/docker-ee/ubuntu$ eval "$(<env.sh)"
Cluster "ucp_10.140.0.2:6443_collabnix" set.
User "ucp_10.140.0.2:6443_collabnix" set.
Context "ucp_10.140.0.2:6443_collabnix" created.
```
