# Lab #6: Test Routing Mesh

Docker swarm by default use ingress mode layer 4 routing mesh. The routing mesh enables each node in the swarm to accept connections on published ports for any service running in the swarm, even if there’s no task running on the node. You can bypass the routing mesh, using <b>host mode</b> when you create the service. Then you will able to access the service only from the node where task is running.

## Pre-requisite:

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b>Play with Docker</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add 

### Create a service in ingress mode
```
$ docker service create --name myWebApp --publish published=80,target=80,mode=ingress nginx:alpine
```
Checking Current PublishMode
```
$ docker service inspect --format "{{json .Endpoint.Ports}}" myWebApp

[{"Protocol":"tcp","TargetPort":80,"PublishedPort":80,"PublishMode":"ingress"}]
```


### Bypass the routing mesh by host Mode
```
$ docker service create --name bypassRM --publish published=8080,target=80,mode=host nginx:alpine
```
Checking Current PublishMode
```
$ docker service inspect --format "{{json .Endpoint.Ports}}" bypassRM

[{"Protocol":"tcp","TargetPort":80,"PublishedPort":8080,"PublishMode":"host"}
```

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)
