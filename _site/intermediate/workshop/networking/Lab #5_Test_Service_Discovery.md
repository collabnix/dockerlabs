# Lab #5: Test Service Discovery
Service Discovery which allows containers on the <b>same network</b> can access each other by name. Service Discovery is achive through Docker’s embedded DNS server(DNS IP 127.0.0.11). Embedded DNS server which provides built-in service discovery for any container created with a <b>valid name</b>(--name) or net-alias(--network-alias) or aliased by link. Service discovery which wont work on default networks.

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
    <td class="tg-yw4l"><b>2</b></td>
    <td class="tg-yw4l"><b>10 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add 

### Testing service discovery in default network
#### Running an nginx server 
```
$ docker container run -d --rm --name default_ntwrk nginx:alpine
```
#### Testing wehther able to resolve using service name
```
$ docker run --rm byrnedo/alpine-curl default_ntwrk
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0curl: (6) Could not resolve host: default_ntwrk
```
We are getting error that <b>Could not resolve host: default_ntwrk</b> 

#### Creating a bridge network
```
$ docker network create --driver=bridge --subnet=192.168.1.0/24 --gateway=192.168.1.250 my_bridge
```
#### Running an nginx server in user defined network
```
$ docker container run -d --rm --name usr_ntwrk --network my_bridge nginx:alpine
```
### Testing service discovery in User defined network
```
$ docker run --rm --network my_bridge byrnedo/alpine-curl usr_ntwrk
```
You will be getting nginx homepage on success.

### Testing service discovery in Swarm Mode

#### Creating an nginx service on default overlay(ingress)
```
$ docker service create --name myWeb --replicas 2 --publish 8080:80 nginx:alpine
```
#### Creating another Service myCentos
```
$ docker service create --replicas 2 --name myCentos centos sleep 1d
```
#### Getting container ID of Centos
```
$ docker container ls
```
#### Testing wehther able to resolve using service name from centos
```
$ docker exec -it <Container_ID> curl myWeb
```
You will be getting error <b>curl: (6) Could not resolve host: myWeb; Unknown error</b>

Lets remove the Services
```
$ docker service rm myWeb myCentos
```
#### Create a Overlay network
```
$ docker network create -d overlay --opt encrypted CustomOverlay
```
#### Create nginx service with CustomOverlay network
```
$ docker service create --name myWeb --replicas 2 --publish 8080:80 --network=CustomOverlay  nginx:alpine
```
#### Creating another Service myCentos with CustomOverlay network
```
docker service create --replicas 2 --name myCentos --network=CustomOverlay centos sleep 1d
```
#### Getting container ID of Centos
```
$ docker container ls
```
#### Testing wehther able to resolve using service name from centos
```
$ docker exec -it <Container_ID> curl myWeb
```
Now you will get response of nginx home page 


## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)
