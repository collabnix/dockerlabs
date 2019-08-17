## What is a Dockerfile?

- A Dockerfile is a text file which contains a series of commands or instructions. 
- These instructions are executed in the order in which they are written.
- Execution of these instructions takes place on a base image. 
- On building the Dockerfile, the successive actions form a new image from the base parent image.

We will go through each of instructions under Dockerfile and see how it is used.

[Lab #1: Create an image with GIT installed]()<br>
[Lab #2: Create an image with ADD instruction]()<br>
[Lab #3: Create an image with COPY instruction]()<br>
[Lab #4: Create an image with CMD instruction]()<br>
[Lab #5: Create an image with ENTRYPOINT instruction]()<br>
[Lab #6: Create an image with WORKDIR instruction]()<br>
[Lab #7: Create an image with RUN instruction]()<br>
[Lab #8: Create an image with EXPOSE instruction]()<br>
[Lab #9: Create an image with VOLUME instruction]()<br>
[Lab #10: Create an image with EXPOSE instruction]()<br>
[Lab #11: Create an image with LABEL instruction]()<br>
[Lab #12: Create an image with ONBUILD instruction]()<br>
[Lab #13: Create an image with HEALTHCHECK instruction]()<br>
[Lab #14: Create an image with SHELL instruction]()<br>
[Lab #15: Create an image with Python Script]()<br>

# Lab #1: Create an image with GIT installed

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


## Assignment:

- Create an image with GIT installed
- Tag your image as labs-git:v1.0
- Create a container based on that image, and run git --version to check that it is installed correctly

## Creating Dockerfile

```
FROM alpine:3.5
RUN apk update
RUN apk add git
```

## Build Docker Image

```
docker build -t ajeetraina/alpine-git .
```

## Tagging image as labs-git

```
docker tag ajeetraina/alpine-git ajeetraina/labs-git:v1.0
```

## Verify the Images


```
$ docker images
REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
ajeetraina/alpine-git   latest              cb913e37a593        16 seconds ago      26.6MB
ajeetraina/labs-git     v1.0                cb913e37a593        16 seconds ago      26.6MB
```


##  Create a container

```
docker run -itd ajeetraina/labs-git:v1.0 /bin/sh
```

```
$ docker ps
CONTAINER ID        IMAGE                      COMMAND             CREATED             STATUS              PORTS               NAMES
3e26a5268f55        ajeetraina/labs-git:v1.0   "/bin/sh"           4 seconds ago       Up 2 seconds                            elated_neumann
```

## Enter into Container Shell

```
docker attach 3e26
```

Please press "Enter" key twice so as to enter into container shell


## Verify if GIT is installed 

```
/ # git --version
git version 2.13.7
```

[Lab #2: Create an image with ADD instruction]()<br>


