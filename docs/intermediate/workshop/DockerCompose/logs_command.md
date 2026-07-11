# Lab #15: Logs Command
The `docker-compose logs` command help to see the service logs.

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
- Checking Service logs
- Follow log output
- Checking last two line logs

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

### Bringing up the containers
```
$ docker-compose up -d
```

#### Checking container status
  ```
$ docker-compose ps
 Name               Command             State                    Ports                  
----------------------------------------------------------------------------------------
Mysqldb   docker-entrypoint.sh mysqld   Up      0.0.0.0:3306->3306/tcp, 33060/tcp       
Nginx     nginx -g daemon off;          Up      0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp   
```

### Checking Service logs
```
$ docker-compose logs
Attaching to Mysqldb, Nginx
Mysqldb      | Initializing database
Mysqldb      | 2019-10-04T08:45:43.926007Z 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
Mysqldb      | 2019-10-04T08:45:44.832102Z 0 [Warning] InnoDB: New log files created, LSN=45790
Mysqldb      | 2019-10-04T08:45:44.942095Z 0 [Warning] InnoDB: Creating foreign key constraint system tables.
Mysqldb      | 2019-10-04T08:45:45.017777Z 0 [Warning] No existing UUID has been found, so we assume that this is the first time that this server has been started. Generating a new UUID: 5acfb862-e683-11e9-bee0-0242ac130003.
```

### Follow log output
Access the nginx while check the logs, to see live logs.
```
$ docker-compose logs -f webserver
Attaching to Nginx
Nginx        | 172.18.0.1 - - [04/Oct/2019:08:48:42 +0000] "GET / HTTP/1.1" 200 612 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36" "-"
```

### Checking last two line logs for a service
```
$ docker-compose logs  --tail="2"  webserver
Attaching to Nginx
Nginx        | 2019/10/04 08:48:43 [error] 7#7: *1 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 172.18.0.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "ip172-18-0-46-bmbfiuol9uvg00c4s2s0-80.direct.labs.play-with-docker.com", referrer: "http://ip172-18-0-46-bmbfiuol9uvg00c4s2s0-80.direct.labs.play-with-docker.com/"
Nginx        | 172.18.0.1 - - [04/Oct/2019:08:48:43 +0000] "GET /favicon.ico HTTP/1.1" 404 555 "http://ip172-18-0-46-bmbfiuol9uvg00c4s2s0-80.direct.labs.play-with-docker.com/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36" "-"
```

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

Next >> [Lab #16: Port Command](http://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/port_command.html)
