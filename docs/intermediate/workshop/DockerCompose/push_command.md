# Lab #6: push Command
The `docker-compose push` command help you tou push the service images to Docker Hub or your own private Docker registry.

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
- Dockerfile for custom docker image
- Create a docker-compose.yml file
- Build the image using docker-compose
- Upload the image to Docker registry

### Dockerfile for custom docker image
$ mkdir -p dockerlabs/{nginx,httpd} ; cd dockerlabs

Dockerfile_nginx
```
$ echo 'FROM nginx:alpine
RUN echo "nginx - Welcome to Docker Workshop!" >/usr/share/nginx/html/index.html
CMD ["nginx", "-g", "daemon off;"] ' > nginx/Dockerfile_nginx
```
Dockerfile_httpd
```
$ echo 'FROM httpd:alpine
RUN echo "httpd - Welcome to Docker Workshop!" > /usr/local/apache2/htdocs/index.html
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"] ' > httpd/Dockerfile_httpd
```

### Create a docker-compose.yml file
docker-compose.yml
```
version: "3.7"
services:
  customNginx:
    build:
      context: .
      dockerfile: nginx/Dockerfile_nginx
    image: saviovettoor/custom_nginx_dockerlabs:v1
  customHttpd:
    build:
      context: .
      dockerfile: httpd/Dockerfile_httpd
    image: saviovettoor/custom_httpd_dockerlabs:v1
```
<b>NOTE:</b> Make sure that image name should be `<USER_NAME> / <REPOSITORY>`.

### Build the image using docker-compose
```
$ docker-compose build
```
#### Check the image have created
```
$ docker image ls
REPOSITORY                             TAG                 IMAGE ID            CREATED             SIZE
saviovettoor/custom_nginx_dockerlabs   v1                  3098d9cb3971        3 minutes ago       21.2MB
saviovettoor/custom_httpd_dockerlabs   v1                  866e070c373a        3 minutes ago       127MB
```

### Upload the image to Docker registry
<b>NOTE:</b> before tryng to push the image log in to hub.<br>
$ docker login -u <USER_NAME>
```
$ docker-compose push
```

#### Upload a single service image
```
$ docker-compose push customNginx
Pushing customNginx (saviovettoor/custom_nginx_dockerlabs:v1)...
The push refers to repository [docker.io/saviovettoor/custom_nginx_dockerlabs]
e4f534d7f270: Pushed
3e76d2df1790: Mounted from library/nginx
03901b4a2ea8: Mounted from library/nginx
v1: digest: sha256:aa83133b840728922ad95133ff17ed95fed7d3fb89e9919925a874cf848cd282 size: 946
```

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

Next » [Lab #7: up Command](http://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/up_command.html)
