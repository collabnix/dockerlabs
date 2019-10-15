# Lab #19: Exec Command
In this lab we are going to look into <b>docker-compose exec</b> command. Docker <b>exec</b> is used to run commands in a running container, similarly <b>docker-compose exec</b> runs commands in your services.

## Command instructions
#### Exec
```
docker-compose exec [options] [-e key=val...] service command [args...]
```
Run commands in your services.
Commands are by default allocating a TTY.

Options include:<br/>
`-T` disables pseudo-tty allocation.<br/>
`--index=index` specifies container when there are multiple instances of a service


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


#### Setup enviroment
```
$ mkdir app
$ cd app
```
#### Create a docker-compose.yml file
```
version: '3.1'
services:
  #Webservers
   webserver:
     image: nginx:alpine
     restart: unless-stopped
     expose:
       - "80"
       - "443"
  #Load Balancer
   loadbalancer:
     image: nginx:alpine
     volumes:
       - ./nginx.conf:/etc/nginx/nginx.conf:ro
     depends_on:
       - webserver
     ports:
       - "80:4000"

```


#### Create a nginx.conf file
```
user  nginx;
events {
    worker_connections   1024;
}
http {
        server {
              listen 4000;
              location / {
                proxy_pass http://webserver:80;
              }
        }
}
```
<b>Note:</b> This file will configure our load balancer.
#### Create the compose containers
```
$ docker-compose up -d --scale webserver=3
```
#### View the containers
```
$ docker-compose ps
```
#### Execute commands in different webservers
```
$ docker-compose exec --index=1 webserver  sh -c "echo 'Welcome to webserver1' > /usr/share/nginx/html/index.html"
$ docker-compose exec --index=2 webserver  sh -c "echo 'This is webserver2' > /usr/share/nginx/html/index.html"
$ docker-compose exec --index=3 webserver  sh -c "echo 'Webserver3 is up' > /usr/share/nginx/html/index.html"
```
#### Verify changes
```
$ curl http://localhost
```
<b>Note:</b> In order to verify all changes we'll have to use the curl command multiple times.

## Contributor
[Om Anand](https://www.linkedin.com/in/om-anand/)<br>
[]()

[Lab #20: Kill Command](http://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/Lab_%237:Kill_Command.html)<br>
