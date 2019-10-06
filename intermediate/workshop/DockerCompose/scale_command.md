# Lab #18: Scale Command
The `docker-compose scale <service name> = <no of instances>` sets the number of containers to run for a service.

<b>NOTE:</b>The `scale` command is deprecated, instead Use the up command with the --scale flag.<br>
`docker-compose up --scale <service name> = <no of instances>`

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
- Bringing up the containers
- Listout the services
- Scale service

### Create a docker-compose.yml file
```
version: '3.1'
services:
   redis-master:
     image: redis:latest 
     container_name: webserver
     restart: unless-stopped
     ports:
       - "6379"
   redis-slave: 
     image: gcr.io/google_samples/gb-redisslave:v1 
     ports: 
       - "6379"
     environment: 
       - GET_HOSTS_FROM=dns
   frontend: 
     image: gcr.io/google-samples/gb-frontend:v3 
     ports: 
       - "80:80" 
     environment: 
       - GET_HOSTS_FROM=dns
```

### Bringing up the containers
```
$ docker-compose up -d
```

#### Checking container status
```
$ docker-compose ps
       Name                     Command               State            Ports         
-------------------------------------------------------------------------------------
root_frontend_1      apache2-foreground               Up      0.0.0.0:80->80/tcp     
root_redis-slave_1   /entrypoint.sh /bin/sh -c  ...   Up      0.0.0.0:32769->6379/tcp
webserver            docker-entrypoint.sh redis ...   Up      0.0.0.0:32768->6379/tcp  
```

### Listout the services
```
$ docker-compose ps --services
redis-slave
frontend
redis-master
```

### Scale service 
```
$ocker-compose scale redis-slave=3
Starting root_redis-slave_1 ... done
Creating root_redis-slave_2 ... done
Creating root_redis-slave_3 ... done
```
#### Checking container status
```
$ docker-compose ps
       Name                     Command                State              Ports         
----------------------------------------------------------------------------------------
root_frontend_1      apache2-foreground               Up         0.0.0.0:80->80/tcp                      
root_redis-slave_1   /entrypoint.sh /bin/sh -c  ...   Up         0.0.0.0:32772->6379/tcp
root_redis-slave_2   /entrypoint.sh /bin/sh -c  ...   Up         0.0.0.0:32775->6379/tcp
root_redis-slave_3   /entrypoint.sh /bin/sh -c  ...   Up         0.0.0.0:32776->6379/tcp
webserver            docker-entrypoint.sh redis ...   Up         0.0.0.0:32768->6379/tcp
```
<b>NOTE:</b> Host machine can only bind an unallocated port to the container, so trying scale service which is mounted to host will fail.

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

Next >> [Lab #19: Exec Command](http://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/Lab_%234:Exec_Command.html)
