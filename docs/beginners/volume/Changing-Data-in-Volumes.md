#  Changing Data In Volumes using Dockerfile 

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
- Click on "Add New Node"

# Getting Started


- Pull down alpine docker image <br>
- Add content to volume in Dockerfile <br>
- Verify the content by running the container<br>

## Create a Dockerfile and add data to volume


Pull a lightweight  alpine distribution image.

```
docker pull alpine
```

Create a Dockerfile with alpine image as base and write data into myvol

```
FROM alpine
RUN mkdir /myvol
RUN echo 'Hello! Welcome to Docker Community' >> /myvol/greeting
VOLUME /myvol
```

Build the Docker Image:

```
docker build -t volume_image .
```

Verify the data by starting the container and displaying the content of the file

```
$ docker run -it volume_image cat /myvol/greeting
Hello! Welcome to Docker Community
```

## Clean up artifacts. 

```
docker rm -f $(docker ps -aq) .
docker rmi $(docker images -q)
docker volume rm $(docker volume ls -q)
```