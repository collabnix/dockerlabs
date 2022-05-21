# Lab #2: Create an Overlay network

In this lab we are going to create a user defined <b>Overlay network</b>.

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
- Create a swarm cluster 

#### Create an overlay network called myoverlay0
```
$ docker network create --driver=overlay --subnet=192.168.1.0/24 --gateway=192.168.1.100 myoverlay0
```
#### Listout the networks in the host
```
$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
7bbea9e2f1c4        bridge              bridge              local
99e0866a81c5        docker_gwbridge     bridge              local
180292624b34        host                host                local
pp47xrb8x4da        ingress             overlay             swarm
1o0u8kqharpe        myoverlay0          overlay             swarm
e7e3f13ebea6        none                null                local
```
#### View the details of network myoverlay0
```
$ docker network inspect myoverlay0
```
#### Create an encrypted overlay network
By default application data is not encrypted, to encrypt application data as well, we need to add <b>--opt encrypted</b> while creating Overlaynetwork.
```
$ docker network create -d overlay --opt encrypted encrypted_overlay
```

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)
