# Setting up Istio under Play With Kubernetes Platform

## Accessing PWK Platform

Open https://labs.play-with-k8s.com 

# Initialize cluster master node

Click on "Add New Instance" to open up new sandbox environment.

## Bootstrapping the Cluster Master Node

Clone the Repository:

```
git clone https://github.com/ajeetraina/docker101
cd docker101/play-with-kubernetes/istio/
```

Execute the script ```bootstrap.sh``` directly to setup Master Node

```
clear
sh bootstrap.sh
```

Wait for 1 minute time till it gets completed.

Copy the command starting with ```kubeadm join ....```. We will need it to be run on the worker node.


## Setting up Worker Node

Click on "Add New Instance" and paste the last kubeadm command on this fresh new worker node.

```
[node2 ~]$ kubeadm join --token 4f924f.14eb7618a20d2ece 192.168.0.8:6443 --discovery-token-ca-cert-hash  sha256:a5c25aa4573e06a0c11b11df23c8f85c95bae36cbb07d5e7879d9341a3ec67b3```
```

You will see the below output:

```
[kubeadm] WARNING: kubeadm is in beta, please do not use it for production clusters.
[preflight] Skipping pre-flight checks[discovery] Trying to connect to API Server "192.168.0.8:6443"
[discovery] Created cluster-info discovery client, requesting info from "https://192.168.0.8:6443"
[discovery] Requesting info from "https://192.168.0.8:6443" again to validate TLS against the pinned public key
[discovery] Cluster info signature and contents are valid and TLS certificate validates against pinned roots, will use API Server "192.168.0.8:6443"[discovery] Successfully established connection with API Server "192.168.0.8:6443"
[bootstrap] Detected server version: v1.8.15
[bootstrap] The server supports the Certificates API (certificates.k8s.io/v1beta1)
Node join complete:
* Certificate signing request sent to master and response
  received.
* Kubelet informed of new secure connection details.

Run 'kubectl get nodes' on the master to see this machine join.
[node2 ~]$
```

# Verifying Kubernetes Cluster

Run the below command on master node

```
[node1 ~]$ kubectl get nodes
NAME      STATUS    ROLES     AGE       VERSION
node1     Ready     master    15m       v1.10.2
node2     Ready     <none>    1m        v1.10.2
[node1 ~]$
```

## Adding Worker Nodes

```
[node1 ~]$ kubectl get nodes
NAME      STATUS     ROLES     AGE       VERSION
node1     Ready      master    18m       v1.10.2
node2     Ready      <none>    4m        v1.10.2
node3     Ready      <none>    39s       v1.10.2
node4     NotReady   <none>    22s       v1.10.2
node5     NotReady   <none>    4s        v1.10.2[node1 ~]$
```

## Installing Istio Release

```
[node1 ~]$ curl -L https://git.io/getLatestIstio | sh -
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0100  1447  100  1447    0     0   1823      0 --:--:-- --:--:-- --:--:--  1823
Downloading istio-1.0.0 from https://github.com/istio/istio/releases/download/1.0.0/istio-1.0.0-linux.tar.gz ...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   614    0   614    0     0   1102      0 --:--:-- --:--:-- --:--:--  1104
100 14.1M  100 14.1M    0     0  4974k      0  0:00:02  0:00:02 --:--:-- 7532k
Downloaded into istio-1.0.0:
LICENSE  README.md  bin  install  istio.VERSION  samples  tools
Add /root/istio-1.0.0/bin to your path; e.g copy paste in your shell and/or ~/.profile:
export PATH="$PATH:/root/istio-1.0.0/bin"
```

## Setting up PATH variable

```
export PATH=$PWD/bin:$PATH
```

## Installing Istio’s Custom Resource Definitions via kubectl apply, and wait a few seconds for the CRDs to be committed in the kube-apiserver:

```
cd istio-1.0.0
[node1 istio-1.0.0]$ ls
LICENSE  README.md  bin  install  istio.VERSION  samples  tools
```
```
[node1 istio-1.0.0]$ kubectl apply -f install/kubernetes/helm/istio/templates/crds.yaml
customresourcedefinition "virtualservices.networking.istio.io" createdcustomresourcedefinition "destinationrules.networking.istio.io" created
customresourcedefinition "serviceentries.networking.istio.io" createdcustomresourcedefinition "gateways.networking.istio.io" created
customresourcedefinition "envoyfilters.networking.istio.io" created
customresourcedefinition "policies.authentication.istio.io" created
customresourcedefinition "meshpolicies.authentication.istio.io" created
customresourcedefinition "httpapispecbindings.config.istio.io" created
customresourcedefinition "httpapispecs.config.istio.io" created
customresourcedefinition "quotaspecbindings.config.istio.io" created
customresourcedefinition "quotaspecs.config.istio.io" created
customresourcedefinition "rules.config.istio.io" created
customresourcedefinition "attributemanifests.config.istio.io" created
customresourcedefinition "bypasses.config.istio.io" created
customresourcedefinition "circonuses.config.istio.io" created
customresourcedefinition "deniers.config.istio.io" created
customresourcedefinition "fluentds.config.istio.io" created
customresourcedefinition "kubernetesenvs.config.istio.io" created
customresourcedefinition "listcheckers.config.istio.io" created
customresourcedefinition "memquotas.config.istio.io" created
customresourcedefinition "noops.config.istio.io" created
customresourcedefinition "opas.config.istio.io" created
customresourcedefinition "prometheuses.config.istio.io" created
customresourcedefinition "rbacs.config.istio.io" created
customresourcedefinition "redisquotas.config.istio.io" created
customresourcedefinition "servicecontrols.config.istio.io" created
customresourcedefinition "signalfxs.config.istio.io" created
customresourcedefinition "solarwindses.config.istio.io" created
customresourcedefinition "stackdrivers.config.istio.io" created
customresourcedefinition "statsds.config.istio.io" created
customresourcedefinition "stdios.config.istio.io" created
customresourcedefinition "apikeys.config.istio.io" created
customresourcedefinition "authorizations.config.istio.io" created
customresourcedefinition "checknothings.config.istio.io" created
customresourcedefinition "kuberneteses.config.istio.io" created
customresourcedefinition "listentries.config.istio.io" created
customresourcedefinition "logentries.config.istio.io" created
customresourcedefinition "edges.config.istio.io" created
customresourcedefinition "metrics.config.istio.io" created
customresourcedefinition "quotas.config.istio.io" created
customresourcedefinition "reportnothings.config.istio.io" created
customresourcedefinition "servicecontrolreports.config.istio.io" created
customresourcedefinition "tracespans.config.istio.io" created
customresourcedefinition "rbacconfigs.rbac.istio.io" created
customresourcedefinition "serviceroles.rbac.istio.io" created
customresourcedefinition "servicerolebindings.rbac.istio.io" created
customresourcedefinition "adapters.config.istio.io" created
customresourcedefinition "instances.config.istio.io" created
customresourcedefinition "templates.config.istio.io" created
customresourcedefinition "handlers.config.istio.io" created
```

## Install Istio without mutual TLS authentication between sidecars:

```
[node1 istio-1.0.0]$ kubectl apply -f install/kubernetes/istio-demo.yaml
namespace "istio-system" created
configmap "istio-galley-configuration" created
configmap "istio-grafana-custom-resources" created
configmap "istio-statsd-prom-bridge" created
configmap "prometheus" created
configmap "istio-security-custom-resources" created
configmap "istio" created
configmap "istio-sidecar-injector" created
serviceaccount "istio-galley-service-account" created
serviceaccount "istio-egressgateway-service-account" created
serviceaccount "istio-ingressgateway-service-account" created
serviceaccount "istio-grafana-post-install-account" created
clusterrole "istio-grafana-post-install-istio-system" created
clusterrolebinding "istio-grafana-post-install-role-binding-istio-system" created
job "istio-grafana-post-install" created
serviceaccount "istio-mixer-service-account" created
serviceaccount "istio-pilot-service-account" created
serviceaccount "prometheus" created
serviceaccount "istio-cleanup-secrets-service-account" created
clusterrole "istio-cleanup-secrets-istio-system" created
clusterrolebinding "istio-cleanup-secrets-istio-system" created
job "istio-cleanup-secrets" created
serviceaccount "istio-citadel-service-account" created
serviceaccount "istio-sidecar-injector-service-account" created
customresourcedefinition "virtualservices.networking.istio.io" configured
customresourcedefinition "destinationrules.networking.istio.io" configured
customresourcedefinition "serviceentries.networking.istio.io" configured
customresourcedefinition "gateways.networking.istio.io" configured
customresourcedefinition "envoyfilters.networking.istio.io" configured
customresourcedefinition "httpapispecbindings.config.istio.io" configured
customresourcedefinition "httpapispecs.config.istio.io" configured
customresourcedefinition "quotaspecbindings.config.istio.io" configured
customresourcedefinition "quotaspecs.config.istio.io" configured
customresourcedefinition "rules.config.istio.io" configured
customresourcedefinition "attributemanifests.config.istio.io" configured
customresourcedefinition "bypasses.config.istio.io" configured
customresourcedefinition "circonuses.config.istio.io" configured
customresourcedefinition "deniers.config.istio.io" configured
customresourcedefinition "fluentds.config.istio.io" configured
customresourcedefinition "kubernetesenvs.config.istio.io" configured
customresourcedefinition "listcheckers.config.istio.io" configured
customresourcedefinition "memquotas.config.istio.io" configured
customresourcedefinition "noops.config.istio.io" configured
customresourcedefinition "opas.config.istio.io" configured
customresourcedefinition "prometheuses.config.istio.io" configured
customresourcedefinition "rbacs.config.istio.io" configured
customresourcedefinition "redisquotas.config.istio.io" configured
customresourcedefinition "servicecontrols.config.istio.io" configured
customresourcedefinition "signalfxs.config.istio.io" configured
customresourcedefinition "solarwindses.config.istio.io" configured
customresourcedefinition "stackdrivers.config.istio.io" configured
customresourcedefinition "statsds.config.istio.io" configured
customresourcedefinition "stdios.config.istio.io" configured
customresourcedefinition "apikeys.config.istio.io" configured
customresourcedefinition "authorizations.config.istio.io" configured
customresourcedefinition "checknothings.config.istio.io" configured
customresourcedefinition "kuberneteses.config.istio.io" configured
customresourcedefinition "listentries.config.istio.io" configured
customresourcedefinition "logentries.config.istio.io" configured
customresourcedefinition "edges.config.istio.io" configured
customresourcedefinition "metrics.config.istio.io" configured
customresourcedefinition "quotas.config.istio.io" configured
customresourcedefinition "reportnothings.config.istio.io" configured
customresourcedefinition "servicecontrolreports.config.istio.io" configured
customresourcedefinition "tracespans.config.istio.io" configured
customresourcedefinition "rbacconfigs.rbac.istio.io" configured
customresourcedefinition "serviceroles.rbac.istio.io" configured
customresourcedefinition "servicerolebindings.rbac.istio.io" configured
customresourcedefinition "adapters.config.istio.io" configured
customresourcedefinition "instances.config.istio.io" configured
customresourcedefinition "templates.config.istio.io" configured
customresourcedefinition "handlers.config.istio.io" configured
clusterrole "istio-galley-istio-system" created
clusterrole "istio-egressgateway-istio-system" created
clusterrole "istio-ingressgateway-istio-system" created
clusterrole "istio-mixer-istio-system" created
clusterrole "istio-pilot-istio-system" created
clusterrole "prometheus-istio-system" created
clusterrole "istio-citadel-istio-system" created
clusterrole "istio-sidecar-injector-istio-system" created
clusterrolebinding "istio-galley-admin-role-binding-istio-system" created
clusterrolebinding "istio-egressgateway-istio-system" created
clusterrolebinding "istio-ingressgateway-istio-system" created
clusterrolebinding "istio-mixer-admin-role-binding-istio-system" created
clusterrolebinding "istio-pilot-istio-system" created
clusterrolebinding "prometheus-istio-system" created
clusterrolebinding "istio-citadel-istio-system" created
clusterrolebinding "istio-sidecar-injector-admin-role-binding-istio-system" created
service "istio-galley" created
service "istio-egressgateway" created
service "istio-ingressgateway" created
service "grafana" created
service "istio-policy" created
service "istio-telemetry" created
service "istio-statsd-prom-bridge" created
deployment "istio-statsd-prom-bridge" created
service "istio-pilot" created
service "prometheus" created
service "istio-citadel" created
service "servicegraph" created
service "istio-sidecar-injector" created
deployment "istio-galley" created
deployment "istio-egressgateway" created
deployment "istio-ingressgateway" created
deployment "grafana" created
deployment "istio-policy" created
deployment "istio-telemetry" created
deployment "istio-pilot" created
deployment "prometheus" created
deployment "istio-citadel" created
deployment "servicegraph" created
deployment "istio-sidecar-injector" created
deployment "istio-tracing" created
gateway "istio-autogenerated-k8s-ingress" created
horizontalpodautoscaler "istio-egressgateway" created
horizontalpodautoscaler "istio-ingressgateway" created
horizontalpodautoscaler "istio-policy" created
horizontalpodautoscaler "istio-telemetry" created
horizontalpodautoscaler "istio-pilot" created
service "jaeger-query" created
service "jaeger-collector" created
service "jaeger-agent" created
service "zipkin" created
service "tracing" created
attributemanifest "istioproxy" created
attributemanifest "kubernetes" created
stdio "handler" created
logentry "accesslog" created
logentry "tcpaccesslog" created
rule "stdio" created
rule "stdiotcp" created
metric "requestcount" created
metric "requestduration" created
metric "requestsize" created
metric "responsesize" created
metric "tcpbytesent" created
metric "tcpbytereceived" created
prometheus "handler" created
rule "promhttp" created
rule "promtcp" created
kubernetesenv "handler" created
rule "kubeattrgenrulerule" created
rule "tcpkubeattrgenrulerule" created
kubernetes "attributes" created
destinationrule "istio-policy" created
destinationrule "istio-telemetry" created
error: unable to recognize "install/kubernetes/istio-demo.yaml": no matches for admissionregistration.k8s.io/, Kind=MutatingWebhookConfiguration
[node1 istio-1.0.0]$
```

##

Ensure the following Kubernetes services are deployed: istio-pilot, istio-ingressgateway, istio-policy, istio-telemetry, prometheus, istio-galley, and, optionally, istio-sidecar-injector.

```
[node1 istio-1.0.0]$ kubectl get svc -n istio-system
NAME                       TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                                                                       AGE
grafana                    ClusterIP      10.96.40.251     <none>        3000/TCP                                                                       1m
istio-citadel              ClusterIP      10.111.59.120    <none>        8060/TCP,9093/TCP                                                                       1m
istio-egressgateway        ClusterIP      10.110.238.251   <none>        80/TCP,443/TCP                                                                       1m
istio-galley               ClusterIP      10.111.98.96     <none>        443/TCP,9093/TCP                                                                       1m
istio-ingressgateway       LoadBalancer   10.107.129.238   <pending>     80:31380/TCP,443:31390/TCP,31400:31400/TCP,15011:32524/TCP,8060:31531/TCP,15030:30326/TCP,15031:31943/TCP   1m
istio-pilot                ClusterIP      10.105.229.209   <none>        15010/TCP,15011/TCP,8080/TCP,9093/TCP                                                                       1m
istio-policy               ClusterIP      10.106.209.229   <none>        9091/TCP,15004/TCP,9093/TCP                                                                       1mistio-sidecar-injector     ClusterIP      10.98.141.207    <none>        443/TCP                                                                       1m
istio-statsd-prom-bridge   ClusterIP      10.105.85.15     <none>        9102/TCP,9125/UDP                                                                       1m
istio-telemetry            ClusterIP      10.99.137.31     <none>        9091/TCP,15004/TCP,9093/TCP,42422/TCP                                                                       1m
jaeger-agent               ClusterIP      None             <none>        5775/UDP,6831/UDP,6832/UDP                                                                       1m
jaeger-collector           ClusterIP      10.106.213.241   <none>        14267/TCP,14268/TCP                                                                       1m
jaeger-query               ClusterIP      10.109.75.105    <none>        16686/TCP                                                                       1m
prometheus                 ClusterIP      10.106.61.13     <none>        9090/TCP                                                                       1m
servicegraph               ClusterIP      10.109.144.253   <none>        8088/TCP                                                                       1m
tracing                    ClusterIP      10.110.217.39    <none>        80/TCP                                                                       1m
zipkin                     ClusterIP      10.110.67.50     <none>        9411/TCP                                                                       1m
[node1 istio-1.0.0]$
[node1 istio-1.0.0]$
```

## 

Ensure the corresponding Kubernetes pods are deployed and all containers are up and running: istio-pilot-*, istio-ingressgateway-*, istio-egressgateway-*, istio-policy-*, istio-telemetry-*, istio-citadel-*, prometheus-*, istio-galley-*, and, optionally, istio-sidecar-injector-*.

```
[node1 istio-1.0.0]$ kubectl get pods -n istio-system
NAME                                        READY     STATUS    RESTARTS   AGEgrafana-6dd4cb7ffd-qsp9c                    1/1       Running   0          3m
istio-citadel-b874fd9f5-ltjgn               1/1       Running   0          3mistio-egressgateway-ddcdd644c-4xb2n         1/1       Running   0          3m
istio-galley-8985546b8-lnmn4                1/1       Running   0          3mistio-ingressgateway-7565c689cb-mlcgd       1/1       Running   0          3m
istio-pilot-58b5d5f-jwj95                   2/2       Running   0          3mistio-policy-686ff55f4f-m7lxj               2/2       Running   0          3m
istio-sidecar-injector-5d4b7b4957-9nr67     1/1       Running   0          3mistio-statsd-prom-bridge-58f8596c67-k946d   1/1       Running   0          3m
istio-telemetry-6bff9755fd-mkff2            2/2       Running   0          3mistio-tracing-75d76fb9f-772j4               1/1       Running   0          2m
prometheus-884dbbcd5-pn25r                  1/1       Running   0          3mservicegraph-646bbc8cb4-6z64r               1/1       Running   0          3m
[node1 istio-1.0.0]$

```

##



## Verifying Istio Services

```
[node1 istio-1.0.0]$ kubectl get svc -n istio-system
NAME                       TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                                                                    AGE
grafana                    ClusterIP      10.102.53.163    <none>        3000/TCP                                                                    7m
istio-citadel              ClusterIP      10.97.92.47      <none>        8060/TCP,9093/TCP                                                                    7m
istio-egressgateway        ClusterIP      10.102.163.157   <none>        80/TCP,443/TCP                                                                    7mistio-galley               ClusterIP      10.104.119.237   <none>        443/TCP,9093/TCP                                                                    7mistio-ingressgateway       LoadBalancer   10.101.251.4     <pending>     80:31380/TCP,443:31390/TCP,31400:31400/TCP,15011:30333/TCP,8060:30055/TCP,15030:32545/TCP,15031:30237/TCP   7mistio-pilot                ClusterIP      10.111.9.72      <none>        15010/TCP,15011/TCP,8080/TCP,9093/TCP                                                                    7m
istio-policy               ClusterIP      10.107.121.19    <none>        9091/TCP,15004/TCP,9093/TCP                                                                    7m
istio-sidecar-injector     ClusterIP      10.107.142.100   <none>        443/TCP                                                                    7m
istio-statsd-prom-bridge   ClusterIP      10.97.117.69     <none>        9102/TCP,9125/UDP                                                                    7m
istio-telemetry            ClusterIP      10.99.253.31     <none>        9091/TCP,15004/TCP,9093/TCP,42422/TCP                                                                    7mjaeger-agent               ClusterIP      None             <none>        5775/UDP,6831/UDP,6832/UDP                                                                    7m
jaeger-collector           ClusterIP      10.101.202.98    <none>        14267/TCP,14268/TCP                                                                    7m
jaeger-query               ClusterIP      10.98.45.137     <none>        16686/TCP                                                                    7m
prometheus                 ClusterIP      10.98.164.134    <none>        9090/TCP                                                                    7m
servicegraph               ClusterIP      10.97.26.200     <none>        8088/TCP                                                                    7m
tracing                    ClusterIP      10.101.37.224    <none>        80/TCP                                                                    7m
zipkin                     ClusterIP      10.104.166.92    <none>        9411/TCP                                                                    7m
[node1 istio-1.0.0]$ curl 10.98.164.134:9090
<a href="/graph">Found</a>.

```
## For Prometheus
```
[node1 istio-1.0.0]$ kubectl delete svc  prometheus  -n istio-system
service "prometheus" deleted
```

```
kubectl create service -n istio-system  nodeport prometheus --tcp=9090 --node-port=30003
service "prometheus" created
[node1 istio-1.0.0]$
```
## For Grafana:
```
[node1 istio-1.0.0]$ kubectl delete svc grafana  -n istio-system
[node1 istio-1.0.0]$ kubectl create service -n istio-system  nodeport grafana --tcp=3000 --node-port=30004
[node1 istio-1.0.0]$
```

## For Servicegraph:
```
[node1 istio-1.0.0]$ kubectl delete svc servicegraph  -n istio-systems
[node1 istio-1.0.0]$ kubectl create service -n istio-system  nodeport servicegraph --tcp=8088 --node-port=30005
[node1 istio-1.0.0]$
```

```
[node1 istio]$ kubectl -n istio-system get svc tracing
NAME      TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
tracing   ClusterIP   10.102.57.45   <none>        80/TCP    9m[node1 istio]$ curl 10.102.57.45
<!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta http-equiv="cache-control" content="max-age=0"/><meta http-equiv="cache-control" content="no-cache"/><meta http-equiv="expires" content="0"/><meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT"/><meta http-equiv="pragma" content="no-cache"/><base href="/" data-inject-target="BASE_URL"/><link rel="shortcut icon" href="./favicon.ico"><title>Jaeger UI</title><script>// Jaeger UI config data is embedded by the query-service. This is
      // later merged with defaults into the redux `state.config` via      // src/utils/config/get-config.js. The default provided by the query
      // service should be an empty object or it can leave `DEFAULT_CONFIG`      // unchanged.
      function getJaegerUiConfig() {        const DEFAULT_CONFIG = null;
        const JAEGER_CONFIG = DEFAULT_CONFIG;        return JAEGER_CONFIG;
      }</script><link href="./static/css/main.160e898e.css" rel="stylesheet"></head><body><div id="jaeger-ui-root"></div><script type="text/javascript" src="./static/js/main.4f0c2202.js"></script></body></html>[node1 istio]$
```

## Enabling PATH for istioctl

```
export PATH="$PATH:/root/docker101/play-with-kubernetes/istio/istio-1.0.0/bin"
```
## Verifying Istioctl version

```
[node1 istio]$ istioctl version
Version: 1.0.0
GitRevision: 3a136c90ec5e308f236e0d7ebb5c4c5e405217f4
User: root@71a9470ea93c
Hub: gcr.io/istio-release
GolangVersion: go1.10.1
BuildStatus: Clean
```

```
[node1 istio]$ curl https://raw.githubusercontent.com/istio/istio/release-1.0/samples/bookinfo/platform/kube/bookinfo.yaml | istioctl kube-inject --debug -f - > newBookInfo.yaml
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0Flag --debug has been deprecated, Use --injectConfigMapName or --injectConfigFile instead
100  4359  100  4359    0     0  21235      0 --:--:-- --:--:-- --:--:-- 21263
[node1 istio]$ kubectl apply -f newBookInfo.yaml
service "details" created
deployment "details-v1" created
service "ratings" created
deployment "ratings-v1" created
service "reviews" created
deployment "reviews-v1" created
deployment "reviews-v2" created
deployment "reviews-v3" created
service "productpage" created
deployment "productpage-v1" created
[node1 istio]$
```

Verify that previous deployments are all in a state of AVAILABLE before continuing. Do not procede until they are up and running.

```
watch kubectl get deployment

Every 2.0s: kubectl get deployment                                                                                  Sun Aug 12 15:27:03 2018

NAME             DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
details-v1       1         1         1            1           3m
productpage-v1   1         1         1            1           3m
ratings-v1       1         1         1            1           3m
reviews-v1       1         1         1            1           3m
reviews-v2       1         1         1            1           3m
reviews-v3       1         1         1            1           3m

```

## Inspect the details of the pods

```
Every 2.0s: kubectl get po                                                                                          Sun Aug 12 15:28:20 2018

NAME                              READY     STATUS    RESTARTS   AGE
details-v1-6d4f8689d5-dzh9g       2/2       Running   0          4m
productpage-v1-85cd74dd8f-6jgtj   2/2       Running   0          4m
ratings-v1-868f55c9b9-8vlxt       2/2       Running   0          4m
reviews-v1-5d4f7d4dc7-bnsmv       2/2       Running   0          4m
reviews-v2-d78b44757-bjh72        2/2       Running   0          4m
reviews-v3-ddbc78677-xdq57        2/2       Running   0          4m

```
##  Details of the services:

```
Every 2.0s: kubectl get svc                                                                                         Sun Aug 12 15:28:51 2018

NAME          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
details       ClusterIP   10.97.7.233     <none>        9080/TCP   5m
kubernetes    ClusterIP   10.96.0.1       <none>        443/TCP    16m
productpage   ClusterIP   10.102.50.146   <none>        9080/TCP   5m
ratings       ClusterIP   10.98.10.229    <none>        9080/TCP   5m
reviews       ClusterIP   10.105.180.31   <none>        9080/TCP   5m

```

## Inspecting the Istio Ingress gateway

```
[node1 istio]$ kubectl -n istio-system exec -it istio-ingressgateway-7565c689cb-j8qrh bash
root@istio-ingressgateway-7565c689cb-j8qrh:/#
root@istio-ingressgateway-7565c689cb-j8qrh:/# ls
bin   dev  home  lib64  mnt  proc  run   srv  tmp  var
boot  etc  lib   media  opt  root  sbin  sys  usr
root@istio-ingressgateway-7565c689cb-j8qrh:/# curl localhost:15000/help
admin commands are:
  /: Admin home page
  /certs: print certs on machine
  /clusters: upstream cluster status
  /config_dump: dump current Envoy configs (experimental)
  /cpuprofiler: enable/disable the CPU profiler
  /healthcheck/fail: cause the server to fail health checks
  /healthcheck/ok: cause the server to pass health checks
  /help: print out list of admin commands
  /hot_restart_version: print the hot restart compatibility version
  /listeners: print listener addresses
  /logging: query/change logging levels
  /quitquitquit: exit the server
  /reset_counters: reset all counters to zero
  /runtime: print runtime values
  /runtime_modify: modify runtime values
  /server_info: print server version/status information
  /stats: print server stats
  /stats/prometheus: print server stats in prometheus format
root@istio-ingressgateway-7565c689cb-j8qrh:/#
```

##

```
curl localhost:15000/help
curl localhost:15000/stats
curl localhost:15000/listeners
curl localhost:15000/routes
curl localhost:15000/clusters
curl localhost:15000/server_info


```

## Cleaning Up

```
[node1 istio-1.0.0]$ samples/bookinfo/platform/kube/cleanup.sh
namespace ? [default]
using NAMESPACE=default
No resources found.
Deleted config: virtualservices bookinfo
Deleted config: virtualservices helloworld
Deleted config: gateways bookinfo-gateway
Deleted config: gateways helloworld-gateway
Application cleanup may take up to one minute
service "details" deleted
deployment "details-v1" deleted
service "ratings" deleted
deployment "ratings-v1" deleted
service "reviews" deleted
deployment "reviews-v1" deleted
deployment "reviews-v2" deleted
deployment "reviews-v3" deleted
service "productpage" deleted
deployment "productpage-v1" deleted
Application cleanup successful
[node1 istio-1.0.0]$
```

##

```
```
