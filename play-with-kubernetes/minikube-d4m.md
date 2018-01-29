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
