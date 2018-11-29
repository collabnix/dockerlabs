# Demonstrating Runtime Variable in DockerFile using ARG


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

[node1] (local) root@192.168.0.23 ~
$ docker run ajeetraina:v1 env
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=b7de0a2c76f5
version=4.4.0-139-generic
HOME=/root
```
