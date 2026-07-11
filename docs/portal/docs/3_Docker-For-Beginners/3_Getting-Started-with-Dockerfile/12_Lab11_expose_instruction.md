# Lab #11: EXPOSE instruction

The `EXPOSE` instruction expose a port, the protocol can be UDP or TCP associated with the indicated port, default is TCP with no specification. The EXPOSE won't be able to map the ports on the host machine. Regardless of the EXPOSE settings, EXPOSE port can be override using <b>-p</b> flag while starting the container.

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
- Create an image with EXPOSE instruction
- Inspecting the EXPOSE port in the image
- Publish all exposed port

### Create an image with EXPOSE instruction
Dockerfile
```
FROM nginx:alpine
LABEL maintainer="Collabnix"

EXPOSE 80/tcp
EXPOSE 80/udp

CMD [ "nginx","-g","daemon off;" ]
```
#### Building Docker image
```
$ docker build -t expose:v1 .
```
#### Create a container based on expose:v1 image
```
$  docker container run --rm -d --name expose-inst expose:v1
```

### Inspecting the EXPOSE port in the image
```
$ docker image inspect --format={{.ContainerConfig.ExposedPorts}} expose:v1
```

### Publish all exposed ports
We can publish all EXPOSE port using <b>-P</b> flag. 
```
$ docker container run --rm -P -d --name expose-inst-Publish expose:v1
```
#### Checking the publish port
```
$  docker container ls
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                          NAMES
24983e09bd86        expose:v1           "nginx -g 'daemon of…"   46 seconds ago      Up 45 seconds       0.0.0.0:32768->80/tcp, 0.0.0.0:32768->80/udp   expose-inst-Publish
```

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

Next >> [Lab #12: LABEL instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/Label_instruction.html)
