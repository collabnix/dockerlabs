# Lab #6: WORKDIR instruction


The `WORKDIR` directive in `Dockerfile` defines the working directory for the rest of the instructions in the Dockerfile. The WORKDIR instruction wont create a new layer in the image but will add metadata to the image config. If the WORKDIR doesn’t exist, it will be created even if it’s not used in any subsequent Dockerfile instruction. you can have multiple WORKDIR in same Dockerfile. If a relative path is provided, it will be relative to the previous WORKDIR instruction.


```
WORKDIR /path/to/workdir
```

If no WORKDIR is specified in the Dockerfile then the default path is `/`. The WORKDIR instruction can resolve environment variables previously set in Dockerfile using ENV.

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
- Dockerfile with WORKDIR instruction
- WORKDIR with Relative path
- WORKDIR with Absolute path
- WORKDIR with environment variables as path 

#### Dockerfile with WORKDIR instruction
Dockerfile
```
FROM alpine:3.9.3
LABEL maintainer="Collabnix"

WORKDIR /opt
```
#### Building Docker image
```
$ docker build -t workdir:v1 .
```
#### Testing current WORKDIR by running container
```
$ docker run -it workdir:v1 pwd
```

### WORKDIR with relative path
Dockerfile
```
FROM alpine:3.9.3
LABEL maintainer="Collabnix"

WORKDIR /opt
RUN echo "Welcome to Docker Labs" > opt.txt
WORKDIR folder1
RUN echo "Welcome to Docker Labs" > folder1.txt
WORKDIR folder2
RUN echo "Welcome to Docker Labs" > folder2.txt
```
#### Building Docker image
```
$ docker build -t workdir:v2 .
```
#### Testing current WORKDIR by running container
```
$ docker run -it workdir:v2 pwd
```

### WORKDIR with Absolute path
Dockerfile
```
FROM alpine:3.9.3
LABEL maintainer="Collabnix"

WORKDIR /opt/folder1
RUN echo "Welcome to Docker Labs" > opt.txt
WORKDIR /var/tmp/
```
#### Building Docker image
```
$ docker build -t workdir:v3 .
```
#### Testing current WORKDIR by running container
```
$ docker run -it workdir:v3 pwd
```

### WORKDIR with environment variables as path
Dockerfile
```
FROM alpine:3.9.3
LABEL maintainer="Collabnix"

ENV DIRPATH /myfolder
WORKDIR $DIRPATH
```
#### Building Docker image
```
$ docker build -t workdir:v4 .
```
#### Testing current WORKDIR by running container
```
$ docker run -it workdir:v4 pwd
```

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

Next >> [Lab #7: RUN instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/Lab%237_RUN_instruction.html)
