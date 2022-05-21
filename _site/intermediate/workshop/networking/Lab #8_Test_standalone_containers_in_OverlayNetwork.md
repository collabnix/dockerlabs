# Lab #8: Test standalone containers in Overlay Network
The overlay network driver creates a distributed network among multiple Docker daemon hosts and which are used commonly in docker swarm.
In this lab we are going to attach containers in Overlay network make them to communicate with container in another host.

## Pre-requisite:

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Play with Docker</b></td>
    <td class="tg-yw4l"><b>2</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side
## Bring up a swarm mode cluster

### Try to attach a container on default docker overlay(ingress) network 
```
$ docker container run --network=ingress -d nginx:alpine
docker: Error response from daemon: Could not attach to network ingress: rpc error: code = PermissionDenied desc = network ingress not manually attachable.
```
We failed to attach, since by default attachable flag is disabled.<br>
To create an overlay network which can be used by swarm services or standalone containers to communicate with other standalone containers running on other Docker daemons, we should add the <b>--attachable</b> flag while creating an overlay network.

### Create an attachable overlay network
```
$ docker network create --driver overlay --attachable myOverlay
```
### Launch a container on Manager node with network myOverlay
```
$ docker container run --network=myOverlay --name=manager-host -d nginx:alpine
```
### Launch a container on Worker node with network myOverlay
```
$ docker container run --network=myOverlay --name=worker-host -d httpd:alpine
```
### Testing able to communicate (From worker Node)
```
$ docker exec -it worker-host sh -c "wget manager-host; cat index.html
```
We will be getting nginx default home page, which the container running on master node.

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)
