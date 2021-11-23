# Lab #20: Kill Command


## Command instructions

#### Kill

Verify if the kill command kills all the container started by the docker-compose and verify if there is any running container after killing it.



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
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side



#### Initial setup
```
$ mkdir app
$ cd app
```

#### Create a docker-compose.yml file
```
version: '3.1'
services:
   webserver:
     image: nginx:alpine
     expose:
       - "80"
   loadbalancer:
     image: nginx:alpine
     volumes:
       - ./nginx.conf:/etc/nginx/nginx.conf:ro
     depends_on:
       - webserver
     ports:
       - "80:4000"
```

#### Create the compose containers
```
$ docker-compose up -d --scale webserver=3
```
#### View the containers
```
$ docker-compose ps
```

#### Kill all the containers
```
$ docker-compose kill
```
#### Check if there are any running containers
```
$ docker-compose ps
```

Next » [Lab #21: Rm Command](http://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/rm_command.html)
