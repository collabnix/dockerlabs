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


## Volumes can be shared across containers

You can start a container with *exactly the same volumes* as another one.

The new container will have the same volumes, in the same directories.

They will contain exactly the same thing, and remain in sync.

Under the hood, they are actually the same directories on the host anyway.

This is done using the `--volumes-from` flag for `docker run`.

We will see an example in the following slides.


## Sharing app server logs with another container

Let's start a Tomcat container:

```bash
$ docker run --name webapp -d -p 8080:8080 -v /usr/local/tomcat/logs tomcat
```

Now, start an `alpine` container accessing the same volume:

```bash
$ docker run --volumes-from webapp alpine sh -c "tail -f /usr/local/tomcat/logs/*"
```

Then, from another window, send requests to our Tomcat container:
```bash
$ curl localhost:8080
```


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
