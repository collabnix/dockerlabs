# Lab #4: Create an image with CMD instruction

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

## Creating Dockerfile

```
FROM alpine:3.6

RUN apk update
CMD ["top"]
```

## Building Docker Container

```
docker build -t ajeetraina/lab3_cmd . -f Dockerfile_cmd
```

## Running the Docker container

```
docker run ajeetraina/lab3_cmd:latest
```
[Lab #5: ENTRYPOINT instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/Dockerfile-ENTRYPOINT.html)
