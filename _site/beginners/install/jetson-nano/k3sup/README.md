# Setting up k3sup on macOS to build K3s Cluster remotely on Jetson Nano

# Pre-requisite:

- 2x Jetson Boards 
   - Board1: 192.168.1.7
   - Board2: 192.168.1.8


# Configuring Passwordless SSH from macOS




```
[Captains-Bay]🚩 >  ssh jetson@192.168.1.7
Welcome to Ubuntu 18.04.2 LTS (GNU/Linux 4.9.140-tegra aarch64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

191 packages can be updated.
0 updates are security updates.

Last login: Tue Dec 31 11:24:01 2019 from 192.168.1.6
jetson@master1:~$
```


```
[Captains-Bay]🚩 >  curl -sLS https://get.k3sup.dev | sudo sh
Downloading package https://github.com/alexellis/k3sup/releases/download/0.7.0/k3sup-darwin as /tmp/k3sup-darwin
Download complete.

Running with sufficient permissions to attempt to move k3sup to /usr/local/bin
New version of k3sup installed to /usr/local/bin
 _    _____                 
| | _|___ / ___ _   _ _ __  
| |/ / |_ \/ __| | | | '_ \ 
|   < ___) \__ \ |_| | |_) |
|_|\_\____/|___/\__,_| .__/ 
                     |_|    
Version: 0.7.0
Git Commit: 4f2b04cb317ce6840c8151fed56e0114979129b8
[Captains-Bay]🚩 >  
```


```
[Captains-Bay]🚩 >  k3sup --help
Usage:
  k3sup [flags]
  k3sup [command]

Available Commands:
  app         Manage Kubernetes apps
  help        Help about any command
  install     Install k3s on a server via SSH
  join        Install the k3s agent on a remote host and join it to an existing server
  update      Print update instructions
  version     Print the version

Flags:
  -h, --help   help for k3sup

Use "k3sup [command] --help" for more information about a command.
[Captains-Bay]🚩 > 
```

# Creating a user

Let's create a user by name "ajeetraina" on Jetson boards

```
root@master1:~# adduser ajeetraina
Adding user `ajeetraina' ...
Adding new group `ajeetraina' (1001) ...
Adding new user `ajeetraina' (1001) with group `ajeetraina' ...
Creating home directory `/home/ajeetraina' ...
Copying files from `/etc/skel' ...
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
Changing the user information for ajeetraina
Enter the new value, or press ENTER for the default
	Full Name []: Ajeet Raina
	Room Number []: 
	Work Phone []: 
	Home Phone []: 
	Other []: 
Is the information correct? [Y/n] Y
Adding new user `ajeetraina' to extra groups ...
Adding user `ajeetraina' to group `audio' ...
Adding user `ajeetraina' to group `video' ...
Adding user `ajeetraina' to group `gdm' ...
Adding user `ajeetraina' to group `weston-launch' ...
```

```
root@master1:~# id ajeetraina
uid=1001(ajeetraina) gid=1001(ajeetraina) groups=1001(ajeetraina),29(audio),44(video),124(gdm),999(weston-launch)
```

## Adding user to sudo Group

Use the usermod command to add the user to the sudo group.


```
root@master1:~# usermod -aG sudo ajeetraina
root@master1:~# su - ajeetraina
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
```


## Making entry for this user under /etc/sudoers

It's not recommended to edit the sudoers file directly but using visudo as shown below:

```
root@master1:~# visudo
root@master1:~# 

```

Add the below entry at the end of the file.

```
ajeetraina ALL=(ALL:ALL) NOPASSWD:ALL
```

## Configuring Passwordless SSH


```
ssh-keygen -t rsa
```

```
ssh-copy-id -i ~/.ssh/id_rsa.pub ajeetraina@192.168.1.7
```

## Installing k3s on remote Jetson Master Node

```
[Captains-Bay]🚩 >  k3sup install --ip 192.168.1.7 --user ajeetraina
Running: k3sup install
Public IP: 192.168.1.7
ssh -i /Users/ajeetraina/.ssh/id_rsa -p 22 ajeetraina@192.168.1.7
ssh: curl -sLS https://get.k3s.io | INSTALL_K3S_EXEC='server  --tls-san 192.168.1.7 ' INSTALL_K3S_VERSION='v1.0.1' sh -

[INFO]  Using v1.0.1 as release
[INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v1.0.1/sha256sum-arm64.txt
[INFO]  Skipping binary downloaded, installed k3s matches hash
[INFO]  Skipping /usr/local/bin/kubectl symlink to k3s, already exists
[INFO]  Skipping /usr/local/bin/crictl symlink to k3s, already exists
[INFO]  Skipping /usr/local/bin/ctr symlink to k3s, command exists in PATH at /usr/bin/ctr
[INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
[INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
[INFO]  env: Creating environment file /etc/systemd/system/k3s.service.env
[INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
[INFO]  systemd: Enabling k3s unit
Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.
[INFO]  No change detected so skipping service start
Result: [INFO]  Using v1.0.1 as release
[INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v1.0.1/sha256sum-arm64.txt
[INFO]  Skipping binary downloaded, installed k3s matches hash
[INFO]  Skipping /usr/local/bin/kubectl symlink to k3s, already exists
[INFO]  Skipping /usr/local/bin/crictl symlink to k3s, already exists
[INFO]  Skipping /usr/local/bin/ctr symlink to k3s, command exists in PATH at /usr/bin/ctr
[INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
[INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
[INFO]  env: Creating environment file /etc/systemd/system/k3s.service.env
[INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
[INFO]  systemd: Enabling k3s unit
[INFO]  No change detected so skipping service start
 Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.

ssh: sudo cat /etc/rancher/k3s/k3s.yaml

apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0XXXXXXXXXXERBUEJnTlZIUk1CQWY4RUJUQURBUUgvTUFvR0NDcUdTTTQ5QkFNQ0EwZ0FNRVVDSVFEMXFIYkVtMzVRCnpNNHcrV0YweExDbm43cjd1a1E0ei9YaXlHTDBOVVFScVFJZ1pzS05RaSs5UVVBTkk1WU0zc1hsT3ZybTh6dEEKRW01ZHlKR2dlT2RuTlpJPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    server: https://127.0.0.1:6443
  name: default
contexts:
- context:
    cluster: default
    user: default
  name: default
current-context: default
kind: Config
preferences: {}
users:
- name: default
  user:
    password: 97xxxxe2xxxxxxxxx12fe45
    username: admin
Result: apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FUxxxxxxxxCg==
    server: https://127.0.0.1:6443
  name: default
contexts:
- context:
    cluster: default
    user: default
  name: default
current-context: default
kind: Config
preferences: {}
users:
- name: default
  user:
    password: 97e226fae2259f251fb75dce0012fe45
    username: admin
 
Saving file to: /Users/ajeetraina/kubeconfig

# Test your cluster with:
export KUBECONFIG=/Users/ajeetraina/kubeconfig
kubectl get node -o wide
[Captains-Bay]🚩 >
```



