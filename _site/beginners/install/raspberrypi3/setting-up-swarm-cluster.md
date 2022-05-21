# How to setup Docker Swarm Cluster on Raspberry Pi

Let us setup 2 node Swarm Mode Cluster.

System #1 - pi-node1 - 192.168.1.5<br>
System #2 - pi-node2 - 192.168.1.6


Login to pi-node1 and run the below command:

```
root@raspberrypi:~# docker version
Client:
 Version:           18.09.0
 API version:       1.39
 Go version:        go1.10.4
 Git commit:        4d60db4
 Built:             Wed Nov  7 00:57:21 2018
 OS/Arch:           linux/arm
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.0
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.4
  Git commit:       4d60db4
  Built:            Wed Nov  7 00:17:57 2018
  OS/Arch:          linux/arm
  Experimental:     false
root@raspberrypi:~# hostname pi_1
hostname: the specified hostname is invalid
root@raspberrypi:~# hostname pi-node1
root@raspberrypi:~# hostname
pi-node1
root@raspberrypi:~#
```

# Login to Node #2

```
root@raspberrypi:~# hostname pi-node2
root@raspberrypi:~# hostname
pi-node2
```

```
root@pi-node1:~# docker swarm init --advertise-addr 192.168.1.5 --listen-addr 192.168.1.5:2377
Swarm initialized: current node (txgq79grb6vjo5f78t15le1h8) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-02b4wgqx5jhp5wi12tbi1uij9mmiw95zuotvesqiag05ll6ci7-eukh6uqgy34adpn00cnd5c3wx 192.168.1.5:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

root@pi-node1:~#
```

```
root@pi-node1:~# docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
txgq79grb6vjo5f78t15le1h8 *   pi-node1            Ready               Active              Leader              18.09.0
root@pi-node1:~#
```

## Adding Pi-node2 to the cluster

```
root@raspberrypi:~# docker swarm join --token SWMTKN-1-02b4wgqx5jhp5wi12tbi1uij9mmiw95zuotvesqiag05ll6ci7-eukh6uqgy34adpn00cnd5c3wx 192.168.1.5:2377
This node joined a swarm as a worker.
```

## Listing the nodes

```
root@pi-node1:~# docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
txgq79grb6vjo5f78t15le1h8 *   pi-node1            Ready               Active              Leader              18.09.0
y2kylnx06m8h4n3pqq7tygbbd     pi-node2            Ready               Active                                  18.09.0
root@pi-node1:~#
```

```
root@pi-node1:~# docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
ed12cf66b701        bridge              bridge              local
21bc3f74bd1c        docker_gwbridge     bridge              local
0cef1c828c54        host                host                local
3o1rh4n8ivx6        ingress             overlay             swarm
3d18d5709a05        none                null                local
root@pi-node1:~#
```


## Running Swarm Visualizer on Raspberry Pi

```
root@pi-node1:/home/pi# docker service create \
   --name=vizualizer \
   --publish=8080:8080/tcp \
   --constraint=node.role==manager \
   --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
   ajeetraina/swarm-visualizer-armv7
x9s1oq0bc2g8yqjs4u7zfejr7
overall progress: 1 out of 1 tasks
1/1: running   [==================================================>]
verify: Service converged
root@pi-node1:/home/pi#

```

## Running Portainer 



```
$curl -L https://downloads.portainer.io/portainer-agent-stack.yml -o portainer-agent-stack.yml
$ docker stack deploy --compose-file=portainer-agent-stack.yml portainer
```

That's it . Browse to http://IP:9000 to see portainer.(admin/Oracle9ias)

[Next >> Setting up K3s Cluster](https://github.com/collabnix/dockerlabs/blob/master/beginners/install/raspberrypi3/setting-up-k3s-cluster.md)











