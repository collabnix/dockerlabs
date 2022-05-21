# Lab #22: Down Command
The `docker-compose down` command helps to Stop and remove containers, networks, images, and volumes.

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
- Stop and remove containers, networks 

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

### Stop and remove containers, networks 
```
$ docker-compose down 
Stopping Mysqldb ... done
Stopping Nginx   ... done
Removing Mysqldb ... done
Removing Nginx   ... done
Removing network root_default 
```

#### Down and remove images
```
$ docker-compose down --rmi <all|local> 
```
'all': Remove all images used by any service. <br>
'local': Remove only images that don't have a custom tag set by the `image` field.
 
#### Down and remove volumes
```
$ docker-compose down --volumes 
```

#### Stop and remove containers, networks + Remove volumes,images 
```
$ docker-compose down --volume --rmi all
Stopping Mysqldb ... done
Stopping Nginx   ... done
Removing Mysqldb ... done
Removing Nginx   ... done
Removing network root_default
Removing volume root_db_data
Removing image nginx:alpine
Removing image mysql:5.7
```

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)
