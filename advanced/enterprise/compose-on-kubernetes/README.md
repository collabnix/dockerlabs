

```
[Captains-Bay]🚩 >  docker version
Client: Docker Engine - Community
 Version:           18.09.0
 API version:       1.39
 Go version:        go1.10.4
 Git commit:        4d60db4
 Built:             Wed Nov  7 00:47:43 2018
 OS/Arch:           darwin/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.0
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.4
  Git commit:       4d60db4
  Built:            Wed Nov  7 00:55:00 2018
  OS/Arch:          linux/amd64
  Experimental:     true
 Kubernetes:
  Version:          v1.10.3
  StackAPI:         v1beta2
 ```
 
```
[Captains-Bay]🚩 >  gcloud auth login
Your browser has been opened to visit:

    https://accounts.google.com/o/oauth2/auth?redirect_uri=http%3A%2F%2Flocalhost%3A8085%2F&prompt=select_account&response_type=code&client_id=32555940559.apps.googleusercontent.com&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcloud-platform+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fappengine.admin+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcompute+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Faccounts.reauth&access_type=offline


WARNING: `gcloud auth login` no longer writes application default credentials.
If you need to use ADC, see:
  gcloud auth application-default --help

You are now logged in as [joginderkour1950@gmail.com].
Your current project is [None].  You can change this setting by running:
  $ gcloud config set project PROJECT_ID


Updates are available for some Cloud SDK components.  To install them,
please run:
  $ gcloud components update

[Captains-Bay]🚩 >
```


## Run on macOS

```
[Captains-Bay]🚩 >
s-central1-a --project sturdy-pivot-225203rs get-credentials mycluster --zone u
Fetching cluster endpoint and auth data.
kubeconfig entry generated for mycluster.
[Captains-Bay]🚩 >
```

## 

```
[Captains-Bay]🚩 >  kubectl get nodes
NAME                                 STATUS    ROLES     AGE       VERSION
gke-mycluster-pool-1-c1fb7d56-kjbf   Ready     <none>    5m        v1.10.9-gke.5
[Captains-Bay]🚩 >
```

##

```
[Captains-Bay]🚩 >  kubectl create namespace compose
namespace "compose" created
[Captains-Bay]🚩 >

```

##

```
[Captains-Bay]🚩 >  kubectl -n kube-system create serviceaccount tiller
serviceaccount "tiller" created
usterrole cluster-admin --serviceaccount kube-system:tillerebinding tiller --cl
clusterrolebinding "tiller" created
[Captains-Bay]🚩 >  helm init --service-account tiller
$HELM_HOME has been configured at /Users/ajeetraina/.helm.

Tiller (the Helm server-side component) has been installed into your Kubernetes Cluster.

Please note: by default, Tiller is deployed with an insecure 'allow unauthenticated users' policy.
For more information on securing your installation see: https://docs.helm.sh/using_helm/#securing-your-helm-installation
Happy Helming!
espace compose🚩 >  helm install --name etcd-operator stable/etcd-operator --nam
NAME:   etcd-operator
LAST DEPLOYED: Tue Dec 11 09:10:05 2018
NAMESPACE: compose
STATUS: DEPLOYED

RESOURCES:
==> v1beta1/ClusterRole
NAME                                       AGE
etcd-operator-etcd-operator-etcd-operator  2s

==> v1beta1/ClusterRoleBinding
NAME                                               AGE
etcd-operator-etcd-operator-etcd-backup-operator   2s
etcd-operator-etcd-operator-etcd-operator          2s
etcd-operator-etcd-operator-etcd-restore-operator  2s

==> v1/Service
NAME                   TYPE       CLUSTER-IP     EXTERNAL-IP  PORT(S)    AGE
etcd-restore-operator  ClusterIP  10.23.242.119  <none>       19999/TCP  2s

==> v1beta1/Deployment
NAME                                               DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
etcd-operator-etcd-operator-etcd-backup-operator   1        1        1           0          2s
etcd-operator-etcd-operator-etcd-operator          1        1        1           0          1s
etcd-operator-etcd-operator-etcd-restore-operator  1        1        1           0          1s

==> v1/Pod(related)
NAME                                                             READY  STATUS             RESTARTS  AGE
etcd-operator-etcd-operator-etcd-backup-operator-687bb97bfz6gpr  0/1    ContainerCreating  0         1s
etcd-operator-etcd-operator-etcd-operator-cdd58665b-bhk4w        0/1    ContainerCreating  0         1s
etcd-operator-etcd-operator-etcd-restore-operator-65585cb5psjw8  0/1    ContainerCreating  0         1s

==> v1/ServiceAccount
NAME                                               SECRETS  AGE
etcd-operator-etcd-operator-etcd-backup-operator   1        2s
etcd-operator-etcd-operator-etcd-operator          1        2s
etcd-operator-etcd-operator-etcd-restore-operator  1        2s


NOTES:
1. etcd-operator deployed.
  If you would like to deploy an etcd-cluster set cluster.enabled to true in values.yaml
  Check the etcd-operator logs
    export POD=$(kubectl get pods -l app=etcd-operator-etcd-operator-etcd-operator --namespace compose --output name)
    kubectl logs $POD --namespace=compose
[Captains-Bay]🚩 >

```

##


```

[Captains-Bay]🚩 >  cat compose-etcd.yaml
apiVersion: "etcd.database.coreos.com/v1beta2"
kind: "EtcdCluster"
metadata:
  name: "compose-etcd"
  namespace: "compose"
spec:
  size: 3
  version: "3.2.13"
[Captains-Bay]🚩 >

```

## 

```
[Captains-Bay]🚩 >  kubectl apply -f compose-etcd.yaml
etcdcluster "compose-etcd" created
```

##

```


```



