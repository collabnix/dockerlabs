# Demonstrating Build Time Variable in Dockerfile using ARG

Docker allows you to set both build time and run time ENV variables and even lets you overwrite build time ENV vars at run time.
There may come a time where you’ll want to add an ENV variable to your Docker image, but you’ll want this value to be different depending on where you build your image, but you don’t want to edit your Dockerfile to change it.You may also want to sometimes overwrite that value at run time (not build time).

The ARG instruction defines a variable that users can pass at build-time to the builder with the docker build command using the --build-arg <varname>=<value> flag. 


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


## Create a Dockerfile

Setting up a Docker image with a build argument and ENV variable:

```
$ cat Dockerfile
FROM ubuntu:latest
ARG version
ENV version $version

```

## Building Docker Image

```
$[node1] (local) root@192.168.0.23 ~
$ docker build -t ajeetraina:v1 --build-arg version=`uname -r` .

```

## Verifying the environmental variable

```
[node1] (local) root@192.168.0.23 ~
$ docker run ajeetraina:v1 env
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=b7de0a2c76f5
version=4.4.0-139-generic
HOME=/root
```
