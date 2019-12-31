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

```
[Captains-Bay]🚩 >  k3sup install --ip $IP --user jetson
Running: k3sup install
Public IP: 192.168.1.7
ssh -i /Users/ajeetraina/.ssh/id_rsa -p 22 jetson@192.168.1.7
ssh: curl -sLS https://get.k3s.io | INSTALL_K3S_EXEC='server  --tls-san 192.168.1.7 ' INSTALL_K3S_VERSION='v1.0.1' sh -

[INFO]  Using v1.0.1 as release
[INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v1.0.1/sha256sum-arm64.txt
[INFO]  Downloading binary https://github.com/rancher/k3s/releases/download/v1.0.1/k3s-arm64
[INFO]  Verifying binary download
[INFO]  Installing k3s to /usr/local/bin/k3s
sudo: no tty present and no askpass program specified
Error: Error received processing command: Process exited with status 1
[Captains-Bay]🚩 >
```


