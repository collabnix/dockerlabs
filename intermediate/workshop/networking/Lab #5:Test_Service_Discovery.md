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
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
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


## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)




