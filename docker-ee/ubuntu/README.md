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

```


```

##

```


```
