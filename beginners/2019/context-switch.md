# Context Switching Made Simple for Swarm & Kubernetes under Docker 19.03.0 Beta1

Test Infrastructure:

- A Node with Docker 19.03.0 Beta1 installed
- 2 Docker Swarm Node Cluster(swarm-node1 and swarm-node2)
- Create 2 Node Kubernetes Cluster(GKE Cluster)


## Installing a Node with Docker 19.03.0 Beta 1 Test Build 

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

## Verifying the new `docker context` command

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
tanvirkour1985@sys1:~$ sudo docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS
      ENGINE VERSION
xwmay5i48xxbzlp7is7a3uord *   swarm-node-1        Ready               Active              Leader        
      19.03.0-beta1
tanvirkour1985@sys1:~$ sudo docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
0v5r9xmpbxzqpy72u41ihfck0     swarm-node2         Ready               Active                                  19.03.0-beta1
xwmay5i48xxbzlp7is7a3uord *   swarm-node-1        Ready               Active              Leader              19.03.0-beta1
tanvirkour1985@sys1:~$ C
```



