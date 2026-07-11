# How to assign Static IP address to a container using Docker Compose

Lab Environment:
- Ubuntu 16.10 OS running on ESXi
- Docker 17.06.0 & Docker Compose installed
- 

## Pre-requisites:

1. Open /etc/default/docker and add the below entry:

```
DOCKER_OPTS="--bridge=br0 --ip-masq=false --iptables=false". 
```

Save the file. Assuming that br0 bridge is already configured.

2. Add the below format to your /etc/network/interface -


```
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    pre-up ip addr flush dev eth0
    address 192.168.0.249
    netmask 255.255.255.0
    gateway 192.168.0.1
```

3. Please note that container should be started with --cap-add=NET_ADMIN --net=bridge. Asso, container's entry script should begin with /etc/init.d/networking start. Also entry script needs to edit or populate /etc/hosts file in order to remove references to Docker-assigned IP.

## Steps:

```
git clone https://github.com/ajeetraina/docker101
cd docker101/networking/static
```

## Running the Docker Compose

```
docker-compose up -d
```

## Verify the service up and running

```
==>docker-compose logs
Attaching to ubuntu-container
==>
```
