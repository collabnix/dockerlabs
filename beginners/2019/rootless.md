# Testing rootless Docker

## Installing Rootless Docker

We require the below components in place:

```
Start daemon: dockerd-rootless.sh --experimental
Start client: docker -H unix://$XDG_RUNTIME_DIR/docker.sock run ..
```

### Pre-requisite:

- Install Ubuntu 18.10 on Google Cloud Platform

Download the below bits:

- https://download.docker.com/linux/static/test/x86_64/docker-19.03.0-beta1.tgz
- https://download.docker.com/linux/static/test/x86_64/docker-rootless-extras-19.03.0-beta1.tgz


### Steps to install rootless Docker

```
wget https://download.docker.com/linux/static/test/x86_64/docker-rootless-extras-19.03.0-beta1.tgz
```

## Extracting the bits

```
tar xvf docker-rootless-extras-19.03.0-beta1.tgz
```

```
$pwd;ls
/home/tanvirkour1985/docker-rootless-extras
dockerd-rootless.sh  rootlesskit  vpnkit
```

```
 ls
docker  docker-19.03.0-beta1.tgz  docker-rootless-extras  docker-rootless-extras-19.03.0-beta1.tgz
```

```
dockerd-rootless.sh --experimental
```

## Start client: 


```
docker -H unix://$XDG_RUNTIME_DIR/docker.sock run hello-world
INFO[2019-04-10T17:58:18.279144392Z] shim containerd-shim started                  address="/containerd-shim/moby/497e1a69744999dbd05c095cb3fe1bd614
e2f044f6a4243160ea911698fffdd2/shim.sock" debug=false pid=4185
Hello from Docker!
This message shows that your installation appears to be working correctly.
To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.
To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash
Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/
For more examples and ideas, visit:
 https://docs.docker.com/get-started/
 ```






