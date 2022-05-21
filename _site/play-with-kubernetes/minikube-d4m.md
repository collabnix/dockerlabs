# Demonstrating Context Selection Switching between Minikube & K8s powered Docker for Mac 18.02 RC

Under this tutorial, we will first install minikube on plain Docker for Mac 18.02 RC1 build. We can go ahead and run Docker Swarm on top of it. Then we will switch the context to docker-for-desktop and then enable Kubernetes to get kubernetes cluster up and running

# Step-1 : Running Minikube

## Pre-requisites:

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

# Step-2 - Initializing Docker Swarm 

```
Ajeets-MacBook-Air:testenviron ajeetraina$ docker swarm init
Swarm initialized: current node (zfxiqqjpjmwbvhm1ahjwio3s7) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-4vnxn6cbq4gtsjjvaluucncc8m71aexe11dhbm40aoxfqnr7s3-bevjmv2qpklluuhm6ufrfoas2 192.168.65.3:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

Ajeets-MacBook-Air:testenviron ajeetraina$ docker node ls
ID                            HOSTNAME                STATUS              AVAILABILITY        MANAGER STATUS
zfxiqqjpjmwbvhm1ahjwio3s7 *   linuxkit-025000000001   Ready               Active              Leader
Ajeets-MacBook-Air:testenviron ajeetraina$ docker stack deploy -c docker-compose.yml myapp3
Creating network myapp3_default
Creating service myapp3_db1
Creating service myapp3_web1
Ajeets-MacBook-Air:testenviron ajeetraina$ docker stack ls
NAME                SERVICES
myapp3              2
```

# Step-3: Switching the context from Minikube to docker-for-desktop

```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl config get-contexts
CURRENT   NAME                          CLUSTER                      AUTHINFO             NAMESPACE
          docker-for-desktop            docker-for-desktop-cluster   docker-for-desktop
          gce                                                        cluster-admin
          kubernetes-admin@kubernetes   kubernetes                   kubernetes-admin
*         minikube                      minikube                     minikube
Ajeets-MacBook-Air:testenviron ajeetraina$ docker swarm init
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl config use-context docker-for-desktop
Switched to context "docker-for-desktop".
```

# Verifying through Pane UI

Open up whale icon under D4M and see if the context switched successfully

# Enabling Kubernetes

Go to whale icon > Click on Preference > Click on Kubernetes > Enable Kubernetes > Show Systems Containers

It will take few minutes to get Kubernetes up and running




 

