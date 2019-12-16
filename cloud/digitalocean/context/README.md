# Building & Managing Containerized Application on Cloud Platform

Pre-requisite:

- Docker Desktop for Mac 2.1.7.0+
- Install doctl - doctl is a command line interface for the DigitalOcean API.

```
brew install doctl
```

## Method #1: Using doctl

```
[Captains-Bay]🚩 >  doctl auth init
Using token [<>]

Validating token... OK

[Captains-Bay]🚩 > 
```

## Retrieving DO Account Information

```
[Captains-Bay]🚩 >  doctl account get
Email                    Droplet Limit    Email Verified    UUID                                    Status
contact@collabnix.com    10               true              e0786fe2-d4f5-4d54-9e67-47db69390f46    active
[Captains-Bay]🚩 >
```

## Interacting with all your DO resources

doctl is able to interact with all of your DigitalOcean resources. Below are a few common usage examples.

```
[Captains-Bay]🚩 >  doctl compute droplet list
ID    Name    Public IPv4    Private IPv4    Public IPv6    Memory    VCPUs    Disk    Region    Image    Status    Tags    Features    Volumes
[Captains-Bay]🚩 >  
```

## Creating a new Debian Instance

```
doctl compute droplet create test --size s-1vcpu-1gb    --image debian-10-x64 --region nyc1
```

```
[Captains-Bay]🚩 >  doctl compute droplet list
ID           Name    Public IPv4        Private IPv4    Public IPv6    Memory    VCPUs    Disk    Region    Image              Status    Tags    Features    Volumes
171726228    test    206.189.207.163                                   1024      1        25      nyc1      Debian 10.0 x64    active    
```


```
[Captains-Bay]🚩 >  doctl compute droplet list --format "ID,Name,PublicIPv4"
ID           Name    Public IPv4
171726228    test    206.189.207.163
```

## Method-2: Using Docker Machine

- Grab the token from DO site

## Bring up Node #1

```
 docker-machine create --driver digitalocean --digitalocean-access-token 3xxxxxx49ab97229d node1
 ```
 
 ## Bring up Node #2
 
 ```
  docker-machine create --driver digitalocean --digitalocean-access-token 3xxxxxff149ab97229d node2
  ```
  
  


```
[Captains-Bay]🚩 >  sudo docker context create --docker host=tcp://68.183.148.254:2375 mydo
Password:
mydo
Successfully created context "mydo"
[Captains-Bay]🚩 >  
[Captains-Bay]🚩 >  sudo docker context create --docker host=tcp://68.183.148.254:2375 mydo
[Captains-Bay]🚩 >  docker context ls
NAME                DESCRIPTION                               DOCKER ENDPOINT               KUBERNETES ENDPOINT                                 ORCHESTRATOR
default *           Current DOCKER_HOST based configuration   unix:///var/run/docker.sock   https://kubernetes.docker.internal:6443 (default)   kubernetes
mydo                                                          tcp://68.183.148.254:2375                                                         
[Captains-Bay]🚩 >  docker context use mydo
mydo
Current context is now "mydo"


[Captains-Bay]🚩 >  docker context ls
NAME                DESCRIPTION                               DOCKER ENDPOINT               KUBERNETES ENDPOINT                                 ORCHESTRATOR
default             Current DOCKER_HOST based configuration   unix:///var/run/docker.sock   https://kubernetes.docker.internal:6443 (default)   kubernetes
mydo *                                                        tcp://68.183.148.254:2375                                                         
[Captains-Bay]🚩 >  docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
egv05txt4wh96k9tt454jkbt7 *   instance1           Ready               Active              Leader              19.03.5
[Captains-Bay]🚩 >  docker run -dit -p 8:80 nginx
1ddf3e3afacd726a87c964c6672f628235077c1b9b2bd74e3b13d6ebfa946896
[Captains-Bay]🚩 >  docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
1ddf3e3afacd        nginx               "nginx -g 'daemon of…"   28 seconds ago      Up 26 seconds       0.0.0.0:8->80/tcp   pedantic_kirch
[Captains-Bay]🚩 >  docker stop 1dd
1dd
[Captains-Bay]🚩 >  docker run -dit -p 80:80 ajeetraina/hellowhale
Unable to find image 'ajeetraina/hellowhale:latest' locally
latest: Pulling from ajeetraina/hellowhale
2a72cbf407d6: Pull complete 
04b2d3302d48: Pull complete 
e7f619103861: Pull complete 
6908ed4fc6be: Pull complete 
7d43bcbaf300: Pull complete 
Digest: sha256:50e5d8b034ff3a0d537224e332da0ee74e393df36acefa6859daba58712ad1f4
Status: Downloaded newer image for ajeetraina/hellowhale:latest
413b0d8630c719495ed555b6e6f31038e50e4ed5b64195b149cf4dc5d99163f6
[Captains-Bay]🚩 >  

```
