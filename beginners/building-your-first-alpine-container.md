# How to build Your First Alpine Docker Image and Push it to DockerHub


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

Under this tutorial we will see how to build our own first alpine based Docker Image.

```
$ docker run -dit alpine sh
620e1bcb5ab6e84b75a7a5c35790a77691112e59830ea1d5d85244bc108578c9
[node4] (local) root@192.168.0.20 ~
```

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
620e1bcb5ab6        alpine              "sh"                3 seconds ago       Up 2 seconds                            keen_alba
ttani
```

```
[node4] (local) root@192.168.0.20 ~
$ docker attach 62
/ #
/ #
/ # cat /etc/os-release
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.9.2
PRETTY_NAME="Alpine Linux v3.9"
HOME_URL="https://alpinelinux.org/"
BUG_REPORT_URL="https://bugs.alpinelinux.org/"
/ #
```

# Updating APK Packages

```
/ # apk update
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/community/x86_64/APKINDEX.tar.gz
v3.9.2-21-g3dda2a36ce [http://dl-cdn.alpinelinux.org/alpine/v3.9/main]
v3.9.2-19-gfdf726d41a [http://dl-cdn.alpinelinux.org/alpine/v3.9/community]
OK: 9756 distinct packages available
/ # ^
```

```
/ # apk add git
(1/7) Installing ca-certificates (20190108-r0)
(2/7) Installing nghttp2-libs (1.35.1-r0)
(3/7) Installing libssh2 (1.8.0-r4)
(4/7) Installing libcurl (7.64.0-r1)
(5/7) Installing expat (2.2.6-r0)
(6/7) Installing pcre2 (10.32-r1)
(7/7) Installing git (2.20.1-r0)
Executing busybox-1.29.3-r10.trigger
Executing ca-certificates-20190108-r0.trigger
OK: 20 MiB in 21 packages
/ #
```

# Now lets come out of it by Ctrl+P+Q and commit the changes

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
620e1bcb5ab6        alpine              "sh"                4 minutes ago       Up 4 minutes                            keen_alba
ttani
[node4] (local) root@192.168.0.20 ~
$ docker commit -m "Added GIT" 620 ajeetraina/alpine-git
sha256:9a8cd6c3bd8761013b2b932c58af2870f5637bfdf4227d7414073b0458ed0c54
[node4] (local) root@192.168.0.20 ~
$ docker images
REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
ajeetraina/alpine-git   latest              9a8cd6c3bd87        11 seconds ago      31.2MB
ubuntu                  latest              94e814e2efa8        3 days ago          88.9MB
alpine                  3.6                 43773d1dba76        7 days ago          4.03MB
alpine                  3.7                 6d1ef012b567        7 days ago          4.21MB
alpine                  3.8                 dac705114996        7 days ago          4.41MB
alpine                  3.9                 5cb3aa00f899        7 days ago          5.53MB
alpine                  latest              5cb3aa00f899        7 days ago          5.53MB
```

There you see a new image just created.

# Time to tag the image

```
$ docker tag --help

Usage:  docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]

Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
[node4] (local) root@192.168.0.20 ~
$ docker tag ajeetraina/alpine-git:latest ajeetraina/alpine-git:1.0
```

```
$ docker images
REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
ajeetraina/alpine-git   1.0                 9a8cd6c3bd87        2 minutes ago       31.2MB
ajeetraina/alpine-git   latest              9a8cd6c3bd87        2 minutes ago       31.2MB
ubuntu                  latest              94e814e2efa8        3 days ago          88.9MB
alpine                  3.6                 43773d1dba76        7 days ago          4.03MB
alpine                  3.7                 6d1ef012b567        7 days ago          4.21MB
alpine                  3.8                 dac705114996        7 days ago          4.41MB
alpine                  3.9                 5cb3aa00f899        7 days ago          5.53MB
alpine                  latest              5cb3aa00f899        7 days ago          5.53MB
```

# Pushing it to DockerHub

```
$ docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker
.com to create one.
Username: ajeetraina
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
[node4] (local) root@192.168.0.20 ~
```


```
$ docker push ajeetraina/alpine-git:1.0
The push refers to repository [docker.io/ajeetraina/alpine-git]
3846235f8c17: Pushed
bcf2f368fe23: Mounted from library/alpine
1.0: digest: sha256:85d50f702e930db9e5b958387e667b7e26923f4de340534085cea184adb8411e size: 740
[node4] (local) root@192.168.0.20 ~
```
[Next >> Building Docker Image from Scratch](https://dockerlabs.collabnix.com/beginners/building-docker-image-from-scratch.html)





