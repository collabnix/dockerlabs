# Lab #3: Create a service

In this lab we will be looking to different option to connect service with user defined Overlay network. 

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
- Swarm cluster 

#### Create service on overlay network myoverlay0
```
$ docker service create --name testWeb -p 80:80 --network=myoverlay0 --replicas 3 httpd
```

#### Checking Network ID for the service 
```
$ docker service inspect --format={{.Endpoint.VirtualIPs}} testWeb
```
### Connect an existing service to an overlay network
#### Createing A new service with name testApp
```
$ docker service create --name testApp -p 8081:80 --replicas 3 nginx:alpine
```
#### Checking the current network for the service
```
$ docker service inspect --format={{.Endpoint.VirtualIPs}} testApp
```
#### Connecting service to userdefined network myoverlay0
```
$ docker service update --network-add myoverlay0 testApp
```
#### Checking the current network Endpoint for the service
```
$ docker service inspect --format={{.Endpoint.VirtualIPs}} testApp
```
#### Removing user defined network myoverlay0 for service testApp
```
$ docker service update --network-rm myoverlay0 testApp
```

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

