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
 
 ```
 docker swarm init --advertise-addr <public_ip> --listen-addr <public_ip>
 ```
 
 
 ## Bring up Node #2
 
 ```
  docker-machine create --driver digitalocean --digitalocean-access-token 3xxxxxff149ab97229d node2
  ```
  
  ```
  docker swarm join <>
  ```
  
  
  
  
  ## Using docker context
  
  
```
sudo systemctl edit docker.service
```

Add the below entry:

```
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock -H tcp://10.140.0.6:2375
```

```
sudo systemctl daemon-reload Restart Docker.
sudo systemctl restart docker.service
```



```
[Captains-Bay]🚩 >  sudo docker context create --docker host=tcp://167.71.181.46:2375 mydot
mydot
Successfully created context "mydot"
[Captains-Bay]🚩 >  sudo docker context ls
NAME                DESCRIPTION                               DOCKER ENDPOINT               KUBERNETES ENDPOINT                                 ORCHESTRATOR
default *           Current DOCKER_HOST based configuration   unix:///var/run/docker.sock   https://kubernetes.docker.internal:6443 (default)   kubernetes
mydo                                                          tcp://68.183.148.254:2375                                                         
mydot                                                         tcp://167.71.181.46:2375                                                          
[Captains-Bay]🚩 >  sudo docker context use mydot
mydot
Current context is now "mydot"
[Captains-Bay]🚩 >  sudo docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
w7p4ezqbk13ks4y3sor4ppeml *   demo1               Ready               Active              Leader              19.03.5
dia0ylrodgbn0n1zcv7ckel8n     demo2               Ready               Active                                  19.03.5
```



