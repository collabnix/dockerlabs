# Installing Istio Mesh on Docker for Desktop 2.0.0.3

Download this powershell script to install Istio

```
git clone https://github.com/collabnix/dockerlabs
cd kubernetes/beginners/helm/
```

## Running the below powershell script(You might need to be admin user)

```
.\getLatestIstio.ps1
```

Manual Method:

- Download Istio via https://github.com/istio/istio/releases/tag/1.0.6
- Extract the contents.
- Set the environment variable

Copy the absolute path to the bin folder under the downloaded istio-<VERSION_NUMBER> folder e.g.,C:\Users\Ajeet_Raina\Desktop\istio-1.0.6-win\istio-1.0.6\bin

- In the Search on the taskbar, look and open "Edit environment variables for my account".
- Under User variables, edit path environment variable and add a new entry pointing to the bin folder as copied above. Save the entries.

## Test Istioctl

Open command prompt and run istioctl.
To Check the version, run istioctl version

```
PS C:\Users\Ajeet_Raina> istioctl version
Version: 1.0.6
GitRevision: 98598f88f6ee9c1e6b3f03b652d8e0e3cd114fa2
User: root@464fc845-2bf8-11e9-b805-0a580a2c0506
Hub: docker.io/istio
GolangVersion: go1.10.4
BuildStatus: Clean

PS C:\Users\Ajeet_Raina>
```

```
PS C:\Users\Ajeet_Raina> c
namespace "default" labeled
PS C:\Users\Ajeet_Raina>
```

```
PS C:\Users\Ajeet_Raina> kubectl get namespace -L istio-injection
NAME          STATUS    AGE       ISTIO-INJECTION
default       Active    23h       enabled
docker        Active    23h
kube-public   Active    23h
kube-system   Active    23h
PS C:\Users\Ajeet_Raina>
```

```
PS C:\Users\Ajeet_Raina\Desktop\istio-1.0.6-win\istio-1.0.6> kubectl apply -f samples/bookinfo/platform/k
ml
service "details" configured
deployment.extensions "details-v1" configured
service "ratings" configured
deployment.extensions "ratings-v1" configured
service "reviews" configured
deployment.extensions "reviews-v1" configured
deployment.extensions "reviews-v2" configured
deployment.extensions "reviews-v3" configured
service "productpage" configured
deployment.extensions "productpage-v1" configured
```

```
PS C:\Users\Ajeet_Raina\Desktop\istio-1.0.6-win\istio-1.0.6> kubectl apply -f .\samples\bookinfo\platform\kube\bookinfo.yaml
service "details" unchanged
deployment.extensions "details-v1" unchanged
service "ratings" unchanged
deployment.extensions "ratings-v1" unchanged
service "reviews" unchanged
deployment.extensions "reviews-v1" unchanged
deployment.extensions "reviews-v2" unchanged
deployment.extensions "reviews-v3" unchanged
service "productpage" unchanged
deployment.extensions "productpage-v1" unchanged
```

```
PS C:\Users\Ajeet_Raina\Desktop\istio-1.0.6-win\istio-1.0.6> kubectl apply -f install/kubernetes/helm/istio/templates/crds.ya
ml
customresourcedefinition.apiextensions.k8s.io "virtualservices.networking.istio.io" created
customresourcedefinition.apiextensions.k8s.io "destinationrules.networking.istio.io" created
customresourcedefinition.apiextensions.k8s.io "serviceentries.networking.istio.io" created
customresourcedefinition.apiextensions.k8s.io "gateways.networking.istio.io" created
customresourcedefinition.apiextensions.k8s.io "envoyfilters.networking.istio.io" created
customresourcedefinition.apiextensions.k8s.io "policies.authentication.istio.io" created
customresourcedefinition.apiextensions.k8s.io "meshpolicies.authentication.istio.io" created
customresourcedefinition.apiextensions.k8s.io "httpapispecbindings.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "httpapispecs.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "quotaspecbindings.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "quotaspecs.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "rules.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "attributemanifests.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "bypasses.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "circonuses.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "deniers.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "fluentds.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "kubernetesenvs.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "listcheckers.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "memquotas.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "noops.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "opas.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "prometheuses.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "rbacs.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "redisquotas.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "servicecontrols.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "signalfxs.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "solarwindses.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "stackdrivers.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "statsds.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "stdios.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "apikeys.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "authorizations.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "checknothings.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "kuberneteses.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "listentries.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "logentries.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "edges.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "metrics.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "quotas.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "reportnothings.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "servicecontrolreports.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "tracespans.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "rbacconfigs.rbac.istio.io" created
customresourcedefinition.apiextensions.k8s.io "serviceroles.rbac.istio.io" created
customresourcedefinition.apiextensions.k8s.io "servicerolebindings.rbac.istio.io" created
customresourcedefinition.apiextensions.k8s.io "adapters.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "instances.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "templates.config.istio.io" created
customresourcedefinition.apiextensions.k8s.io "handlers.config.istio.io" created
PS C:\Users\Ajeet_Raina\Desktop\istio-1.0.6-win\istio-1.0.6> helm template install/kubernetes/helm/istio --name istio --names
pace istio-system > $HOME/istio.yaml
PS C:\Users\Ajeet_Raina\Desktop\istio-1.0.6-win\istio-1.0.6>
PS C:\Users\Ajeet_Raina\Desktop\istio-1.0.6-win\istio-1.0.6> kubectl create namespace istio-system
namespace "istio-system" created
PS C:\Users\Ajeet_Raina\Desktop\istio-1.0.6-win\istio-1.0.6> kubectl apply -f $HOME/istio.yaml
configmap "istio-galley-configuration" created
configmap "istio-statsd-prom-bridge" created
configmap "prometheus" created
configmap "istio-security-custom-resources" created
configmap "istio" created
configmap "istio-sidecar-injector" created
serviceaccount "istio-galley-service-account" created
serviceaccount "istio-egressgateway-service-account" created
serviceaccount "istio-ingressgateway-service-account" created
serviceaccount "istio-mixer-service-account" created
serviceaccount "istio-pilot-service-account" created
serviceaccount "prometheus" created
serviceaccount "istio-cleanup-secrets-service-account" created
clusterrole.rbac.authorization.k8s.io "istio-cleanup-secrets-istio-system" created
clusterrolebinding.rbac.authorization.k8s.io "istio-cleanup-secrets-istio-system" created
job.batch "istio-cleanup-secrets" created
serviceaccount "istio-security-post-install-account" created
clusterrole.rbac.authorization.k8s.io "istio-security-post-install-istio-system" created
clusterrolebinding.rbac.authorization.k8s.io "istio-security-post-install-role-binding-istio-system" created
job.batch "istio-security-post-install" created
serviceaccount "istio-citadel-service-account" created
serviceaccount "istio-sidecar-injector-service-account" created
customresourcedefinition.apiextensions.k8s.io "virtualservices.networking.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "destinationrules.networking.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "serviceentries.networking.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "gateways.networking.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "envoyfilters.networking.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "httpapispecbindings.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "httpapispecs.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "quotaspecbindings.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "quotaspecs.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "rules.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "attributemanifests.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "bypasses.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "circonuses.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "deniers.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "fluentds.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "kubernetesenvs.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "listcheckers.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "memquotas.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "noops.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "opas.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "prometheuses.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "rbacs.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "redisquotas.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "servicecontrols.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "signalfxs.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "solarwindses.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "stackdrivers.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "statsds.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "stdios.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "apikeys.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "authorizations.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "checknothings.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "kuberneteses.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "listentries.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "logentries.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "edges.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "metrics.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "quotas.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "reportnothings.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "servicecontrolreports.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "tracespans.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "rbacconfigs.rbac.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "serviceroles.rbac.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "servicerolebindings.rbac.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "adapters.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "instances.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "templates.config.istio.io" configured
customresourcedefinition.apiextensions.k8s.io "handlers.config.istio.io" configured
clusterrole.rbac.authorization.k8s.io "istio-galley-istio-system" created
clusterrole.rbac.authorization.k8s.io "istio-egressgateway-istio-system" created
clusterrole.rbac.authorization.k8s.io "istio-ingressgateway-istio-system" created
clusterrole.rbac.authorization.k8s.io "istio-mixer-istio-system" created
clusterrole.rbac.authorization.k8s.io "istio-pilot-istio-system" created
clusterrole.rbac.authorization.k8s.io "prometheus-istio-system" created
clusterrole.rbac.authorization.k8s.io "istio-citadel-istio-system" created
clusterrole.rbac.authorization.k8s.io "istio-sidecar-injector-istio-system" created
clusterrolebinding.rbac.authorization.k8s.io "istio-galley-admin-role-binding-istio-system" created
clusterrolebinding.rbac.authorization.k8s.io "istio-egressgateway-istio-system" created
clusterrolebinding.rbac.authorization.k8s.io "istio-ingressgateway-istio-system" created
clusterrolebinding.rbac.authorization.k8s.io "istio-mixer-admin-role-binding-istio-system" created
clusterrolebinding.rbac.authorization.k8s.io "istio-pilot-istio-system" created
clusterrolebinding.rbac.authorization.k8s.io "prometheus-istio-system" created
clusterrolebinding.rbac.authorization.k8s.io "istio-citadel-istio-system" created
clusterrolebinding.rbac.authorization.k8s.io "istio-sidecar-injector-admin-role-binding-istio-system" created
service "istio-galley" created
service "istio-egressgateway" created
service "istio-ingressgateway" created
service "istio-policy" created
service "istio-telemetry" created
service "istio-pilot" created
service "prometheus" created
service "istio-citadel" created
service "istio-sidecar-injector" created
deployment.extensions "istio-galley" created
deployment.extensions "istio-egressgateway" created
deployment.extensions "istio-ingressgateway" created
deployment.extensions "istio-policy" created
deployment.extensions "istio-telemetry" created
deployment.extensions "istio-pilot" created
deployment.extensions "prometheus" created
deployment.extensions "istio-citadel" created
deployment.extensions "istio-sidecar-injector" created
gateway.networking.istio.io "istio-autogenerated-k8s-ingress" created
horizontalpodautoscaler.autoscaling "istio-egressgateway" created
horizontalpodautoscaler.autoscaling "istio-ingressgateway" created
horizontalpodautoscaler.autoscaling "istio-policy" created
horizontalpodautoscaler.autoscaling "istio-telemetry" created
horizontalpodautoscaler.autoscaling "istio-pilot" created
mutatingwebhookconfiguration.admissionregistration.k8s.io "istio-sidecar-injector" created
attributemanifest.config.istio.io "istioproxy" created
attributemanifest.config.istio.io "kubernetes" created
stdio.config.istio.io "handler" created
logentry.config.istio.io "accesslog" created
logentry.config.istio.io "tcpaccesslog" created
rule.config.istio.io "stdio" created
rule.config.istio.io "stdiotcp" created
metric.config.istio.io "requestcount" created
metric.config.istio.io "requestduration" created
metric.config.istio.io "requestsize" created
metric.config.istio.io "responsesize" created
metric.config.istio.io "tcpbytesent" created
metric.config.istio.io "tcpbytereceived" created
prometheus.config.istio.io "handler" created
rule.config.istio.io "promhttp" created
rule.config.istio.io "promtcp" created
kubernetesenv.config.istio.io "handler" created
rule.config.istio.io "kubeattrgenrulerule" created
rule.config.istio.io "tcpkubeattrgenrulerule" created
kubernetes.config.istio.io "attributes" created
destinationrule.networking.istio.io "istio-policy" created
destinationrule.networking.istio.io "istio-telemetry" created
PS C:\Users\Ajeet_Raina\Desktop\istio-1.0.6-win\istio-1.0.6> kubectl apply -f install/kubernetes/helm/helm-service-account.ya
ml
serviceaccount "tiller" created
clusterrolebinding.rbac.authorization.k8s.io "tiller" created
```

```
PS C:\Users\Ajeet_Raina\Desktop\istio-1.0.6-win\istio-1.0.6> helm init --service-account tiller
$HELM_HOME has been configured at C:\Users\Ajeet_Raina\.helm.
Warning: Tiller is already installed in the cluster.
(Use --client-only to suppress this message, or --upgrade to upgrade Tiller to the current version.)
Happy Helming!
```

```
PS C:\Users\Ajeet_Raina\Desktop\istio-1.0.6-win\istio-1.0.6> helm install install/kubernetes/helm/istio --name istio --namesp
ace istio-system
Error: customresourcedefinitions.apiextensions.k8s.io "gateways.networking.istio.io" already exists
PS C:\Users\Ajeet_Raina\Desktop\istio-1.0.6-win\istio-1.0.6>
```


```
PS C:\Users\Ajeet_Raina\Desktop\istio-1.1.0-rc.3-win\istio-1.1.0-rc.3> kubectl apply -f samples/bookinfo/
ookinfo.yaml
service "details" configured
deployment.extensions "details-v1" configured
service "ratings" configured
deployment.extensions "ratings-v1" configured
service "reviews" configured
deployment.extensions "reviews-v1" configured
deployment.extensions "reviews-v2" configured
deployment.extensions "reviews-v3" configured
service "productpage" configured
deployment.extensions "productpage-v1" configured
```

```
PS C:\Users\Ajeet_Raina\Desktop\istio-1.1.0-rc.3-win\istio-1.1.0-rc.3> kubectl apply -f samples/bookinfo/
info-gateway.yaml
gateway.networking.istio.io "bookinfo-gateway" created
virtualservice.networking.istio.io "bookinfo" created
PS C:\Users\Ajeet_Raina\Desktop\istio-1.1.0-rc.3-win\istio-1.1.0-rc.3>
```

```
PS C:\Users\Ajeet_Raina\Desktop\istio-1.1.0-rc.3-win\istio-1.1.0-rc.3> kubectl get pods -n istio-system
NAME                                      READY     STATUS              RESTARTS   AGE
istio-citadel-548f4cdd9-cbblw             0/1       ContainerCreating   0          59m
istio-cleanup-secrets-4n6z7               0/1       ContainerCreating   0          59m
istio-egressgateway-5f78595878-84x62      0/1       ContainerCreating   0          59m
istio-galley-8f6585898-h8bv7              0/1       ContainerCreating   0          59m
istio-ingressgateway-7ff8d8b557-wvw7d     0/1       ContainerCreating   0          59m
istio-pilot-589887b7f6-gr6l8              0/2       ContainerCreating   0          59m
istio-policy-5f8c86f95c-dt5nd             0/2       ContainerCreating   0          59m
istio-security-post-install-ltnpx         0/1       ContainerCreating   0          59m
istio-sidecar-injector-6fb6845cdd-ghpjj   0/1       ContainerCreating   0          59m
istio-telemetry-7c69888957-sj846          0/2       ContainerCreating   0          59m
prometheus-f556886b8-pt6zf                0/1       ContainerCreating   0          59m
```

You will need to wait till these pods comes up well.

```
PS C:\Users\Ajeet_Raina\Desktop\istio-1.1.0-rc.3-win\istio-1.1.0-rc.3> kubectl get all
NAME                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/details       ClusterIP   10.103.40.159    <none>        9080/TCP   7h
service/kubernetes    ClusterIP   10.96.0.1        <none>        443/TCP    1d
service/productpage   ClusterIP   10.108.229.154   <none>        9080/TCP   7h
service/ratings       ClusterIP   10.110.235.174   <none>        9080/TCP   7h
service/reviews       ClusterIP   10.108.95.118    <none>        9080/TCP   7h

NAME                             DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/details-v1       1         0         0            0           7h
deployment.apps/productpage-v1   1         0         0            0           7h
deployment.apps/ratings-v1       1         0         0            0           7h
deployment.apps/reviews-v1       1         0         0            0           7h
deployment.apps/reviews-v2       1         0         0            0           7h
deployment.apps/reviews-v3       1         0         0            0           7h

NAME                                       DESIRED   CURRENT   READY     AGE
replicaset.apps/details-v1-5c479cb788      1         0         0         7h
replicaset.apps/details-v1-6865b9b99d      0         0         0         1h
replicaset.apps/productpage-v1-97d4c545d   1         0         0         7h
replicaset.apps/productpage-v1-f8c8fb8     0         0         0         1h
replicaset.apps/ratings-v1-77f657f55d      0         0         0         1h
replicaset.apps/ratings-v1-855794cc7b      1         0         0         7h
replicaset.apps/reviews-v1-6b7f6db5c5      0         0         0         1h
replicaset.apps/reviews-v1-7489fb5675      1         0         0         7h
replicaset.apps/reviews-v2-6b795954ff      1         0         0         7h
replicaset.apps/reviews-v2-7ff5966b99      0         0         0         1h
replicaset.apps/reviews-v3-58cdbd8cf9      1         0         0         7h
replicaset.apps/reviews-v3-5df889bcff      0         0         0         1h
PS C:\Users\Ajeet_Raina\Desktop\istio-1.1.0-rc.3-win\istio-1.1.0-rc.3>

```
