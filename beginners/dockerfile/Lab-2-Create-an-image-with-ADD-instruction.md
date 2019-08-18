# Lab #2: Create an image with ADD instruction

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

- Create an image with ADD instruction
- Tag your image as labs-add:v1.0
- Create a container based on that image, and see the extracted tar file.

## Creating Dockerfile

```
FROM alpine:3.5
RUN apk update
ADD http://www.vlsitechnology.org/pharosc_8.4.tar.gz .
```

## Build Docker Image

```
docker build -t saiyam911/alpine-add .
```

## Tagging image as labs-git

```
docker tag saiyam911/alpine-add saiyam911/labs-add:v1.0
```

## Verify the Images


```
$ docker images
REPOSITORY                   TAG                 IMAGE ID            CREATED             SIZE
saiyam911/alpine-add        latest              cdf97cb49d48        38 minutes ago       300MB
saiyam911/labs-add          v1.0                cdf97cb49d48        38 minutes ago       300MB
```


##  Create a container

```
docker run -itd saiyam911/labs-add:v1.0 /bin/sh
```

```
$ docker ps
CONTAINER ID        IMAGE                      COMMAND             CREATED             STATUS              PORTS               NAMES
f0940750f61a        saiyam911/labs-add:v1.0   "/bin/sh"           20 seconds ago      Up 18 seconds                           distracted_darwin
```

## Enter into Container Shell

```
docker attach f094
```

Please press "Enter" key twice so as to enter into container shell


## Verify if the link has been extracted onto the container

```
/ # ls -ltr
-rw-------    1 root     root     295168000 Sep 19  2007 pharosc_8.4.tar.gz
```

ADD Command lets you to add a tar directly from a link and explode to the container.
## Contributor - [Saiyam Pathak](https://www.linkedin.com/in/saiyam-pathak-97685a64/)

[Lab #3: Create a Docker image with COPY instruction]()
