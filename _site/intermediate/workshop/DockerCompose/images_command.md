# Lab #8: images Command
The `docker-compose images` command help to listout images used/created by the containers. 

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
- Create a docker-compose.yml with custom image
- Build container and network
- Bringup the containers
- List out the images used by the containers

### Create a docker-compose.yml with custom image

#### Setup environment
```
$ mkdir -p docker-compose/build
$ cd docker-compose/build
```

#### Now lets create the Dockerfile
```
FROM nginx:alpine
RUN echo "Welcome to Docker Workshop!" >/usr/share/nginx/html/index.html
CMD ["nginx", "-g", "daemon off;"]
```

#### Create a docker-compose.yml file
```
version: "3.7"
services:
  webserver:
    build:
      context: .
      dockerfile: Dockerfile
    image: webapp:v1
    container_name: Nginx
    ports:
      - "80:80"
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
NOTE: This will build the images and bringup the containers. <b>-d</b> option which will run the container in background.

### List out the images used by the containers
```
$  docker-compose images
Container   Repository   Tag     Image Id      Size  
-----------------------------------------------------
Mysqldb     mysql        5.7   383867b75fd2   356 MB 
Nginx       webapp       v1    3454fa918c0d   20.2 MB
```
mysql is the one used for dbserver and <b>webapp:v1</b> is the custome image used for webserver.

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

Next » [Lab #9: ps Command](http://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/ps_command.html)
