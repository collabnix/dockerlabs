# How to install Helm on Docker Desktop for Mac


## Pre-requisite:

- Ensure that Helm is properly installed
- Ensure that ```helm version``` displays error-free output 


## Note: In case you encounter the below error message:

```
[Captains-Bay]🚩 >  helm version
Client: &version.Version{SemVer:"v2.12.1", GitCommit:"02a47c7249b1fc6d8fd3b94e6b4babf9d818144e", GitTreeState:"clean"}
Error: could not find tiller
```

Follow the below steps to fix the issue:

```
[Captains-Bay]🚩 >  helm init --service-account tiller
$HELM_HOME has been configured at /Users/ajeetraina/.helm.

Tiller (the Helm server-side component) has been installed into your Kubernetes Cluster.

Please note: by default, Tiller is deployed with an insecure 'allow unauthenticated users' policy.
To prevent this, run `helm init` with the --tiller-tls-verify flag.
For more information on securing your installation see: https://docs.helm.sh/using_helm/#securing-your-helm-installation
Happy Helming!
```

```
[Captains-Bay]🚩 >  kubectl -n kube-system get pods
NAME                                     READY     STATUS    RESTARTS   AGE
coredns-5c98db65d4-pdzb7                 1/1       Running   1          10d
coredns-5c98db65d4-v6trh                 1/1       Running   1          10d
etcd-docker-desktop                      1/1       Running   0          10d
kube-apiserver-docker-desktop            1/1       Running   0          10d
kube-controller-manager-docker-desktop   1/1       Running   0          10d
kube-proxy-fcmq9                         1/1       Running   0          10d
kube-scheduler-docker-desktop            1/1       Running   0          10d
```

```
[Captains-Bay]🚩 >  kubectl -n kube-system delete deployment tiller-deploy
deployment "tiller-deploy" deleted
```

```
[Captains-Bay]🚩 >  kubectl -n kube-system delete service/tiller-deploy
service "tiller-deploy" deleted
```

```
[Captains-Bay]🚩 >  helm init
$HELM_HOME has been configured at /Users/ajeetraina/.helm.

Tiller (the Helm server-side component) has been installed into your Kubernetes Cluster.

Please note: by default, Tiller is deployed with an insecure 'allow unauthenticated users' policy.
To prevent this, run `helm init` with the --tiller-tls-verify flag.
For more information on securing your installation see: https://docs.helm.sh/using_helm/#securing-your-helm-installation
Happy Helming!
```

Please wait for 1 min to get the below output working:

```
[Captains-Bay]🚩 >  helm version
Client: &version.Version{SemVer:"v2.12.1", GitCommit:"02a47c7249b1fc6d8fd3b94e6b4babf9d818144e", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.12.1", GitCommit:"02a47c7249b1fc6d8fd3b94e6b4babf9d818144e", GitTreeState:"clean"}
[Captains-Bay]🚩 >
```
