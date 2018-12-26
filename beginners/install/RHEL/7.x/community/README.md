# Installing Docker Community Edition on RHEL 7.x running on Amazon EC2 Instance

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

- Create RHEL 7.x OS Instance on Amazon EC2 


## Steps

## Configuring YUM Repository

```
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast
```


** Please Note:

Before you install Docker, you need to install "container-selinux", "container-selinux" package. It  is available from the rhel-7-server-extras-rpms . You might need to enable that in 7.x


```
sudo yum-config-manager --enable rhui-REGION-rhel-server-extras
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


