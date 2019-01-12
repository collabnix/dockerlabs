## Creating Volume Mount from **docker run** command & sharing same Volume Mounts among multiple containers

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

Create a file with name volume_test and paste the following content:

```
FROM ubuntu:latest
RUN mkdir /data
ENV MESSAGE=HI
ENV FILENAME=test
WORKDIR /data
ENTRYPOINT echo ${MESSAGE} > ${FILENAME} && ls
```

Execute following commands:

```
docker build -f volume_test -t collabnix/volume_test:1 .

docker run --env MESSAGE="GOOD Morning" --env FILENAME=morning_message\
 --mount type=volume,source=demo,target=/data \
 collabnix/volume_test:1
 
 docker run --env MESSAGE="GOOD Afternoon" --env FILENAME=afternoon_message\
  --mount type=volume,source=demo,target=/data \
  collabnix/volume_test:1

docker volume ls

cd /var/lib/docker/volumes/demo/_data

ls

cat morning_message &&  cat afternoon_message
```
