# Setting up Persistent Storage for Docker Swarm using Rexray on Google CLoud Platform

## Pre-requisite

- Google Cloud Platform
- 3-Node Docker Swarm Cluster(1 Manager + 2 Worker Nodes)
- Enable Full Access to All Cloud API

## Ensure that you have 3-Node Docker Swarm Cluster

```
docker node ls
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

