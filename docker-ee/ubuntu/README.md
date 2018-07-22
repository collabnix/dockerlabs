# How to install Docker EE on Ubuntu 16.04?

```
dockerworxinc@instance-1:~$ cat /etc/os-release
NAME="Ubuntu"
VERSION="16.04.4 LTS (Xenial Xerus)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 16.04.4 LTS"
VERSION_ID="16.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=xenial
UBUNTU_CODENAME=xenial
```

For Ubuntu 16.04 and higher, the Linux kernel includes support for overlay2, and Docker EE uses it as the default storage driver. 
If you need to use aufs instead, you need to configure it manually. 

```
sudo apt update
```

```
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
```

## Adding DOCKER_EE_URL variable

You can temporarily add a $DOCKER_EE_URL variable into your environment. 
This only persists until you log out of the session. Replace <DOCKER-EE-URL> with the URL you noted down in the prerequisites.

```
DOCKER_EE_URL=stable-18.03
76d"
```

## 

```
curl -fsSL "${DOCKER_EE_URL}/ubuntu/gpg" | sudo apt-key add -
OK
```

##

Verify that you now have the key with the fingerprint DD91 1E99 5A64 A202 E859 07D6 BC14 F10B 6D08 5F96, by searching for the last eight characters of the fingerprint. Use the command as-is. 
It works because of the variable you set earlier.


```
sudo apt-key fingerprint 6D085F96
pub   4096R/6D085F96 2017-02-22
      Key fingerprint = DD91 1E99 5A64 A202 E859  07D6 BC14 F10B 6D08 5F96
uid                  Docker Release (EE deb) <docker@docker.com>
sub   4096R/91A29FA3 2017-02-22
```

##

Use the following command to set up the stable repository. Use the command as-is. It works because of the variable you set earlier.


```
$ sudo add-apt-repository \
>    "deb [arch=amd64] $DOCKER_EE_URL/ubuntu \
>    $(lsb_release -cs) \
>    $DOCKER_EE_VERSION"
```

## Run the below commands:

```

apt update
apt install docker-ee

```

## Verifying Docker Version

```
$ docker version
Client:
 Version:      18.03.1-ee-2
 API version:  1.37
 Go version:   go1.10.2
 Git commit:   ebbcd7e
 Built:        Tue Jul 10 21:36:16 2018
 OS/Arch:      linux/amd64
 Experimental: false
Server:
 Engine:
  Version:      18.03.1-ee-2
  API version:  1.37 (minimum version 1.12)
  Go version:   go1.10.2
  Git commit:   ebbcd7e
  Built:        Tue Jul 10 21:34:20 2018
  OS/Arch:      linux/amd64
  Experimental: false

```


## 

On production systems, you should install a specific version of Docker EE instead of always using the latest. This output is truncated. List the available versions.

```
$ apt-cache madison docker-ee
 docker-ee | 3:18.03.1~ee~2~3-0~ubuntu | https://storebits.docker.com/ee/ubuntu/sub-6f046f55-8d6c-4dfb-a5b0-06d710c8676
d/ubuntu xenial/stable-18.03 amd64 Packages
 docker-ee | 3:18.03.1~ee~1~3-0~ubuntu | https://storebits.docker.com/ee/ubuntu/sub-6f046f55-8d6c-4dfb-a5b0-06d710c8676
d/ubuntu xenial/stable-18.03 amd64 Packages


```

##

```
$ sudo docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
9db2ca6ccae0: Pull complete 
Digest: sha256:4b8ff392a12ed9ea17784bd3c9a8b1fa3299cac44aca35a85c90c5e3c7afacdc
Status: Downloaded newer image for hello-world:latest
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
 https://docs.docker.com/engine/userguide/

```

##  Manage Docker as a non-root user

The docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user root and other users can only access it using sudo. ```The docker daemon always runs as the root user.```

If you don’t want to use sudo when you use the docker command, create a Unix group called docker and add users to it. When the docker daemon starts, it makes the ownership of the Unix socket read/writable by the docker group.

## Configure Docker to start on boot

Most current Linux distributions (RHEL, CentOS, Fedora, Ubuntu 16.04 and higher) use systemd to manage which services start when the system boots. Ubuntu 14.10 and below use upstart.

## systemd

```
$ sudo systemctl enable docker
````

To disable this behavior, use disable instead.

```
$ sudo systemctl disable docker
```

If you need to add an HTTP Proxy, set a different directory or partition for the Docker runtime files, or make other customizations, see customize your systemd Docker daemon options.

## upstart

Docker is automatically configured to start on boot using upstart. To disable this behavior, use the following command:

```
$ echo manual | sudo tee /etc/init/docker.override
```
## chkconfig

```
$ sudo chkconfig docker on
```

