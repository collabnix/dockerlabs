# Lab #5 : Create an image with ENTRYPOINT instruction

The `ENTRYPOINT` instruction make your container run as an executable. <br>
ENTRYPOINT can be configured in two forms:
 - <b> Exec Form </b><br>
		    ENTRYPOINT ["executable", "param1", "param2"]  <br>
 - <b>Shell Form</b><br>
		  ENTRYPOINT command param1 param2 <br>
      
If an image has an ENTRYPOINT if you pass an argument it, while running container it wont override the existing entrypoint, it will append what you passed with the entrypoint.To override the existing ENTRYPOINT you should user <b>--entrypoint</b> flag when running container.

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
- Create an image with ENTRYPOINT instruction(Exec Form)
- ENTRYPOINT instruction in Shell Form
- Override the existing ENTRYPOINT
 
### Create an image with ENTRYPOINT instruction(Exec Form)
Dockerfile
```
FROM alpine:3.5
LABEL maintainer="Collabnix"

ENTRYPOINT ["/bin/echo", "Hi, your ENTRYPOINT instruction in Exec Form !"]
```
#### Build Docker Image
```
$ docker build -t entrypoint:v1 .
```
#### Verify the Image
```
$ docker image ls

REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
entrypoint          v1                  1d06f06c2062        2 minutes ago       4MB
alpine              3.5                 f80194ae2e0c        7 months ago        4MB
```
#### Create a container
```
$ docker container run entrypoint:v1
Hi, your ENTRYPOINT instruction in Exec Form !
```
### ENTRYPOINT instruction in Shell Form
Dockerfile
```
$ cat Dockerfile 
FROM alpine:3.5
LABEL maintainer="Collabnix"

ENTRYPOINT echo "Hi, your ENTRYPOINT instruction in Shell Form !"
```
#### Build Docker Image
```
$ docker build -t entrypoint:v2 .
```
#### Verify the Image
```
$ docker image ls

REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
entrypoint          v2                  cde521f13080        2 minutes ago       4MB
entrypoint          v1                  1d06f06c2062        5 minutes ago      4MB
alpine              3.5                 f80194ae2e0c        7 months ago        4MB
```
#### Create a container
```
$ docker container run entrypoint:v2
Hi, your ENTRYPOINT instruction in Shell Form !
```

### Override the existing ENTRYPOINT
```
$ docker container run --entrypoint "/bin/echo" entrypoint:v2 "Hello, Welocme to Docker Meetup! "
Hello, Welocme to Docker Meetup! 
```
## Contributor 
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

[Lab #6: WORKDIR instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/WORKDIR_instruction.html)
