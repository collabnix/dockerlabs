## Creating Volume Mount from **Dockerfile**


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


## Volumes are special directories in a container

Volumes can be declared in two different ways.

* Within a `Dockerfile`, with a `VOLUME` instruction.

```dockerfile
VOLUME /uploads
```

* On the command-line, with the `-v` flag for `docker run`.

```bash
$ docker run -d -v /uploads myapp
```

In both cases, `/uploads` (inside the container) will be a volume.



Create a file with name volume and paste the following content to it:

```
FROM ubuntu:latest
RUN mkdir /data
WORKDIR /data
RUN echo "Hello from Volume" > test
VOLUME /data
```

Execute the following commands:

```
docker build -f volume -t collabnix/volume:1 .

docker run collabnix/volume:1

docker volume ls

cd /var/lib/docker/volumes

ls -ltr

cd ./<FOLDER_NAME_WITH_RANDOM_NUMBERS_&_CHARACTERS>

cd ./_data
 
cat test 
```
