# Difference between Dockerfile and docker-compose

A <b>Dockerfile</b> is a text document that contains all the commands/Instruction a user could call on the command line to assemble an image.<br>
For example
```
FROM centos:latest
LABEL maintainer="collabnix"
RUN yum update -y && \
	yum install -y httpd net-tools && \
	mkdir -p /run/httpd 
EXPOSE 80
ENTRYPOINT apachectl "-DFOREGROUND"
```
Using <b>docker build</b> commmand we can build an image from a Dockerfile.

<b>Docker Compose</b> is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration. By default, docker-compose expects the name of the Compose file as <b>docker-compose.yml</b> or <b>docker-compose.yaml</b>. If the compose file have different name we can specify it with <b>-f</b> flag.

A docker-compose.yml looks like this:
```
version: '3'
services:
  web:
    build: .
    ports:
    - "5000:5000"
    volumes:
    - .:/code
    - logvolume01:/var/log
    links:
    - redis
  redis:
    image: redis
volumes:
  logvolume01: {}
```

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

[How to Install Docker Compose?](http://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/How_to_Install_Docker_Compose.html)<br>
