
# Creating a Private Docker Registry


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
$ sudo mkdir -p /srv/registry/data
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
  -v /srv/registry/data:/var/lib/registry \
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
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
b1a641f8d710        registry:2          "/entrypoint.sh /etc…"   5 minutes ago       Up 5 minutes        0.0.0.0:5000->5000/tcp   registry
```

## Pull Debian Stretch image from official repository.

```
$ docker pull debian:stretch

stretch: Pulling from library/debian
723254a2c089: Pull complete
Digest: sha256:0a5fcee6f52d5170f557ee2447d7a10a5bdcf715dd7f0250be0b678c556a501b
Status: Downloaded newer image for debian:stretch
```

## Tag local Debian Stretch image with an additional tag - local repository address.

```
$ docker tag debian:stretch localhost:5000/debian:stretch
```

## Push image to the local repository.

```
$ docker push localhost:5000/debian:stretch

The push refers to repository [localhost:5000/debian]
e27a10675c56: Pushed
stretch: digest: sha256:02741df16aee1b81c4aaff4c48d75cc2c308bade918b22679df570c170feef7c size: 529
```

## Remove local images.

```
$ docker image remove debian:stretch

Untagged: debian:stretch
Untagged: debian@sha256:0a5fcee6f52d5170f557ee2447d7a10a5bdcf715dd7f0250be0b678c556a501b
```

```
$ docker image remove localhost:5000/debian:stretch

Untagged: localhost:5000/debian:stretch
Untagged: localhost:5000/debian@sha256:02741df16aee1b81c4aaff4c48d75cc2c308bade918b22679df570c170feef7c
Deleted: sha256:da653cee0545dfbe3c1864ab3ce782805603356a9cc712acc7b3100d9932fa5e
Deleted: sha256:e27a10675c5656bafb7bfa9e4631e871499af0a5ddfda3cebc0ac401dfe19382
```

## Pull Debian Stretch image from local repository.

```
$ docker pull localhost:5000/debian:stretch

stretch: Pulling from debian
723254a2c089: Pull complete
Digest: sha256:02741df16aee1b81c4aaff4c48d75cc2c308bade918b22679df570c170feef7c
Status: Downloaded newer image for localhost:5000/debian:stretch
```

## List stored images.

```
$ docker image ls

REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
registry                2                   d1fd7d86a825        4 weeks ago         33.3MB
localhost:5000/debian   stretch             da653cee0545        2 months ago        100MB
hello-world             latest              f2a91732366c        2 months ago        1.85kB
```

## Shared local registry

Create a directory to permanently store images.

```
$ sudo mkdir -p /srv/registry/data
```

## Create a directory to permanently store certificates and authentication data.

```
$ sudo mkdir -p /srv/registry/security
```

Store domain and intermediate certificates using /srv/registry/security/registry.crt file, private key using /srv/registry/security/registry.key file. Use valid certificate and do not waste time with self-signed one. This step is required do use basic authentication.

## Install apache2-utils to use htpasswd utility.

```
$ sudo apt-get install apache2-utils
```

Create initial username and password. The only supported password format is bcrypt.

```
$ : | sudo tee /srv/registry/security/htpasswd
```

```
$ echo "password" | sudo htpasswd -iB /srv/registry/security/htpasswd username
```

## Adding password for user username

```
$ cat /srv/registry/security/htpasswd

username:$2y$05$KjuSifCdzRiYmir9N.nu.OKHtEbSZxbUPR04zatI25G9Bqyq1cho.
```

## Start the registry container.

```
$ docker run -d \
  -p 443:5000 \
  --name registry \
  -v /srv/registry/data:/var/lib/registry \
  -v /srv/registry/security:/etc/security \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/etc/security/registry.crt \
  -e REGISTRY_HTTP_TLS_KEY=/etc/security/registry.key \
  -e REGISTRY_AUTH=htpasswd \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/etc/security/htpasswd \
  -e REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm" \
  --restart always \
  registry:2
```

```
ac9279b49a1c040c5935fa4d5df19c186a9fb0bcc9583afcf3768dd42bc40143
```

## Display running containers.

```
$ docker ps

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                   NAMES
ac9279b49a1c        registry:2          "/entrypoint.sh /etc…"   17 seconds ago      Up 16 seconds       0.0.0.0:443->5000/tcp   registry
```

## Pull Debian Stretch image from official repository.

```
$ docker pull debian:stretch

stretch: Pulling from library/debian
723254a2c089: Pull complete
Digest: sha256:0a5fcee6f52d5170f557ee2447d7a10a5bdcf715dd7f0250be0b678c556a501b
Status: Downloaded newer image for debian:stretch
```

## Tag local Debian Stretch image with an additional tag - local repository address.

```
$ docker tag debian:stretch registry.collabnix/debian:stretch
```

This time you need to provide login credentials to use local repository.

```
$ docker push registry.collabnix/debian:stretch

e27a10675c56: Preparing
no basic auth credentials
```

```
$ docker pull registry.collabnix/debian:stretch
```

Error response from daemon: Get https://registry.collabnix/v2/debian/manifests/stretch: no basic auth credentials

## Log in to the local registry.

```
$ docker login --username username registry.collabnix
Password: ********

Login Succeeded
```

## Push image to the local repository.

```
$ docker push registry.collabnix/debian:stretch
```

```
The push refers to repository [registry.collabnix/debian]
e27a10675c56: Pushed
stretch: digest: sha256:02741df16aee1b81c4aaff4c48d75cc2c308bade918b22679df570c170feef7c size: 529
```

## Remove local images.

```
$ docker image remove debian:stretch

Untagged: debian:stretch
Untagged: debian@sha256:0a5fcee6f52d5170f557ee2447d7a10a5bdcf715dd7f0250be0b678c556a501b
```

```
$ docker image remove registry.sleeplessbeastie.eu/debian:stretch

Untagged: registry.sleeplessbeastie.eu/debian:stretch
Untagged: registry.sleeplessbeastie.eu/debian@sha256:02741df16aee1b81c4aaff4c48d75cc2c308bade918b22679df570c170feef7c
Deleted: sha256:da653cee0545dfbe3c1864ab3ce782805603356a9cc712acc7b3100d9932fa5e
Deleted: sha256:e27a10675c5656bafb7bfa9e4631e871499af0a5ddfda3cebc0ac401dfe19382
```

## Pull Debian Stretch image from local repository.

```
$ docker pull registry.collabnix/debian:stretch

stretch: Pulling from debian
723254a2c089: Pull complete
Digest: sha256:02741df16aee1b81c4aaff4c48d75cc2c308bade918b22679df570c170feef7c
Status: Downloaded newer image for registry.collabnix/debian:stretch
```

## List stored images.

```
$ docker image ls

REPOSITORY                           TAG                 IMAGE ID            CREATED             SIZE
registry                             2                   d1fd7d86a825        4 weeks ago         33.3MB
registry.collabnix/debian   stretch             da653cee0545        2 months ago        100MB
hello-world                          latest              f2a91732366c        2 months ago     
```
