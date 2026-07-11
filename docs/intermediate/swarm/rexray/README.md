# Setting up Persistent Storage for Docker Swarm using Rexray on Google CLoud Platform

## Pre-requisite

- Google Cloud Platform
- 3-Node Docker Swarm Cluster(1 Manager + 2 Worker Nodes)
- Enable Full Access to All Cloud API

## Ensure that you have 3-Node Docker Swarm Cluster

```
dockercaptain1981@node1:~$ sudo docker node ls
ID                            HOSTNAME            STATUS              AVAIL
ABILITY        MANAGER STATUS      ENGINE VERSION
u7f4lsnzjswaesc8gk6qo69m2 *   node1               Ready               Active              Leader              19.03.5
nhp0mnp2a0ciakxyzu9n6u0wz     node2               Ready               Active                                  19.03.5
u1xqjql3i9fvu9kvhfsy8c3kc     node3               Ready               Active                                  19.03.5
dockercaptain1981@node1:~$ 
```

## Ensure that Docker Compose is installed on the Manager Node

## Setting up Visualizer Tool

```
git clone https://github.com/collabnix/dockerlabs
cd dockerlabs/solution/viz
docker-compose up -d
```

Access Visualizer tool via http://<IP>:8080

## Installing RexRay Plugin

```
sudo docker plugin install --grant-all-permissions rexray/gcepd GCEPD_TAG=rexray

dockercaptain1981@node1:~/dockerlabs/solution/viz$ sudo docker plugin install --grant-all-permissions rexray/gcepd GCEPD_TAG=rexray
latest: Pulling from rexray/gcepd
fa408a4c04c6: Download complete 
Digest: sha256:d3f6a92d013abb9a66ec7d7d786bd66ce7b5f04c7ceeb2dac700b370582a
2a2f
Status: Downloaded newer image for rexray/gcepd:latest
Installed plugin rexray/gcepd
```

# Listing the RexRay Plugin


```
$ sudo docker plugin ls
ID                  NAME                  DESCRIPTION                      
  ENABLED
9d636b335dd0        rexray/gcepd:latest   REX-Ray for GCE Persistent Disks 
  true
dockercaptain1981@node1:~/dockerlabs/solution/viz$ 
```

# Creating Docker Volumes

```
dockercaptain1981@node1:~$ sudo docker volume create --driver rexray/gcepd 
--name storage1 --opt=size=32
storage1
dockercaptain1981@node1:~$ sudo docker volume create --driver rexray/gcepd 
--name storage2 --opt=size=32
storage2
dockercaptain1981@node1:~$ 
```

```
dockercaptain1981@node1:~$ sudo docker volume ls
DRIVER                VOLUME NAME
rexray/gcepd:latest   storage1
rexray/gcepd:latest   storage2
rexray/gcepd:latest   storage11
dockercaptain1981@node1:~$ 
```

We need to setup RexRay Plugin on all those nodes. It can be done manually or we have swarm-exec.sh script which can install RexRay in a single shot on all Swarm Nodes.

```
git clone https://github.com/mavenugo/swarm-exec
sudo ./swarm-exec.sh docker plugin install –grant-all-permissions rexray/gcepd GCEPD_TAG=rexray
```

OR 

You can run the below command on all the nodes

```
sudo docker plugin install --grant-all-permissions rexray/gcepd GCEPD_TAG=rexray
```

## Listing the Volumes on all the worker nodes 

```
dockercaptain1981@node3:~$ sudo docker volume ls
DRIVER                VOLUME NAME
rexray/gcepd:latest   storage1
rexray/gcepd:latest   storage2
dockercaptain1981@node3:~$ 
```

## Creating Collabnet Network

```
dockercaptain1981@node1:~/dockerlabs/solution/viz/swarm-exec$ sudo docker network create -d overlay collabnet
n017dxky7i44eoxdk6nweep7v
```


## Creating MySQL DB Service

```
dockercaptain1981@node1:~/dockerlabs/solution/viz/swarm-exec$ sudo docker service create --replicas 4 --name wordpressdb1 --network=collabnet --mount type=volume,source=storage1,target=/var/lib/mysql,volume-driver=rexray/gcepd -e MYSQL_ROOT_PASSWORD=collab123 --env MYSQL_DATABASE=wordpress mysql:5.7
wrdv3ci6so28vm9gv30szvsyu
overall progress: 0 out of 4 tasks 
1/4: preparing 
2/4: preparing 
3/4: preparing 
```

```
dockercaptain1981@node1:~/dockerlabs/solution/viz/swarm-exec$ sudo docker v
olume inspect storage1
[
    {
        "CreatedAt": "0001-01-01T00:00:00Z",
        "Driver": "rexray/gcepd:latest",
        "Labels": {},
        "Mountpoint": "",
        "Name": "storage1",
        "Options": {
            "size": "32"
        },
        "Scope": "global",
        "Status": {
            "availabilityZone": "asia-east1-b",
            "fields": null,
            "iops": 0,
            "name": "storage1",
            "server": "gcepd",
            "service": "gcepd",
            "size": 32,
            "type": "pd-ssd"
        }
    }
]
```
