# Getting Started with K3sup

## Pre-Requisite:

- Macbook


## Steps:

```
[Captains-Bay]🚩 >  curl -sSL https://get.k3sup.dev | sh
Downloading package https://github.com/alexellis/k3sup/releases/download/0.6.6/k3sup-darwin as /Users/ajeetraina/k3sup-darwin
Download complete.

Running with sufficient permissions to attempt to move k3sup to /usr/local/bin
New version of k3sup installed to /usr/local/bin
 _    _____                 
| | _|___ / ___ _   _ _ __  
| |/ / |_ \/ __| | | | '_ \ 
|   < ___) \__ \ |_| | |_) |
|_|\_\____/|___/\__,_| .__/ 
                     |_|    
Version: 0.6.6
Git Commit: 4cd8eaa6dfc03c564c3a88f6c5325540c9aab148
[Captains-Bay]🚩 > 
```

## Enable PasswordlessSSH


```
[Captains-Bay]🚩 >  ssh-copy-id ~/.ssh/id_rsa.pub jetson@192.16ç8.1.6:/home/jetson/.ssh/id_rsa.pub
[Captains-Bay]🚩 >  scp id_rsa.pub jetson@192.168.1.6:.ssh/authorized_keys
```

## 

```
[Captains-Bay]🚩 >  k3sup install --ip 192.168.1.6 --user jetson
Public IP: 192.168.1.6
ssh -i /Users/ajeetraina/.ssh/id_rsa jetson@192.168.1.6
ssh: curl -sLS https://get.k3s.io | INSTALL_K3S_EXEC='server --tls-san 192.168.1.6 ' INSTALL_K3S_VERSION='v1.0.0' sh -

[INFO]  Using v1.0.0 as release
[INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v1.0.0/sha256sum-arm64.txt
[INFO]  Downloading binary https://github.com/rancher/k3s/releases/download/v1.0.0/k3s-arm64
[INFO]  Verifying binary download
sudo: no tty present and no askpass program specified
[INFO]  Installing k3s to /usr/local/bin/k3s
```
