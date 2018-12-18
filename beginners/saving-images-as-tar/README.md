# Saving Images and Containers as Tar Files for Sharing

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


## 

```
$ docker ps -a
CONTAINER ID IMAGE COMMAND CREATED ... NAMES
77d9619a7a71 ubuntu:14.04 "/bin/bash" 10 seconds ago ... high_shockley
```

```
$ docker export 77d9619a7a71 > update.tar
```

```
$ ls
update.tar
```

You could commit this container as a new image (see Recipe 2.1) locally, but you
could also use the Docker import command:

```
$ docker import - update < update.tar
157bcbb5fdfce0e7c10ef67ebdba737a491214708a5f266a3c74aa6b0cfde078
```

```
$ docker images
```

```
REPOSITORY TAG IMAGE ID ... VIRTUAL SIZE
update latest 157bcbb5fdfc ... 188.1 MB

```

If you wanted to share this image with one of your collaborators, you could upload the tar file on a web server and let your collaborator download it and use the import command on his Docker host.

If you would rather deal with images that you have already committed, you can use
the load and save commands:

```
$ docker save -o update1.tar update
```

```
$ ls -l
total 385168
-rw-rw-r-- 1 vagrant vagrant 197206528 Jan 13 14:13 update1.tar
-rw-rw-r-- 1 vagrant vagrant 197200896 Jan 13 14:05 update.tar
```

```
$ docker rmi update
Untagged: update:latest
Deleted: 157bcbb5fdfce0e7c10ef67ebdba737a491214708a5f266a3c74aa6b0cfde078
```

```
$ docker load < update1.tar
```

```
$ docker images
REPOSITORY TAG IMAGE ID CREATED VIRTUAL SIZE
update latest 157bcbb5fdfc 5 minutes ago 188.1 MB
ubuntu 14.04 8eaa4ff06b53 12 days ago 192.7 MB
```
