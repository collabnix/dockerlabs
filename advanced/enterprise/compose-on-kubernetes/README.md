

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


## To see GKE context on UI, you need to run the below command:

```
[Captains-Bay]🚩 >
gcloud container clusters get-credentials standard-cluster-1 --zone us-central1-a --project sturdy-pivot-225203
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
./installer-darwin -namespace=compose -etcd-servers=http://compose-etcd-client:2379 -tag=v0.4.16
INFO[0001] Checking installation state
INFO[0001] Install image with tag "v0.4.16" in namespace "compose"
panic: clusterroles.rbac.authorization.k8s.io "compose-service" is forbidden: attempt to grant extra privileges: [PolicyRule{APIGroups:[""], Resources:["users"], Verbs:["impersonate"]} PolicyRule{APIGroups:[""], Resources:["groups"], Verbs:["impersonate"]} PolicyRule{APIGroups:[""], Resources:["serviceaccounts"], Verbs:["impersonate"]} PolicyRule{APIGroups:["authentication.k8s.io"], Resources:["*"], Verbs:["impersonate"]} PolicyRule{APIGroups:[""], Resources:["services"], Verbs:["get"]} PolicyRule{APIGroups:[""], Resources:["deployments"], Verbs:["get"]} PolicyRule{APIGroups:[""], Resources:["statefulsets"], Verbs:["get"]} PolicyRule{APIGroups:[""], Resources:["daemonsets"], Verbs:["get"]} PolicyRule{APIGroups:["apps"], Resources:["services"], Verbs:["get"]} PolicyRule{APIGroups:["apps"], Resources:["deployments"], Verbs:["get"]} PolicyRule{APIGroups:["apps"], Resources:["statefulsets"], Verbs:["get"]} PolicyRule{APIGroups:["apps"], Resources:["daemonsets"], Verbs:["get"]} PolicyRule{APIGroups:[""], Resources:["pods"], Verbs:["get"]} PolicyRule{APIGroups:[""], Resources:["pods"], Verbs:["watch"]} PolicyRule{APIGroups:[""], Resources:["pods"], Verbs:["list"]} PolicyRule{APIGroups:[""], Resources:["pods/log"], Verbs:["get"]} PolicyRule{APIGroups:[""], Resources:["pods/log"], Verbs:["watch"]} PolicyRule{APIGroups:[""], Resources:["pods/log"], Verbs:["list"]} PolicyRule{APIGroups:["compose.docker.com"], Resources:["stacks"], Verbs:["*"]} PolicyRule{APIGroups:["compose.docker.com"], Resources:["stacks/owner"], Verbs:["get"]} PolicyRule{APIGroups:["admissionregistration.k8s.io"], Resources:["validatingwebhookconfigurations"], Verbs:["get"]} PolicyRule{APIGroups:["admissionregistration.k8s.io"], Resources:["validatingwebhookconfigurations"], Verbs:["watch"]} PolicyRule{APIGroups:["admissionregistration.k8s.io"], Resources:["validatingwebhookconfigurations"], Verbs:["list"]} PolicyRule{APIGroups:["admissionregistration.k8s.io"], Resources:["mutatingwebhookconfigurations"], Verbs:["get"]} PolicyRule{APIGroups:["admissionregistration.k8s.io"], Resources:["mutatingwebhookconfigurations"], Verbs:["watch"]} PolicyRule{APIGroups:["admissionregistration.k8s.io"], Resources:["mutatingwebhookconfigurations"], Verbs:["list"]} PolicyRule{APIGroups:["apiregistration.k8s.io"], Resources:["apiservices"], ResourceNames:["v1beta1.compose.docker.com"], Verbs:["*"]} PolicyRule{APIGroups:["apiregistration.k8s.io"], Resources:["apiservices"], ResourceNames:["v1beta2.compose.docker.com"], Verbs:["*"]} PolicyRule{APIGroups:["apiregistration.k8s.io"], Resources:["apiservices"], Verbs:["create"]}] user=&{ajeethsraina@gmail.com  [system:authenticated] map[user-assertion.cloud.google.com:[AM6SrXjz6L54zf1yqYO3RrbOiwbxOHBLEr6A+7JhbGB0b46crtNgcevIEOLNBEV6BwPVdc22jnS80nU78tJkHqHBswocvOetoqpTdcbw2lBxD8jezfLsJqet7R74gGAMuVYuPAcIaA2OjZKBaAgAtXQ+TZF249TQ4WUwsgmAJH7jMBHj5X9NxFOkGrtRrU8yjeOCuS11uWJDkV2oxuzT5BB+ILHDXkYUz7Id6JpoDiU=]]} ownerrules=[PolicyRule{APIGroups:["authorization.k8s.io"], Resources:["selfsubjectaccessreviews" "selfsubjectrulesreviews"], Verbs:["create"]} PolicyRule{NonResourceURLs:["/api" "/api/*" "/apis" "/apis/*" "/healthz" "/openapi" "/openapi/*" "/swagger-2.0.0.pb-v1" "/swagger.json" "/swaggerapi" "/swaggerapi/*" "/version" "/version/"], Verbs:["get"]}] ruleResolutionErrors=[]

goroutine 1 [running]:
main.main()
	/root/src/github.com/docker/compose-on-kubernetes/cmd/installer/main.go:105 +0x1da

```


##

```
[Captains-Bay]🚩 >  kubectl api-versions
admissionregistration.k8s.io/v1beta1
apiextensions.k8s.io/v1beta1
apiregistration.k8s.io/v1
apiregistration.k8s.io/v1beta1
apps/v1
apps/v1beta1
apps/v1beta2
authentication.k8s.io/v1
authentication.k8s.io/v1beta1
authorization.k8s.io/v1
authorization.k8s.io/v1beta1
autoscaling/v1
autoscaling/v2beta1
batch/v1
batch/v1beta1
certificates.k8s.io/v1beta1
cloud.google.com/v1beta1
extensions/v1beta1
metrics.k8s.io/v1beta1
networking.k8s.io/v1
policy/v1beta1
rbac.authorization.k8s.io/v1
rbac.authorization.k8s.io/v1beta1
scalingpolicy.kope.io/v1alpha1
storage.k8s.io/v1
storage.k8s.io/v1beta1
v1
[Captains-Bay]🚩 >
```

## Granting Access Rights to User

```
[Captains-Bay]🚩 >  gcloud info | grep Account
Account: [ajeethsraina@gmail.com]
[Captains-Bay]🚩 >  kubectl create clusterrolebinding myname-cluster-admin-binding --clusterrole=cluster-admin --user=ajeethsraina@gmail.com
clusterrolebinding "myname-cluster-admin-binding" created
[Captains-Bay]🚩 >  k./installer-darwin -namespace=compose -etcd-servers=http://compose-etcd-client:2379 -tag=v0.4.16
INFO[0001] Checking installation state
INFO[0001] Install image with tag "v0.4.16" in namespace "compose"
INFO[0005] Api server: image: "docker/kube-compose-api-server:v0.4.16", pullPolicy: "Always"
INFO[0007] Controller: image: "docker/kube-compose-controller:v0.4.16", pullPolicy: "Always"
[Captains-Bay]🚩 >
```

