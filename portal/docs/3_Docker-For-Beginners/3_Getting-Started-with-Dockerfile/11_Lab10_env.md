# Lab #9: ENV instruction

The `ENV` instruction in Dockerfile sets the environment variable for your container when you start. The default value can be overridden by passing `--env <key>=<value>` when you start the container.


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
- Writing a Dockerfile with ENV instruction
- Building Docker Image
- Running container env:v1
- Override existing env while running container

### Writing a Dockerfile with ENV instruction
Dockerfile
```
FROM alpine:3.9.3
LABEL maintainer="Collabnix"

ENV WELCOME_MESSAGE="Welcome to Docker World"

CMD ["sh", "-c", "echo $WELCOME_MESSAGE"]
```

#### Building Docker Image
```
$ docker build -t env:v1 .
```

### Running container env:v1
```
$ docker container run env:v1
Welcome to Docker World
```

### Override existing env while running container
```
$ docker container run --env WELCOME_MESSAGE="Welcome to Docker Workshop" env:v1 
Welcome to Docker Workshop
```

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

[Lab #10: VOLUME instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/Lab%2310_VOLUME_instruction.html)
