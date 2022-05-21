# Lab #12: Restart Command
The `docker-compose restart` command help us to restart the services.

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
- Create the container and network
- Restart the service
- Restart a single service

### Create a docker-compose.yml file
```
version: '3.7'
services:
  #Nginx Service
   webserver:
     image: nginx:alpine
     container_name: Nginx
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
     environment:
       MYSQL_ROOT_PASSWORD: Pa$$w0rd
       MYSQL_USER: test
       MYSQL_PASSWORD: Pa$$w0rd123
       MYSQL_DATABASE: test 
     volumes:
       - db_data:/var/lib/mysql
volumes:
  db_data:
```

### Create the container and network
```
$ docker-compose up --no-start

Creating network "root_default" with the default driver
Creating Mysqldb ... done
Creating Nginx   ... done
```

#### Checking container status
```
$ docker-compose ps
 Name               Command             State    Ports
------------------------------------------------------
Mysqldb   docker-entrypoint.sh mysqld   Exit 0        
Nginx     nginx -g daemon off;          Exit 0      
```

### Listout the services
```
$  docker-compose ps --services
webserver
dbserver
```

### Restart the service
```
$ docker-compose restart
Restarting Mysqldb ... done
Restarting Nginx   ... done
```
#### Checking container status
```
$ docker-compose ps
 Name               Command             State                    Ports                  
----------------------------------------------------------------------------------------
Mysqldb   docker-entrypoint.sh mysqld   Up      0.0.0.0:3306->3306/tcp, 33060/tcp       
Nginx     nginx -g daemon off;          Up      0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp                        
```

### Restart a single service
```
$ docker-compose restart webserver
Restarting Nginx ... done
```
### Set a time wait for stop before killing the container
```
$ docker-compose restart -t 30 webserver
```
 Specify a shutdown timeout (-t/--timeout) in seconds(default: 10)

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

Next >> [Lab #13: Pause Command](http://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/pause_command.html)
