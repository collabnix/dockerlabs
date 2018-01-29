# Running Minikube & Docker for Mac side by side

Pre-requisites:

Minikube requires that VT-x/AMD-v virtualization is enabled in BIOS. To check that this is enabled on OSX / macOS run:

```
sysctl -a | grep machdep.cpu.features | grep VMX
```

## Installing Minikube via brew

```
Ajeets-MacBook-Air:~ ajeetraina$ brew update && brew install kubectl && brew cask install minikube
```

## Starting Minikube
```
Ajeets-MacBook-Air:~ ajeetraina$ minikube start
Starting local Kubernetes v1.9.0 cluster...
Starting VM...
Downloading Minikube ISO
 142.22 MB / 142.22 MB [============================================] 100.00% 0s
Getting VM IP address...
Moving files into cluster...
Downloading localkube binary
 50.95 MB / 162.41 MB [=============>----------------------------]  31.37% 3m26s
 ```
