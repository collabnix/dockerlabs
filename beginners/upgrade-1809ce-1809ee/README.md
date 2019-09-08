# How to upgrade Docker 18.09 Community Edition to Docker Enterprise 18.09

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Google Cloud Platform</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with Google Cloud Engine (Free Tier)
- Pick up Ubuntu 18.10 as OS instance


## Installing Docker Community Editon 18.09

## Verifying Ubuntu 18.10 release

```
$ cat /etc/os-release
NAME="Ubuntu"
VERSION="18.10 (Cosmic Cuttlefish)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.10"
VERSION_ID="18.10"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=cosmic
UBUNTU_CODENAME=cosmic
```

### Installing Docker 18.09 Release

```
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic test"
sudo apt install docker-ce
```

```
~$ sudo docker version
Client:
 Version:           18.09.0
 API version:       1.39
 Go version:        go1.10.4
 Git commit:        4d60db4
 Built:             Wed Nov  7 00:49:01 2018
 OS/Arch:           linux/amd64
 Experimental:      false
Server: Docker Engine - Community
 Engine:
  Version:          18.09.0
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.4
  Git commit:       4d60db4
  Built:            Wed Nov  7 00:16:44 2018
  OS/Arch:          linux/amd64
  Experimental:     false
```
  
## Running Nginx Docker container

```
$ sudo docker run -d -p 80:80 nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
a5a6f2f73cd8: Pull complete 
67da5fbcb7a0: Pull complete 
e82455fa5628: Pull complete 
Digest: sha256:31b8e90a349d1fce7621f5a5a08e4fc519b634f7d3feb09d53fac9b12aa4d991
Status: Downloaded newer image for nginx:latest
ba4a5822d7c991c04418b2fbbcadb86057eef4d98ba3f930bff569ac8058468e
```

```
$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
ba4a5822d7c9        nginx               "nginx -g 'daemon of…"   5 seconds ago       Up 3 seconds        0.0.0.0:80->80/tcp   peaceful_swanson
```
## Verifying Nginx Docker container Up and Running

```
~$ sudo curl localhost:80
```

```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>
<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>
<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
  
## Connect your system to DockerHub Account
  
```
$sudo docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: ajeetraina
Password: 
WARNING! Your password will be stored unencrypted in /home/joginderkour1950/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store
Login Succeeded
```

## Downloading Your Docker Enterprise License

- Go to https://store.docker.com/my-content site. 
- Login with your Docker ID.
- Under your profile page, click on "My Content"
- Click on "Setup" to get your Docker Enterprise License
- Download your Docker Enterprise License in your system
- Copy the content of .lic file 
- Create a file called mylicense.lic on your Ubuntu sytem and save it in some location.

## Activate the EE license. You must use sudo even if your user is part of the docker group.

```
$ sudo docker engine activate --license mylicense.lic
License: Quantity: 10 Nodes     Expiration date: 2018-12-10     License is currently active
18.09.0: resolved 
267a9a121ee1: done 
4365cd59d876: done [==================================================>]  1.161kB/1.161kB
7ec4ee35c404: done [==================================================>]   4.55MB/4.55MB
3c60d2c9ddf3: done [==================================================>]  25.71MB/25.71MB
55fa4079a8ab: done [==================================================>]  1.122MB/1.122MB
c5a93cbd4679: done [==================================================>]  333.9kB/333.9kB
e661b0f8ba29: done [==================================================>]   4.82kB/4.82kB
Successfully activated engine.
Restart docker with 'systemctl restart docker' to complete the activation.
```

## Restarting the Docker service

```
$ sudo systemctl restart docker
```

## Verifying Docker Enterprise Version

```
$ sudo docker version
Client:
 Version:           18.09.0
 API version:       1.39
 Go version:        go1.10.4
 Git commit:        4d60db4
 Built:             Wed Nov  7 00:49:01 2018
 OS/Arch:           linux/amd64
 Experimental:      false
Server: Docker Engine - Enterprise
 Engine:
  Version:          18.09.0
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.4
  Git commit:       33a45cd
  Built:            Wed Nov  7 00:17:07 2018
  OS/Arch:          linux/amd64
  Experimental:     false
```

## Verifying if Nginx container is still running

```
joginderkour1950@master1:~$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
ba4a5822d7c9        nginx               "nginx -g 'daemon of…"   6 minutes ago       Up 6 minutes        0.0.0.0:80->80/tcp   peaceful_swanson
```

Cheers ~

## Contributor

- [Ajeet Singh Raina](mailto:ajeetraina@gmail.com)


