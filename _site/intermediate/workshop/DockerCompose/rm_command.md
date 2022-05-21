# Lab #21: Rm Command
The `docker-compose rm` command helps to Remove stopped containers.

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
- Bringup the containers
- Stop the container of a single service
- Removing container of stopped service
- Stopping and Removing container of a service

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

### Bringup the containers
```
$ docker-compose up -d
```

### Checking container status
```
$  docker-compose ps
 Name               Command             State                    Ports                  
----------------------------------------------------------------------------------------
Mysqldb   docker-entrypoint.sh mysqld   Up      0.0.0.0:3306->3306/tcp, 33060/tcp       
Nginx     nginx -g daemon off;          Up      0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp
```

### Listout the services
```
$  docker-compose ps --services
webserver
dbserver
```

### Stop the container of a single service
```
$  docker-compose stop webserver
Stopping Nginx ... done
```
#### Checking container status
```
$  docker-compose ps
 Name               Command             State                  Ports              
----------------------------------------------------------------------------------
Mysqldb   docker-entrypoint.sh mysqld   Up       0.0.0.0:3306->3306/tcp, 33060/tcp
Nginx     nginx -g daemon off;          Exit 0                               
```

### Removing container of stopped service
```
$ docker-compose rm
Going to remove Nginx
Are you sure? [yN] y
Removing Nginx ... done
```
We can use <b>-f</b>, <b>--force</b> to skip asing confirmation to remove container.

#### Checking container status
```
$ docker-compose ps
 Name               Command             State                 Ports              
---------------------------------------------------------------------------------
Mysqldb   docker-entrypoint.sh mysqld   Up      0.0.0.0:3306->3306/tcp, 33060/tcp
```
### Stopping and Removing container of a service
```
$  docker-compose rm -fs dbserver
Stopping Mysqldb ... done
Going to remove Mysqldb
Removing Mysqldb ... done
```

NOTE: By default, anonymous volumes attached to containers are not removed. You can override this with -v.

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

Next >> [Lab #22: Down Command](http://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/down_command.html)
