# How to install Docker 19.03 on NVIDIA Jetson Nano

The NVIDIA® Jetson Nano™ Developer Kit is an AI computer for makers, learners, and developers that brings the power of modern artificial intelligence to a low-power, easyto-use platform. Get started quickly with out-of-the-box support for many popular
peripherals, add-ons, and ready-to-use projects.

Jetson Nano is supported by the comprehensive NVIDIA® JetPack™ SDK, and has the performance and capabilities needed to run modern AI workloads. JetPack includes:

• Full desktop Linux with NVIDIA drivers
• AI and Computer Vision libraries and APIs
• Developer tools
• Documentation and sample code

## Pre-requisite:

- Flash Jetson Nano SD card Image
- No need to enable SSH




## Verifying OS running on Jetson Nano

```
jetson@jetson-desktop:~$ sudo cat /etc/os-release
[sudo] password for jetson:
NAME="Ubuntu"
VERSION="18.04.2 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.2 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
jetson@jetson-desktop:~$
```


## Verifying Docker

```
jetson@jetson-desktop:~$ sudo docker version
Client:
 Version:           18.09.2
 API version:       1.39
 Go version:        go1.10.4
 Git commit:        6247962
 Built:             Tue Feb 26 23:51:35 2019
 OS/Arch:           linux/arm64
 Experimental:      false

Server:
 Engine:
  Version:          18.09.2
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.4
  Git commit:       6247962
  Built:            Wed Feb 13 00:24:14 2019
  OS/Arch:          linux/arm64
  Experimental:     false
jetson@jetson-desktop:~$
```

## Updating Jetson

```
sudo apt update
```

## Installing Docker 19.03

```
sudo apt install curl
```

```
curl -sSL https://get.docker.com/ | sh
```

```
jetson@jetson-desktop:~$ sudo docker version
Client: Docker Engine - Community
 Version:           19.03.2
 API version:       1.40
 Go version:        go1.12.8
 Git commit:        6a30dfc
 Built:             Thu Aug 29 05:32:21 2019
 OS/Arch:           linux/arm64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.2
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.8
  Git commit:       6a30dfc
  Built:            Thu Aug 29 05:30:53 2019
  OS/Arch:          linux/arm64
  Experimental:     false
 containerd:
  Version:          1.2.6
  GitCommit:        894b81a4b802e4eb2a91d1ce216b8817763c29fb
 runc:
  Version:          1.0.0-rc8
  GitCommit:        425e105d5a03fabd737a126ad93d62a9eeede87f
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
jetson@jetson-desktop:~$
```

## Installing Docker Compose

```
root@jetson-desktop:/home/jetson# /usr/bin/docker-compose version
docker-compose version 1.17.1, build unknown
docker-py version: 2.5.1
CPython version: 2.7.15+
OpenSSL version: OpenSSL 1.1.1  11 Sep 2018
root@jetson-desktop:/home/jetson#
```

## Connecting Logictech Webcam


```
root@jetson-desktop:~/docker-cctv-raspbian# docker ps
CONTAINER ID        IMAGE                             COMMAND             CREATED             STATUS              PORTS                    NAMES
b6ff860d4f2a        ajeetraina/docker-cctv-raspbian   "motion"            6 seconds ago       Up 2 seconds        0.0.0.0:8081->8081/tcp   hopeful_newton
root@jetson-desktop:~/docker-cctv-raspbian#
```

```
jetson@jetson-desktop:~$ docker run arm64v8/hello-world
Unable to find image 'arm64v8/hello-world:latest' locally
latest: Pulling from arm64v8/hello-world
3b4173355427: Pull complete
Digest: sha256:5970f71561c8ff01d1d97782f37b0142315c53f31ad23c22883488e36a6dcbcb
Status: Downloaded newer image for arm64v8/hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (arm64v8)
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

jetson@jetson-desktop:~$
```

```
jetson@jetson-desktop:~$ sudo docker info | grep nvidia
 Runtimes: nvidia runc
jetson@jetson-desktop:~$ sudo dpkg --get-selections | grep nvidia
libnvidia-container-tools                       install
libnvidia-container0:arm64                      install
nvidia-container-runtime                        install
nvidia-container-runtime-hook                   install
nvidia-docker2                                  deinstall
nvidia-l4t-3d-core                              install
nvidia-l4t-apt-source                           install
nvidia-l4t-bootloader                           install
nvidia-l4t-camera                               install
nvidia-l4t-ccp-t210ref                          install
nvidia-l4t-configs                              install
nvidia-l4t-core                                 install
nvidia-l4t-cuda                                 install
nvidia-l4t-firmware                             install
nvidia-l4t-graphics-demos                       install
nvidia-l4t-gstreamer                            install
nvidia-l4t-init                                 install
nvidia-l4t-kernel                               install
nvidia-l4t-kernel-dtbs                          install
nvidia-l4t-kernel-headers                       install
nvidia-l4t-multimedia                           install
nvidia-l4t-multimedia-utils                     install
nvidia-l4t-oem-config                           install
nvidia-l4t-tools                                install
nvidia-l4t-wayland                              install
nvidia-l4t-weston                               install
nvidia-l4t-x11                                  install
nvidia-l4t-xusb-firmware                        install
jetson@jetson-desktop:~$
```

