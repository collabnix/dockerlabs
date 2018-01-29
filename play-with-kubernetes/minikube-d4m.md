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
 162.41 MB / 162.41 MB [============================================] 100.00% 0s
 0 B / 65 B [----------------------------------------------------------]   0.00%
 65 B / 65 B [======================================================] 100.00% 0sSetting up certs...
Connecting to cluster...
Setting up kubeconfig...
Starting cluster components...
Kubectl is now configured to use the cluster.
Loading cached images from config file.
 ```
 
 # Viewing Kubernetes context selection pane
 
 By now, you should see minikube context appear 
 
 # Verifying it using CLI
 
 ```
 Ajeets-MacBook-Air:~ ajeetraina$ kubectl config get-contexts
CURRENT   NAME                          CLUSTER                      AUTHINFO             NAMESPACE
          docker-for-desktop            docker-for-desktop-cluster   docker-for-desktop
          gce                                                        cluster-admin
          kubernetes-admin@kubernetes   kubernetes                   kubernetes-admin
*         minikube                      minikube                     minikube
```


 

