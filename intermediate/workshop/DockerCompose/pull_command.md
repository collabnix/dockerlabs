# Lab #5: pull Command
The `docker-compose pull` command pull down the images which is specified under each service of docker-compose file from the docker hub.

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

# Assignment
- Create a docker-compose.yml file
- Pull down the service images
- Pull down image of a single service


### Create a docker-compose.yml file
```
version: '3.1'
services:
  #Nginx Service
   webserver:
     image: nginx:alpine
     container_name: webserver
     restart: unless-stopped
     ports:
       - "80:80"
       - "443:443"
   dbserver:
     image: mysql:5.7
     container_name: Mysqldb
     restart: unless-stopped
     ports:
       - "3306:3306"
```

### Pull down the service images
```
$ docker-compose pull
Pulling webserver ... done
Pulling dbserver  ... done
```
#### Checking the images in local
```
$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
mysql               5.7                 383867b75fd2        2 hours ago         373MB
nginx               alpine              d87c83ec7a66        2 weeks ago         21.2MB
```

### Pull down image of a single service
Before doing pull make sure you have removed the images(docker image rm <Image_name/Image_ID>) which is already pulled.
```
$ docker-compose pull webserver
Pulling webserver ... done
```
This pulldown only the webserver service image(nginx:alpine).


## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

Next » [Lab #6: Push Command](http://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/push_command.html)
