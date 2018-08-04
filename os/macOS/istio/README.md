# Installing Istio on Docker for Mac 18.06 CE


Istio is installed in two parts. The first part involves the CLI tooling that will be used to deploy and manage Istio backed services. The second part configures the Kubernetes cluster to support Istio.

```
[Captains-Bay]🚩 >  kubectl cluster-info
Kubernetes master is running at https://localhost:6443
KubeDNS is running at https://localhost:6443/api/v1/namespaces/kube-system/services/kube-dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
[Captains-Bay]🚩 >
```


## Install CLI tooling

The following command will install the Istio 1.0.0 release.

```
curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.0.0 sh -
```

After it has successfully run, add the bin folder to your path.

```
export PATH="$PATH:/root/istio-1.0.0/bin"
```

```
cd /root/istio-1.0.0
```

```
[Captains-Bay]🚩 >  curl -L https://git.io/getLatestIstio | sh -
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:--  0:00:02 --:--:--     0
100  1447  100  1447    0     0    551      0  0:00:02  0:00:02 --:--:--   551
Downloading istio-1.0.0 from https://github.com/istio/istio/releases/download/1.0.0/istio-1.0.0-osx.tar.gz ...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   612    0   612    0     0    377      0 --:--:--  0:00:01 --:--:--   378
100 14.0M  100 14.0M    0     0   358k      0  0:00:40  0:00:40 --:--:-- 1129k
Downloaded into istio-1.0.0:
LICENSE		bin		istio.VERSION	tools
README.md	install		samples
Add /Users/ajeetraina/istio-1.0.0/bin to your path; e.g copy paste in your shell and/or ~/.profile:
export PATH="$PATH:/Users/ajeetraina/istio-1.0.0/bin"
[Captains-Bay]🚩 >

```

```
[Captains-Bay]🚩 >  kubectl apply -f install/kubernetes/istio-demo.yaml
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
customresourcedefinition "virtualservices.networking.istio.io" created
customresourcedefinition "destinationrules.networking.istio.io" created
customresourcedefinition "serviceentries.networking.istio.io" created
customresourcedefinition "gateways.networking.istio.io" created
customresourcedefinition "envoyfilters.networking.istio.io" created
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
mutatingwebhookconfiguration "istio-sidecar-injector" created
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
[Captains-Bay]🚩 >
```

```
[Captains-Bay]🚩 >  ls
LICENSE		bin		istio.VERSION	tools
README.md	install		samples
s.yaml -n istio-systemectl apply -f install/kubernetes/helm/istio/templates/crd
customresourcedefinition "virtualservices.networking.istio.io" configured
customresourcedefinition "destinationrules.networking.istio.io" configured
customresourcedefinition "serviceentries.networking.istio.io" configured
customresourcedefinition "gateways.networking.istio.io" configured
customresourcedefinition "envoyfilters.networking.istio.io" configured
customresourcedefinition "policies.authentication.istio.io" created
customresourcedefinition "meshpolicies.authentication.istio.io" created
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
[Captains-Bay]🚩 >
```

```
[Captains-Bay]🚩 >  clear
[Captains-Bay]🚩 >  ls
LICENSE		bin		istio.VERSION	tools
README.md	install		samples
s.yaml -n istio-systemectl apply -f install/kubernetes/helm/istio/templates/crd
customresourcedefinition "virtualservices.networking.istio.io" configured
customresourcedefinition "destinationrules.networking.istio.io" configured
customresourcedefinition "serviceentries.networking.istio.io" configured
customresourcedefinition "gateways.networking.istio.io" configured
customresourcedefinition "envoyfilters.networking.istio.io" configured
customresourcedefinition "policies.authentication.istio.io" created
customresourcedefinition "meshpolicies.authentication.istio.io" created
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
[Captains-Bay]🚩 >
[Captains-Bay]🚩 >  clear
[Captains-Bay]🚩 >  kubectl apply -f install/kubernetes/istio-demo-auth.yaml
namespace "istio-system" configured
configmap "istio-galley-configuration" unchanged
configmap "istio-grafana-custom-resources" unchanged
configmap "istio-statsd-prom-bridge" unchanged
configmap "prometheus" unchanged
configmap "istio-security-custom-resources" configured
configmap "istio" configured
configmap "istio-sidecar-injector" unchanged
serviceaccount "istio-galley-service-account" unchanged
serviceaccount "istio-egressgateway-service-account" unchanged
serviceaccount "istio-ingressgateway-service-account" unchanged
serviceaccount "istio-grafana-post-install-account" unchanged
clusterrole "istio-grafana-post-install-istio-system" configured
clusterrolebinding "istio-grafana-post-install-role-binding-istio-system" configured
job "istio-grafana-post-install" unchanged
serviceaccount "istio-mixer-service-account" unchanged
serviceaccount "istio-pilot-service-account" unchanged
serviceaccount "prometheus" unchanged
serviceaccount "istio-cleanup-secrets-service-account" unchanged
clusterrole "istio-cleanup-secrets-istio-system" configured
clusterrolebinding "istio-cleanup-secrets-istio-system" configured
job "istio-cleanup-secrets" unchanged
serviceaccount "istio-security-post-install-account" created
clusterrole "istio-security-post-install-istio-system" created
clusterrolebinding "istio-security-post-install-role-binding-istio-system" created
job "istio-security-post-install" created
serviceaccount "istio-citadel-service-account" unchanged
serviceaccount "istio-sidecar-injector-service-account" unchanged
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
clusterrole "istio-galley-istio-system" configured
clusterrole "istio-egressgateway-istio-system" configured
clusterrole "istio-ingressgateway-istio-system" configured
clusterrole "istio-mixer-istio-system" configured
clusterrole "istio-pilot-istio-system" configured
clusterrole "prometheus-istio-system" configured
clusterrole "istio-citadel-istio-system" configured
clusterrole "istio-sidecar-injector-istio-system" configured
clusterrolebinding "istio-galley-admin-role-binding-istio-system" configured
clusterrolebinding "istio-egressgateway-istio-system" configured
clusterrolebinding "istio-ingressgateway-istio-system" configured
clusterrolebinding "istio-mixer-admin-role-binding-istio-system" configured
clusterrolebinding "istio-pilot-istio-system" configured
clusterrolebinding "prometheus-istio-system" configured
clusterrolebinding "istio-citadel-istio-system" configured
clusterrolebinding "istio-sidecar-injector-admin-role-binding-istio-system" configured
service "istio-galley" unchanged
service "istio-egressgateway" unchanged
service "istio-ingressgateway" unchanged
service "grafana" unchanged
service "istio-policy" unchanged
service "istio-telemetry" unchanged
service "istio-statsd-prom-bridge" unchanged
deployment "istio-statsd-prom-bridge" unchanged
service "istio-pilot" unchanged
service "prometheus" unchanged
service "istio-citadel" unchanged
service "servicegraph" unchanged
service "istio-sidecar-injector" unchanged
deployment "istio-galley" configured
deployment "istio-egressgateway" configured
deployment "istio-ingressgateway" configured
deployment "grafana" unchanged
deployment "istio-policy" configured
deployment "istio-telemetry" configured
deployment "istio-pilot" configured
deployment "prometheus" unchanged
deployment "istio-citadel" unchanged
deployment "servicegraph" unchanged
deployment "istio-sidecar-injector" unchanged
deployment "istio-tracing" unchanged
gateway "istio-autogenerated-k8s-ingress" configured
horizontalpodautoscaler "istio-egressgateway" unchanged
horizontalpodautoscaler "istio-ingressgateway" unchanged
horizontalpodautoscaler "istio-policy" unchanged
horizontalpodautoscaler "istio-telemetry" unchanged
horizontalpodautoscaler "istio-pilot" unchanged
service "jaeger-query" unchanged
service "jaeger-collector" unchanged
service "jaeger-agent" unchanged
service "zipkin" unchanged
service "tracing" unchanged
mutatingwebhookconfiguration "istio-sidecar-injector" configured
attributemanifest "istioproxy" configured
attributemanifest "kubernetes" configured
stdio "handler" configured
logentry "accesslog" configured
logentry "tcpaccesslog" configured
rule "stdio" configured
rule "stdiotcp" configured
metric "requestcount" configured
metric "requestduration" configured
metric "requestsize" configured
metric "responsesize" configured
metric "tcpbytesent" configured
metric "tcpbytereceived" configured
prometheus "handler" configured
rule "promhttp" configured
rule "promtcp" configured
kubernetesenv "handler" configured
rule "kubeattrgenrulerule" configured
rule "tcpkubeattrgenrulerule" configured
kubernetes "attributes" configured
destinationrule "istio-policy" configured
destinationrule "istio-telemetry" configured
[Captains-Bay]🚩 >
```

## Check Status

All the services are deployed as Pods.

```
[Captains-Bay]🚩 >  kubectl get pods -n istio-system
NAME                                        READY     STATUS    RESTARTS   AGE
grafana-66469c4d95-h8srb                    1/1       Running   0          8m
istio-citadel-5799b76c66-rs9z9              1/1       Running   0          8m
istio-egressgateway-657f449d77-grlb9        1/1       Running   0          1m
istio-galley-5bf4d6b8f7-xg5n7               1/1       Running   0          8m
istio-ingressgateway-b55bc6bbb-pt58w        1/1       Running   0          1m
istio-pilot-c8ff8c54-n86f9                  0/2       Pending   0          1m
istio-policy-566866947b-dg6x2               2/2       Running   0          1m
istio-sidecar-injector-5b5fcf4df6-pdd79     1/1       Running   0          8m
istio-statsd-prom-bridge-7f44bb5ddb-psfqs   1/1       Running   0          8m
istio-telemetry-5966685789-zcvpq            2/2       Running   0          1m
istio-tracing-ff94688bb-hcm7g               1/1       Running   0          8m
prometheus-84bd4b9796-xfqxx                 1/1       Running   0          8m
servicegraph-7875b75b4f-qhv67               1/1       Running   0          8m
[Captains-Bay]🚩 >
```

## 

```
[Captains-Bay]🚩 >  kubectl get svc --namespace istio-system
NAME                       TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                                                                                                     AGE
grafana                    ClusterIP      10.101.62.143    <none>        3000/TCP                                                                                                    10m
istio-citadel              ClusterIP      10.101.219.141   <none>        8060/TCP,9093/TCP                                                                                           10m
istio-egressgateway        ClusterIP      10.96.125.10     <none>        80/TCP,443/TCP                                                                                              10m
istio-galley               ClusterIP      10.100.66.185    <none>        443/TCP,9093/TCP                                                                                            10m
istio-ingressgateway       LoadBalancer   10.97.165.8      localhost     80:31380/TCP,443:31390/TCP,31400:31400/TCP,15011:32180/TCP,8060:30450/TCP,15030:30141/TCP,15031:30799/TCP   10m
istio-pilot                ClusterIP      10.103.46.117    <none>        15010/TCP,15011/TCP,8080/TCP,9093/TCP                                                                       10m
istio-policy               ClusterIP      10.96.209.119    <none>        9091/TCP,15004/TCP,9093/TCP                                                                                 10m
istio-sidecar-injector     ClusterIP      10.110.45.147    <none>        443/TCP                                                                                                     10m
istio-statsd-prom-bridge   ClusterIP      10.96.63.79      <none>        9102/TCP,9125/UDP                                                                                           10m
istio-telemetry            ClusterIP      10.108.169.175   <none>        9091/TCP,15004/TCP,9093/TCP,42422/TCP                                                                       10m
jaeger-agent               ClusterIP      None             <none>        5775/UDP,6831/UDP,6832/UDP                                                                                  10m
jaeger-collector           ClusterIP      10.97.14.10      <none>        14267/TCP,14268/TCP                                                                                         10m
jaeger-query               ClusterIP      10.104.91.111    <none>        16686/TCP                                                                                                   10m
prometheus                 ClusterIP      10.101.170.27    <none>        9090/TCP                                                                                                    10m
servicegraph               ClusterIP      10.97.248.121    <none>        8088/TCP                                                                                                    10m
tracing                    ClusterIP      10.110.201.178   <none>        80/TCP                                                                                                      10m
zipkin                     ClusterIP      10.100.105.4     <none>        9411/TCP                                                                                                    10m
[Captains-Bay]🚩 >
```
