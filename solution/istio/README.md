
# Setting up Istio Mesh on Docker Enterprise 2.1

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

```$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
ba4a5822d7c9        nginx               "nginx -g 'daemon of…"   5 seconds ago       Up 3 seconds        0.0.0.0:80->80/tcp   peaceful_swanson
```
## Verifying Nginx Docker container Up and Running

```
~$ sudo curl localhost:80
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
:~$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
ba4a5822d7c9        nginx               "nginx -g 'daemon of…"   6 minutes ago       Up 6 minutes        0.0.0.0:80->80/tcp   peaceful_swanson
```


## Installing UCP on Docker Enterprise 18.09

Ensure that you authenticate your DockerHub ID

```
docker login
```

Now installing UCP containers

```
sudo docker container run --rm -it --name ucp   -v /var/run/docker.sock:/var/run/docker.sock   docker/ucp:3.0.5 install   --host-address 10.140.0.2 --interactive
INFO[0000] Your engine version 18.09.0, build 33a45cd (4.18.0-1003-gcp) is compatible with UCP 3.0.5 (f588f8a) 
Admin Username: ajeetraina
Admin Password: 
Confirm Admin Password: 
INFO[0010] Pulling required images... (this may take a while) 
INFO[0010] Pulling docker/ucp-calico-node:3.0.5         
INFO[0027] Pulling docker/ucp-kube-compose:3.0.5        
INFO[0034] Pulling docker/ucp-kube-dns:3.0.5            
INFO[0041] Pulling docker/ucp-interlock:3.0.5           
INFO[0047] Pulling docker/ucp-auth-store:3.0.5          
INFO[0055] Pulling docker/ucp-calico-cni:3.0.5          
INFO[0069] Pulling docker/ucp-swarm:3.0.5               
INFO[0075] Pulling docker/ucp-kube-dns-dnsmasq-nanny:3.0.5 
INFO[0083] Pulling docker/ucp-dsinfo:3.0.5              
INFO[0094] Pulling docker/ucp-interlock-extension:3.0.5 
INFO[0100] Pulling docker/ucp-metrics:3.0.5             
INFO[0111] Pulling docker/ucp-interlock-proxy:3.0.5     
INFO[0115] Pulling docker/ucp-compose:3.0.5             
INFO[0119] Pulling docker/ucp-kube-dns-sidecar:3.0.5    
WARN[0126] None of the hostnames we'll be using in the UCP certificates [master1 127.0.0.1 172.17.0.1 10.140.0.2] contain a domain component.  Your generated certs may fail TLS validation unless you only use one of these shortnames or IPs to connect.  You can use the --san flag to add more aliases 

You may enter additional aliases (SANs) now or press enter to proceed with the above list.
Additional aliases: 
INFO[0000] Initializing a new swarm at 10.140.0.2       
INFO[0012] Installing UCP with host address 10.140.0.2 - If this is incorrect, please specify an alternative address with the '--host-address' flag 
INFO[0012] Deploying UCP Service...                                            
```

```
$ sudo docker ps
CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS              PORTS                     NAMES
2d2be5e7607f        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:12385->2376/tcp   ucp-port-check-12385
ebc31eda7d89        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:443->2376/tcp     ucp-port-check-443
7a13db7fcafe        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:12379->2376/tcp   ucp-port-check-12379
85c8835226c6        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:10250->2376/tcp   ucp-port-check-10250
be0cf0aa7830        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:2376->2376/tcp    ucp-port-check-2376
f863aa01bb85        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:12382->2376/tcp   ucp-port-check-12382
2006264a610b        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:12381->2376/tcp   ucp-port-check-12381
04193f7e2210        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:12386->2376/tcp   ucp-port-check-12386
08587fa666c8        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:6443->2376/tcp    ucp-port-check-6443
a27d31dd6171        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:12384->2376/tcp   ucp-port-check-12384
d51348228baf        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:12380->2376/tcp   ucp-port-check-12380
d9ca5b998809        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:12378->2376/tcp   ucp-port-check-12378
6ea257fbad25        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:12383->2376/tcp   ucp-port-check-12383
8ba653aba34c        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:179->2376/tcp     ucp-port-check-179
642cadfc12a2        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:6444->2376/tcp    ucp-port-check-6444
5e5fc72f805e        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:12376->2376/tcp   ucp-port-check-12376
60559cf03467        docker/ucp-agent:3.0.5   "/bin/ucp-agent test…"   23 minutes ago      Up 23 minutes       0.0.0.0:12387->2376/tcp   ucp-port-check-12387
ba4a5822d7c9        nginx                    "nginx -g 'daemon of…"   2 hours ago         Up 2 hours          0.0.0.0:80->80/tcp        peaceful_swanson
```


