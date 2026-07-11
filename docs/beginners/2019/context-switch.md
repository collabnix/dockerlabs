# Context Switching Made Simple for Swarm & Kubernetes under Docker 19.03.0 Beta1

## Tested Infrastructure:

- A Node with Docker 19.03.0 Beta1 installed on Ubuntu 18.10
- 2 Docker Swarm Node Cluster(swarm-node1 and swarm-node2) setup on installed on Ubuntu 18.10
- Create 3 Node Kubernetes Cluster using GKE


## Installing a Node with Docker 19.03.0 Beta 1 Test Build on Ubuntu 18.10


## Method:I

## How to install latest Docker 19.03.0 Beta 1 Test Build?

Downloading the static binary archive.
Go to https://download.docker.com/linux/static/stable/ (or change stable to nightly or test), choose your hardware platform, and download the .tgz file relating to the version of Docker CE you want to install.

```
Captain'sBay==>wget https://download.docker.com/linux/static/test/x86_64/docker-19.03.0-beta1.tgz
--2019-04-10 09:20:01--  https://download.docker.com/linux/static/test/x86_64/docker-19.03.0-beta1.tgz
Resolving download.docker.com (download.docker.com)... 54.230.75.15, 54.230.75.117, 54.230.75.202, ...
Connecting to download.docker.com (download.docker.com)|54.230.75.15|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 62701372 (60M) [application/x-tar]
Saving to: ‘docker-19.03.0-beta1.tgz’
docker-19.03.0-beta1.tgz  100%[=====================================>]  59.80M  10.7MB/s    in 7.1s    
2019-04-10 09:20:09 (8.38 MB/s) - ‘docker-19.03.0-beta1.tgz’ saved [62701372/62701372]
Extract the archive
You can use the tar utility. The dockerd and docker binaries are extracted.
```

```
Captain'sBay==>tar xzvf docker-19.03.0-beta1.tgz 
docker/
docker/ctr
docker/containerd-shim
docker/dockerd
docker/docker-proxy
docker/runc
docker/containerd
docker/docker-init
docker/docker
Captain'sBay==>
```

Move the binaries to a directory on your executable path
It could be such as /usr/bin/. If you skip this step, you must provide the path to the executable when you invoke docker or dockerd commands.

```
Captain'sBay==>sudo cp -rf docker/* /usr/local/bin/
```

## Start the Docker daemon:

```
$ sudo dockerd &
Client: Docker Engine - Community
 Version:           19.03.0-beta1
 API version:       1.40
 Go version:        go1.12.1
 Git commit:        62240a9
 Built:             Thu Apr  4 19:15:07 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.0-beta1
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.1
  Git commit:       62240a9
  Built:            Thu Apr  4 19:22:34 2019
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          v1.2.5
  GitCommit:        bb71b10fd8f58240ca47fbb579b9d1028eea7c84
 runc:
  Version:          1.0.0-rc6+dev
  GitCommit:        2b18fe1d885ee5083ef9f0838fee39b62d653e30
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
Captain'sBay==>
```

## Testing with hello-world

```
Captain'sBay==>sudo docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
1b930d010525: Pull complete 
Digest: sha256:2557e3c07ed1e38f26e389462d03ed943586f744621577a99efb77324b0fe535
Status: Downloaded newer image for hello-world:latest
INFO[2019-04-10T09:26:23.338596029Z] shim containerd-shim started                  address="/containerd-shim/m
oby/5b23a7045ca683d888c9d1026451af743b7bf4005c6b8dd92b9e95e125e68134/shim.sock" debug=false pid=2953
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
## Verifying the new `docker context` command
```

## Method:II

```

root@DebianBuster:~# curl https://get.docker.com | CHANNEL=test sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 13063  100 13063    0     0   2305      0  0:00:05  0:00:05 --:--:--  2971
# Executing docker install script, commit: 2f4ae48
+ sh -c apt-get update -qq >/dev/null
+ sh -c apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
+ sh -c curl -fsSL "https://download.docker.com/linux/debian/gpg" | apt-key add -qq - >/dev/null
Warning: apt-key output should not be parsed (stdout is not a terminal)
+ sh -c echo "deb [arch=amd64] https://download.docker.com/linux/debian buster test" > /etc/apt/sources.list.d/docker.list
+ sh -c apt-get update -qq >/dev/null
+ [ -n  ]
+ sh -c apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
+ sh -c docker version
Client:
 Version:           19.03.0-beta1
 API version:       1.40
 Go version:        go1.11.5
 Git commit:        62240a9
 Built:             Thu Apr  4 19:18:53 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server:
 Engine:
  Version:          19.03.0-beta1
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.11.5
  Git commit:       62240a9
  Built:            Thu Apr  4 19:17:35 2019
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.5
  GitCommit:        bb71b10fd8f58240ca47fbb579b9d1028eea7c84
 runc:
  Version:          1.0.0-rc6+dev
  GitCommit:        2b18fe1d885ee5083ef9f0838fee39b62d653e30
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
If you would like to use Docker as a non-root user, you should now consider
adding your user to the "docker" group with something like:

  sudo usermod -aG docker your-user

Remember that you will have to log out and back in for this to take effect!

WARNING: Adding a user to the "docker" group will grant the ability to run
         containers which can be used to obtain root privileges on the
         docker host.
         Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
         for more information.
root@DebianBuster:~#

```

## Verifying Docker version

```
root@DebianBuster:~# docker version
Client:
 Version:           19.03.0-beta1
 API version:       1.40
 Go version:        go1.11.5
 Git commit:        62240a9
 Built:             Thu Apr  4 19:18:53 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server:
 Engine:
  Version:          19.03.0-beta1
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.11.5
  Git commit:       62240a9
  Built:            Thu Apr  4 19:17:35 2019
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.5
  GitCommit:        bb71b10fd8f58240ca47fbb579b9d1028eea7c84
 runc:
  Version:          1.0.0-rc6+dev
  GitCommit:        2b18fe1d885ee5083ef9f0838fee39b62d653e30
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
root@DebianBuster:~#
```

## Verifying ```docker context```
```
$ sudo docker context --help
Usage:  docker context COMMAND
Manage contexts
Commands:
  create      Create a context
  export      Export a context to a tar or kubeconfig file
  import      Import a context from a tar file
  inspect     Display detailed information on one or more contexts
  ls          List contexts
  rm          Remove one or more contexts
  update      Update a context
  use         Set the current docker context
Run 'docker context COMMAND --help' for more information on a command.
```

## Creating a 2 Node Swarm Cluster

Install Docker 19.03.0 Beta 1 on both the nodes. 

## Configuring remote access with systemd unit file

Use the command sudo systemctl edit docker.service to open an override file for docker.service in a text editor.

Add or modify the following lines, substituting your own values.

```
Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock -H tcp://10.140.0.6:2375
```


Save the file.

Reload the systemctl configuration.

 $ sudo systemctl daemon-reload
Restart Docker.

$ sudo systemctl restart docker.service

Repeat it for other swarm node too.

```
swarm-node-1:~$ sudo docker swarm init --advertise-addr 10.140.0.6 --listen-addr 10.140.0
.6:2377
Swarm initialized: current node (c78wm1g99q1a1g2sxiuawqyps) is now a manager.
To add a worker to this swarm, run the following command:
    docker swarm join --token SWMTKN-1-1bc88158q1v4b4gdof8k0u532bxzdvrgxfztwgj2r443337mja-cmhuu258lu0327
e32l0g4pl47 10.140.0.6:2377
To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

## Run the below command on worker node:

```
swarm-node2:~$ sudo docker swarm join --token SWMTKN-1-1bc88158q1v4b4gdof8k0u532bxzdvrgxf
ztwgj2r443337mja-cmhuu258lu0327e32l0g4pl47 10.140.0.6:2377
This node joined a swarm as a worker.
```

## Listing the Swarm Mode CLuster

```
root@swarm-node-1:~# docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
0v5r9xmpbxzqpy72u41ihfck0     swarm-node2         Ready               Active                                  19.03.0-beta1
xwmay5i48xxbzlp7is7a3uord *   swarm-node-1        Ready               Active              Leader              19.03.0-beta1
 ```
 
 # Switching the Context
 
 ## Listing the Context
 
 ```
 node-1:~$ sudo docker context ls
NAME                DESCRIPTION                               DOCKER ENDPOINT               KUBERNETES E
NDPOINT   ORCHESTRATOR
default *           Current DOCKER_HOST based configuration   unix:///var/run/docker.sock               
          swarm
 ```
 
 ## Adding the new Context
 
 ```
 docker context create --docker host=tcp://10.140.0.6:2375 swarm-context1
 ```
 
 ## Using the new context for Swarm
 
 ```
 docker context use swarm-context1
 ```
 
 ## Listing the Swarm Mode Cluster
 
 ```
  sudo docker context ls
NAME                DESCRIPTION                               DOCKER ENDPOINT               KUBERNETES E
NDPOINT   ORCHESTRATOR
default             Current DOCKER_HOST based configuration   unix:///var/run/docker.sock               
          swarm
swarm-context1 *                                              tcp://10.140.0.6:2375             
```

```
 sudo docker context ls --format '{{json .}}' | jq .
{
  "Current": true,
  "Description": "Current DOCKER_HOST based configuration",
  "DockerEndpoint": "unix:///var/run/docker.sock",
  "KubernetesEndpoint": "",
  "Name": "default",
  "StackOrchestrator": "swarm"
}
{
  "Current": false,
  "Description": "",
  "DockerEndpoint": "tcp://10.140.0.6:2375",
  "KubernetesEndpoint": "",
  "Name": "swarm-context1",
  "StackOrchestrator": ""
}
```

```          
$ sudo docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS
      ENGINE VERSION
xwmay5i48xxbzlp7is7a3uord *   swarm-node-1        Ready               Active              Leader        
      19.03.0-beta1
$ sudo docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
0v5r9xmpbxzqpy72u41ihfck0     swarm-node2         Ready               Active                                  19.03.0-beta1
xwmay5i48xxbzlp7is7a3uord *   swarm-node-1        Ready               Active              Leader              19.03.0-beta1
tanvirkour1985@sys1:~$ C
```

## Context Switching to PWD

```
[:)Captain'sBay=>sudo docker context ls
NAME                DESCRIPTION                               DOCKER ENDPOINT               KUBERNETES ENDPOINT                 ORCHESTRATOR
default *           Current DOCKER_HOST based configuration   unix:///var/run/docker.sock   https://127.0.0.1:16443 (default)   swarm
swarm-context1                                                tcp://10.140.0.6:2375                                             
```

Let us go ahead and add PWD context

```
[:)Captain'sBay=>sudo docker context create --docker host=tcp://ip172-18-0-5-biosq9o6chi000as1470.direct.labs.play-with-docker.com:2375 pwd-clu
ster1
pwd-cluster1
Successfully created context "pwd-cluster1"
```

```
[:)Captain'sBay=>sudo docker context ls
NAME                DESCRIPTION                               DOCKER ENDPOINT                                                                 K
UBERNETES ENDPOINT                 ORCHESTRATOR
default *           Current DOCKER_HOST based configuration   unix:///var/run/docker.sock                                                     h
ttps://127.0.0.1:16443 (default)   swarm
pwd-cluster1                                                  tcp://ip172-18-0-5-biosq9o6chi000as1470.direct.labs.play-with-docker.com:2375    
                                   
swarm-context1                                                tcp://10.140.0.6:2375                                                            
                                   
[:)Captain'sBay=>
```

```
[:)Captain'sBay=>sudo docker context use pwd-cluster1
pwd-cluster1
Current context is now "pwd-cluster1"
```

```
[:)Captain'sBay=>sudo docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
wnrz5fks5drzs9agkyl8z3ffi *   manager1            Ready               Active              Leader              18.09.4
dcweon0icoolfs3kirj0p3qgg     manager2            Ready               Active              Reachable           18.09.4
f78bkvfbzot2jkr2n6cen7240     manager3            Ready               Active              Reachable           18.09.4
xla6nb5ql5i6pkjruyxpc1hzk     worker1             Ready               Active                                  18.09.4
45nk1t94ympplgaasiryunwvk     worker2             Ready               Active                                  18.09.4
[:)Captain'sBay=>
```

Awesome ~
