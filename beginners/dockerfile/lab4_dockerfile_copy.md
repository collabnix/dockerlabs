# Lab #3: Create an image with COPY instruction
The COPY instruction copies files or directories from source and adds them to the filesystem of the container at destinatio.

Two form of COPY instruction
```
COPY [--chown=<user>:<group>] <src>... <dest>
COPY [--chown=<user>:<group>] ["<src>",... "<dest>"] (this form is required for paths containing whitespace)
```

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

- Create an image with COPY instruction
- COPY instruction in Multi-stage Builds

### Create an image with COPY instruction
Dockerfile
```
FROM nginx:alpine
LABEL maintainer="Collabnix"

COPY index.html /usr/share/nginx/html/
ENTRYPOINT ["nginx", "-g", "daemon off;"]
```
Lets create the <b>index.html</b> file
```
$ echo "Welcome to Dockerlabs !" > index.html
```
#### Building Docker Image
```
$ docker image build -t cpy:v1 .
```
#### Staring the container
```
$ docker container run -d --rm --name myapp1 -p 80:80 cpy:v1
```
#### Checking index file
```
$ curl localhost
Welcome to Dockerlabs !
```

### COPY instruction in Multi-stage Builds
Dockerfile
```
FROM alpine AS stage1
LABEL maintainer="Collabnix"
RUN echo "Welcome to Docker Labs!" > /opt/index.html

FROM nginx:alpine
LABEL maintainer="Collabnix"
COPY --from=stage1 /opt/index.html /usr/share/nginx/html/
ENTRYPOINT ["nginx", "-g", "daemon off;"]
```
#### Building Docker Image
```
$ docker image build -t cpy:v2 .
```
#### Staring the container
```
$ docker container run -d --rm --name myapp2 -p 8080:80 cpy:v2
```
#### Checking index file
```
$ curl localhost:8080
Welcome to Docker Labs !
```

<b>NOTE:</b> You can name your stages, by adding an AS <NAME> to the FROM instruction.By default, the stages are not named, and you can refer to them by their integer number, starting with 0 for the first FROM instruction.You are not limited to copying from stages you created earlier in your Dockerfile, you can use the COPY --from instruction to copy from a separate image, either using the local image name, a tag available locally or on a Docker registry.

```
COPY --from=nginx:latest /etc/nginx/nginx.conf /nginx.conf
```

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

Next » [Lab #4: CMD instruction](https://dockerlabs.collabnix.com//beginners/dockerfile/lab4_cmd.html)
