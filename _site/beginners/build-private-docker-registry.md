
# Creating a Private Local Docker Registry using Play with Docker


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


## Create a directory to permanently store images.

```
$ mkdir -p /registry/data
```

## Authenticate with DockerHub

```
$docker login
```

## Start the registry container.

```
$ docker run -d \
  -p 5000:5000 \
  --name registry \
  -v /registry/data:/var/lib/registry \
  --restart always \
  registry:2
```

```
b1a641f8d710eee34405ad575050179f5a1262f1c845806cc3c2b435dea1648c
```

## Display running containers.

```
$ docker ps
```
```
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS
                    NAMES
3a056bf96c6d        registry:2          "/entrypoint.sh /etc…"   About an hour ago   Up About an hour    0.0.0
.0:5000->5000/tcp   registry
```

## Pull Alpine 3.6 image from official repository.

```
$ docker pull alpine:3.6

stretch: Pulling from library/alpine
723254a2c089: Pull complete
Digest: sha256:0a5fcee6f52d5170f557ee2447d7a10a5bdcf715dd7f0250be0b678c556a501b
Status: Downloaded newer image for alpine:3.6
```

## Tag local alpine 3.6 image with an additional tag - local repository address.

```
$ docker tag alpine:3.6 localhost:5000/alpine:3.6
```

## Push image to the local repository.

```
[node1] (local) root@192.168.0.23 ~
$ docker push localhost:5000/alpine:3.6
The push refers to repository [localhost:5000/alpine:3.6]
90d1009ce6fe: Pushed
stretch: digest: sha256:38236c068c393272ad02db100e09cac36a5465149e2924a035ee60d6c60c38fe size: 529
[node1] (local) root@192.168.0.23 ~
```

## Remove local images.

```
[node1] (local) root@192.168.0.23 ~
$ docker image remove alpine:3.6
Untagged: alpine:3.6
Untagged: alpine@sha256:df6ebd5e9c87d0d7381360209f3a05c62981b5c2a3ec94228da4082ba07c4f05
```

```
[node1] (local) root@192.168.0.23 ~
$ docker image remove localhost:5000/alpine:3.6
Untagged: localhost:5000/alpine:3.6
Untagged: localhost:5000/debian@sha256:38236c068c393272ad02db100e09cac36a5465149e2924a035ee60d6c60c38fe
Deleted: sha256:4879790bd60d439cfe39c063660eef7af525d5f6f1cbb701a14c7cfc11cbfcf7
```

## Pull Alpine 3.6 image from local repository.

```
[node1] (local) root@192.168.0.23 ~
$ docker pull localhost:5000/alpine:3.6
stretch: Pulling from alpine
54f7e8ac135a: Pull complete
Digest: sha256:38236c068c393272ad02db100e09cac36a5465149e2924a035ee60d6c60c38fe
Status: Downloaded newer image for localhost:5000/alpine:3.6
```

## List stored images.

```
[node1] (local) root@192.168.0.23 ~
$ docker image ls
REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
localhost:5000/alpine   3.6                 4879790bd60d        12 days ago         101MB
registry                2                   2e2f252f3c88        2 months ago        33.3MB

```

## Shared local registry

Create a directory to permanently store images.

```
$ mkdir -p /srv/registry/data
```

## Create a directory to permanently store certificates and authentication data.

```
$ mkdir -p /srv/registry/security
```

Store domain and intermediate certificates using /srv/registry/security/registry.crt file, private key using /srv/registry/security/registry.key file. Use valid certificate and do not waste time with self-signed one. This step is required do use basic authentication.

## Install apache2-utils to use htpasswd utility.

```
[node1] (local) root@192.168.0.23 ~
$ apk add apache2-utils
OK: 302 MiB in 110 packages
```

Create initial username and password. The only supported password format is bcrypt.

```
$ : | sudo tee /srv/registry/security/htpasswd
```

```
[node1] (local) root@192.168.0.23 ~
$ echo "password" | sudo htpasswd -iB /srv/registry/security/htpasswd username
Adding password for user username
```

## Adding password for user username

```
$
[node1] (local) root@192.168.0.23 ~
$ cat /srv/registry/security/htpasswd
username:$2y$05$q9R5FSNYpAppB4Vw/AGWb.RqMCGE8DmZ4q5HZC/1wC87oTWyvB9vy
[node1] (local) root@192.168.0.23 ~
$
```

## Stop and Remove all old containers

```
$ docker stop $(docker ps -a -q)
3a056bf96c6d
[node1] (local) root@192.168.0.23 ~
$ docker rm -f $(docker ps -a -q)
3a056bf96c6d
```

## Start the registry container.

```
[node1] (local) root@192.168.0.23 ~
$ docker run -d   -p 443:5000   --name registry   -v /srv/registry/data:/var/lib/registry   -v /srv/registry/security:/etc/security   -e REGISTRY_HTTP_TLS_CERTIFICATE=/etc/security/registry.crt   -e REGISTRY_HTTP_TLS_KEY=/etc/security/registry.key   -e REGISTRY_AUTH=htpasswd   -e REGISTRY_AUTH_HTPASSWD_PATH=/etc/security/htpasswd   -e REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm"   --restart always   registry:2
e7755af8cbd70ea84ab77237a87cb97fd1abb18c7726fbc116c40f081d3b7098
[node1] (local) root@192.168.0.23 ~
```



## Display running containers.

```
[node1] (local) root@192.168.0.23 ~
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS        PORTS               NAMES
e7755af8cbd7        registry:2          "/entrypoint.sh /etc…"   About a minute ago   Restarting (1) 22 seconds ago                       registry
[node1] (local) root@192.168.0.23 ~
```

## Pull Alpine image from official repository.

```
$ docker pull alpine:3.6

stretch: Pulling from library/alpine
723254a2c089: Pull complete
Digest: sha256:0a5fcee6f52d5170f557ee2447d7a10a5bdcf715dd7f0250be0b678c556a501b
Status: Downloaded newer image for alpine:3.6
```

## Tag local Alpine image with an additional tag - local repository address.

```
$ docker tag alpine:3.6 registry.collabnix.com/alpine:3.6
```

This time you need to provide login credentials to use local repository.

```
$ docker push registry.collabnix.com/alpine:3.6

e27a10675c56: Preparing
no basic auth credentials
```

```
$ docker pull registry.collabnix.com/alpine:3.6
```

Error response from daemon: Get https://registry.collabnix.com/v2/alpine/manifests/3.6: no basic auth credentials

## Log in to the local registry.

```
$ docker login --username username registry.collabnix.com
Password: ********

Login Succeeded
```

## Push image to the local repository.

```
$ docker push registry.collabnix.com/alpine:3.6
```

```
The push refers to repository [registry.collabnix.com/alpine]
e27a10675c56: Pushed
stretch: digest: sha256:02741df16aee1b81c4aaff4c48d75cc2c308bade918b22679df570c170feef7c size: 529
```

## Remove local images.

```
$ docker image remove alpine:3.6

Untagged: alpine:3.6
Untagged: alpine@sha256:0a5fcee6f52d5170f557ee2447d7a10a5bdcf715dd7f0250be0b678c556a501b
```

```
$ docker image remove registry.collabnix.com/alpine:3.6

Untagged: registry.collabnix.com/alpine:3.6
Untagged: registry.sl.collabnix.com/alpine@sha256:02741df16aee1b81c4aaff4c48d75cc2c308bade918b22679df570c170feef7c
Deleted: sha256:da653cee0545dfbe3c1864ab3ce782805603356a9cc712acc7b3100d9932fa5e
Deleted: sha256:e27a10675c5656bafb7bfa9e4631e871499af0a5ddfda3cebc0ac401dfe19382
```

## Pull Debian Stretch image from local repository.

```
$ docker pull registry.collabnix.com/alpine:3.6

stretch: Pulling from alpine
723254a2c089: Pull complete
Digest: sha256:02741df16aee1b81c4aaff4c48d75cc2c308bade918b22679df570c170feef7c
Status: Downloaded newer image for registry.collabnix.com/alpine:3.6
```

## List stored images.

```
$ docker image ls

REPOSITORY                           TAG                 IMAGE ID            CREATED             SIZE
registry                             2                   d1fd7d86a825        4 weeks ago         33.3MB
registry.collabnix.com/alpine        3.6             da653cee0545        2 months ago        100MB
hello-world                          latest              f2a91732366c        2 months ago     
```

Next >> [Building a Private Docker Registry with UI](https://dockerlabs.collabnix.com/beginners/portus/)
