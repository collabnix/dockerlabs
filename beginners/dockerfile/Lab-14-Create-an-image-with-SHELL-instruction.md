# Lab #14: Create an image with SHELL instruction

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



1- Install Docker latest version.<br>

2- Create a directory for the Dockerfile. <br>

3- Go to the path. <br>

4- Create the Dockerfile with instruction. <br>
```
vi Dockerfile
FROM alpine:3.4

RUN apk update && \
    apk add curl && \
    apk add vim && \
    apk add git
```

5- Build the Docker Image for Dockerfile from Shell with <br>
```
#docker build  -t image_name .
```
if you want to remove intermediate containers then use;
```
#docker build --force-rm  -t image_name .
```
if you want to build without existing cache then;
```
#docker build  --no-cache -t image_name .
```
here in above commands '.' represents the current directory where Dockerfile kept. If you want to build the Image from remote or different directory then paste the path of dockerfile <br>

If the name of the Dockerfile is different than 'Dockerfile' then need to give file name in command line as ```-f Dockerfile_name```
