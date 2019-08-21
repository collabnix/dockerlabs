# Lab #1: Build Command
In this lab we are going to look into <b>docker-compose build</b> command.Docker build used to create a new image using the instructions in the Dockerfile. The <b>build</b> can be specified either as a string containing a path to the build context. The newly built image will be used to create the container for the service.

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

We are going to build an nginx image with custome page 

#### Setup environment:
```
$ mkdir docker-compose/build
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
  webapp:
    build:
      context: .
      dockerfile: Dockerfile
    image: webapp:v1
```
<b>context:</b> To specify the build context directory that is sent to the Docker daemon.<br>
<b>dockerfile:</b> use to specify Alternate Dockerfile or path to Dockerfile.
#### Build the image using docker-compose
```
$ docker-compose build
```
Since we specified <b>image:</b> as well as <b>build:</b>, then the Compose built the image with name <b>webapp</b> and tag <b>v1</b>.<br>
If we didnt specify the <b>image:</b> option the image name will be <b>buid_<service_name>:latest</b>.

#### Check the image have created
```
$ docker image ls webapp:v1
```

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)
