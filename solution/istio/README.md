
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
