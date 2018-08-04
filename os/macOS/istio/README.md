# Installing Istio on Docker for Mac 18.06 CE

```
[Captains-Bay]🚩 >  kubectl cluster-info
Kubernetes master is running at https://localhost:6443
KubeDNS is running at https://localhost:6443/api/v1/namespaces/kube-system/services/kube-dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
[Captains-Bay]🚩 >
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

