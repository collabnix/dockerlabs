# Lab #7: RUN instruction

The `RUN` instruction execute command on top of the below layer and create a new layer. <br>
RUN instruction can be wrote in two forms:
- RUN <command> (shell form)
- RUN ["executable", "param1", "param2"] (exec form)

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

- Create an image with RUN instruction
- Combining multiple RUN instruction to one

### Create an image with RUN instruction
```
FROM alpine:3.9.3
LABEL maintainer="Collabnix"
RUN apk add --update 
RUN apk add curl
RUN rm -rf /var/cache/apk/
```
#### Building Docker image
```
$ docker image build -t run:v1 .
```
#### Checking layer of the image
```
$  docker image history run:v1 
IMAGE               CREATED             CREATED BY                                      SIZE                
NT
5b09d7ba1736        19 seconds ago      /bin/sh -c rm -rf /var/cache/apk/               0B                  
192115cc597a        21 seconds ago      /bin/sh -c apk add curl                         1.55MB              
0518580850f1        43 seconds ago      /bin/sh -c apk add --update                     1.33MB              
8590497d994e        45 seconds ago      /bin/sh -c #(nop)  LABEL maintainer=Collabnix   0B                  
cdf98d1859c1        4 months ago        /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B                  
<missing>           4 months ago        /bin/sh -c #(nop) ADD file:2e3a37883f56a4a27…   5.53MB 
```
Number of layers 6

#### Checking image size
```
$ docker image ls run:v1
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
run                 v1                  5b09d7ba1736        4 minutes ago       8.42MB
```
Its 8.42MB

### Combining multiple RUN instruction to one
```
FROM alpine:3.9.3
LABEL maintainer="Collabnix"
RUN apk add --update && \
	apk add curl  && \  
	rm -rf /var/cache/apk/
```
#### Building Docker image
```
$ docker image build -t run:v2 .
```
#### Checking layer of the image
```
$ docker image history run:v2
IMAGE               CREATED             CREATED BY                                      SIZE            
NT
784298155541        50 seconds ago      /bin/sh -c apk add --update  && apk add curl…   1.55MB              
8590497d994e        8 minutes ago       /bin/sh -c #(nop)  LABEL maintainer=Collabnix   0B                  
cdf98d1859c1        4 months ago        /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B                  
<missing>           4 months ago        /bin/sh -c #(nop) ADD file:2e3a37883f56a4a27…   5.53MB
```
Number of layers 4
#### Checking image size
```
$ docker image ls run:v2
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
run                 v2                  784298155541        3 minutes ago       7.08MB
```
its now 7.08MB 

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

Next » [Lab #8: ARG instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/arg.html)
