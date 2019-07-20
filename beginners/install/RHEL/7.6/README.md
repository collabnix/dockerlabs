---
layout: default
title: Beginners Track - Installing Docker Community Edition on RHEL 7.6 running on Amazon EC2 Instance
description: collabnix | DockerLab | Docker - Beginners Track
---


# Installing Docker Community Edition on RHEL 7.6 running on Amazon EC2 Instance

Docker Community Edition (Docker CE) is officially NOT supported on Red Hat Enterprise Linux but still you can install it on RHEL 7.x with few tweaks. In case you're new, Docker Community Edition (CE) is ideal for developers and small teams looking to get started with Docker and experimenting with container-based apps. Docker CE has three types of update channels, stable, test, and nightly:

- Stable gives you latest releases for general availability.
- Test gives pre-releases that are ready for testing before general availability.
- Nightly gives you latest builds of work in progress for the next major release.

Under this tutorial, we will see how to install RHEL 

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Amazon EC2 Instance</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create RHEL 7.6 OS Instance on Amazon EC2 

```
$cat /etc/os-release
NAME="Red Hat Enterprise Linux Server"
VERSION="7.6 (Maipo)"
ID="rhel"
ID_LIKE="fedora"
VARIANT="Server"
VARIANT_ID="server"
VERSION_ID="7.6"
PRETTY_NAME="Red Hat Enterprise Linux Server 7.6 (Maipo)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:redhat:enterprise_linux:7.6:GA:server"
HOME_URL="https://www.redhat.com/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"

REDHAT_BUGZILLA_PRODUCT="Red Hat Enterprise Linux 7"
REDHAT_BUGZILLA_PRODUCT_VERSION=7.6
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux"
REDHAT_SUPPORT_PRODUCT_VERSION="7.6"
```

## Setting up the Docker CE repository on RHEL:

```
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast
```


## Please Note:

Before you install Docker, you need to install "container-selinux", "container-selinux" package. It  is available from the rhel-7-server-extras-rpms . You might need to enable that in 7.x


```
sudo yum-config-manager --enable rhel-7-server-extras
```

## Install the latest version of Docker CE on RHEL:

```
sudo yum -y install docker-ce
```

Alternatively, you can specify a specific version of Docker CE:


```
sudo yum -y install docker-ce-<version>-<release>
```

## Initiating Docker Service:

```
sudo systemctl start docker
```

## Verifying Docker Instables

```

[root@ip-172-31-83-33 ~]# docker version
Client:
Version:           18.09.0
API version:       1.39
Go version:        go1.10.4
Git commit:        4d60db4
Built:             Wed Nov  7 00:48:22 2018
OS/Arch:           linux/amd64
Experimental:      false
```


## Testing your Docker CE installation:

```
sudo docker run hello-world
```

## Contributor

[Haribabu Mannam](mannam.hari@gmail.com)


