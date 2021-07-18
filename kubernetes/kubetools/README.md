# Kubetools - Curated List of Kubernetes Tools


Kubetools was built with a purpose. It is being used by Collabnix Slack community internally to target the most popular tools and technique and coming up with the best practices around these tools. The community is planning to conduct webinar for the most voted tools based on the popularity. Do visit http://webinar.collabnix.com for the upcoming webinars around these tools.

## Upcoming Kubetools Webinar

### Year: 2020

| Date     | Topic        | Registration Link | Presenter   | Presentation          | Video  | Chat |
| ------------- | ---------- |  ------------- | ------------- | ------------- | ------------- | --------| 
| 11-Jan   | Awesome Traefik - Ingress Controller for Kubernetes | [Click](https://zoom.us/webinar/register/WN_vx_lvFp4To6E2ldb4HfIwg) | [Swapnasagar Pradhan ](https://www.linkedin.com/in/swapnasagar-pradhan-724b2649) | [-]() | [-]() | [-](-) |
| 8-Feb   | Building docker images without Dockerfile - Cloud Native Buildpack |  | [Suman Chakraborty ](https://www.linkedin.com/in/schakraborty007) | [-]() | [-]() | [-](-) |

## K8s Cluster Management

kubespray - [Deploy a Production Ready Kubernetes Cluster](https://github.com/kubernetes-sigs/kubespray)<br>
kops - [Production Grade K8s Installation, Upgrades, and Management](https://github.com/kubernetes/kops) <br>
Kube-ops-view - [Kubernetes Operational View - read-only system dashboard for multiple K8s clusters](https://github.com/hjacobs/kube-ops-view) <br>
Kubeprompt - [Kubernetes prompt info](https://github.com/jlesquembre/kubeprompt) <br>
Metalk8s - [An opinionated Kubernetes distribution with a focus on long-term on-prem deployments](https://github.com/scality/metalk8s) <br>
kind - [Kubernetes IN Docker - local clusters for testing Kubernetes](https://github.com/kubernetes-sigs/kind)<br>
Clusterman - Autoscale and Manage your compute clusters - [Cluster Autoscaler for Kubernetes and Mesos](https://github.com/Yelp/clusterman)<br>
Cert-manager - [Automatically provision and manage TLS certificates](https://github.com/jetstack/cert-manager) <br>
Goldilocks - [Get your resource requests "Just Right"](https://github.com/FairwindsOps/goldilocks)<br>
katafygio - [Dump, or continuously backup Kubernetes objets as yaml files in git](https://github.com/bpineau/katafygio)<br>
Sealed Secrets - [A Kubernetes controller and tool for one-way encrypted Secrets](https://github.com/bitnami-labs/sealed-secrets)<br>
OpenKruise/Kruise - [Automate application workloads management on Kubernetes https://openkruise.io](https://github.com/openkruise/kruise)<br>
kubectl snapshot - [Take Cluster Snapshots](https://github.com/fbrubbo/kubectl-snapshot)<br>
Kubernetes Job/CronJob Notifier - [Kuberenets Job/CronJob Notifier](https://github.com/sukeesh/k8s-job-notify)<br>
Kubernetes Janitor - [Clean up (delete) Kubernetes resources after a configured TTL](https://github.com/hjacobs/kube-janitor)<br>
Grafana Tanka - [Tanka is a composable configuration utility for Kubernetes. It leverages the Jsonnet language to realize flexible, reusable and concise configuration](https://tanka.dev)<br>
KubeDirector - [Kubernetes Director (aka KubeDirector) for deploying and managing stateful applications on Kubernetes](https://github.com/bluek8s/kubedirector)<br>


## K8s Cluster with core CLI tools

Bootkube - [bootkube - Launch a self-hosted Kubernetes cluster](https://github.com/kubernetes-sigs/bootkube) <br>
kubectx + kubens - [Switch faster between clusters and namespaces in kubectl](https://github.com/ahmetb/kubectx)<br>
kube-shell - [Kubernetes shell: An integrated shell for working with the Kubernetes](https://github.com/cloudnativelabs/kube-shell)<br>
kuttle: kubectl wrapper for sshuttle without SSH - [Kubernetes wrapper for sshuttle](https://github.com/kayrus/kuttle)<br>
kubectl sudo - [Run kubernetes commands with the security privileges of another user](https://github.com/postfinance/kubectl-sudo)<br>
K9s - [Kubernetes CLI To Manage Your Clusters In Style!](https://github.com/derailed/k9s) <br>
Ktunnel - [A cli that exposes your local resources to kubernetes](https://github.com/omrikiei/ktunnel)<br>
Kubemqctl - [Kubemqctl is a command line interface (CLI) for KubeMQ , Kubernetes Message Broker https://kubemq.io](https://github.com/kubemq-io/kubemqctl)<br>
kubectl-aliases - [Programmatically generated handy kubectl aliases. https://ahmet.im/blog/kubectl-aliases/](https://github.com/ahmetb/kubectl-aliases)<br>
go-kubectx - [5x-10x faster alternative to kubectx. Uses client-go](https://github.com/aca/go-kubectx)<br>
mkubectx - [single command across all your selected kubernetes contexts](https://github.com/witalisoft/mkubectx)<br>

## K8s Alert and Monitoring

Kiali - [Kiali project, observability for the Istio service mesh](https://github.com/kiali/kiali) <br>
Prometheus - [The Prometheus monitoring system and time series database.](https://github.com/prometheus/prometheus) <br>
Grafana - [The tool for beautiful monitoring and metric analytics & dashboards for Graphite, InfluxDB & Prometheus & More](https://github.com/grafana/grafana)  <br>
Kubetail - [Bash script to tail Kubernetes logs from multiple pods at the same time](https://github.com/johanhaleby/kubetail) <br>
Searchlight - [Alerts for Kubernetes](https://github.com/searchlight/searchlight)<br>
linkerd2 Monitoring Mixin for Grafana - [Grafana dashboards for linkerd2 monitoring and can work in standalone (default) or in multi cluster setup](https://github.com/andrew-waters/linkerd2-mixin)<br>
kuberhaus - [Kubernetes resource dashboard with node/pod layout and resource requests](https://github.com/stevelacy/kuberhaus)<br>
Kubernetes Job/CronJob Notifier - [This tool sends an alert to slack whenever there is a Kubernetes cronJob/Job failure/success](https://github.com/sukeesh/k8s-job-notify)<br>

## K8s Troubleshooting

PowerfulSeal - [A powerful testing tool for Kubernetes clusters](https://github.com/bloomberg/powerfulseal)<br>
Crash-diagnostic - [Crash-Diagnostics is a tool to help investigate, analyze, and troubleshoot unresponsive or crashed Kubernetes clusters](https://github.com/vmware-tanzu/crash-diagnostics) <br>
K9s - [Kubernetes CLI To Manage Your Clusters In Style!](https://github.com/derailed/k9s) <br>
Kubernetes CLI Plugin - Doctor - [kubectl cluster triage plugin for k8s - 🏥 (brew doctor equivalent)](https://github.com/emirozer/kubectl-doctor)<br>
Knative Inspect - [A light-weight debugging tool for Knative's system components](https://github.com/nimakaviani/knative-inspect)<br>
Kubeman - [To find information from Kubernetes clusters, and to investigate issues related to Kubernetes and Istio](https://github.com/walmartlabs/kubeman)<br>
Kubectl-debug - [Debug your pod by a new container with every troubleshooting tools pre-installed](https://github.com/aylei/kubectl-debug)<br>
ksniff - [Kubectl plugin to ease sniffing on kubernetes pods using tcpdump and wireshark](https://github.com/eldadru/ksniff)<br>

## K8s Developement Tools

Podtnl: A CLI for Kubernetes Developers & Administrators - [Expose your pod to Online easily from any kubernetes clusters without creating a kubernetes service](https://github.com/narendranathreddythota/podtnl)<br>
Okteto: A Tool for Cloud Native Developers - [Build better applications by developing and testing your code directly in Kubernetes](https://github.com/okteto/okteto)<br>
Tilt: Tilt manages local development instances for teams that deploy to Kubernetes - [Local Kubernetes development with no stress](https://github.com/windmilleng/tilt)<br>
Garden: Kubernetes from source to finish - [Development orchestrator for Kubernetes, containers and functions.](https://github.com/garden-io/garden)<br>
KuberNix - [Single dependency Kubernetes clusters for local testing, experimenting and development](https://github.com/saschagrunert/kubernix)<br>
Copper - [A configuration file validator for Kubernetes](https://github.com/cloud66-oss/copper?utm_sq=g93mop70o8)<br>
ko - [Build and deploy Go applications on Kubernetes](https://github.com/google/ko)<br>
Makisu - [Fast and flexible Docker image building tool, works in unprivileged containerized environments like Mesos and Kubernetes](https://github.com/uber/makisu)<br>
KUDO [Kubernetes Universal Declarative Operator (KUDO) provides a declarative approach to building production-grade Kubernetes operators](https://kudo.dev/docs/)<br>
Aegir - [Validation Webhook for Kubernetes based on LIVR rules (https://livr-spec.org)](https://github.com/grupozap/aegir)<br>
Telepresence - [Debug a Kubernetes service locally, using your favorite debugging tool](https://www.telepresence.io/)<br>

## K8s Alternative Tools for Developement

KubeSphere - [Easy-to-use Production Ready Container Platform https://kubesphere.io](https://github.com/kubesphere/kubesphere)<br>
skippbox - [A Desktop application for k8s](https://github.com/skippbox/skippbox)<br>
Micronetes - [Micronetes is a local orchestrator inspired by kubernetes that makes developing and testing microservices and distributed applications easier](https://github.com/davidfowl/Micronetes)<br>
k3c - Classic Docker for a Kubernetes world - [Lightweight local container engine for container development](https://github.com/rancher/k3c)<br>
Tilt - [Local Kubernetes development with no stress https://tilt.dev/](https://github.com/windmilleng/tilt)<br>

## K8s CI/CD integration Automation Tools

Skaffold - [Easy and Repeatable Kubernetes Development](https://github.com/GoogleContainerTools/skaffold) <br>
Apollo - [Apollo - The logz.io continuous deployment solution over kubernetes](https://github.com/logzio/apollo)<br>
Helm Cabin - [Web UI that visualizes Helm releases in a Kubernetes cluster](https://github.com/Nick-Triller/helm-cabin)<br>
flagger - [Progressive delivery Kubernetes operator (Canary, A/B Testing and Blue/Green deployments)](https://github.com/weaveworks/flagger)<br>
Kubeform - [Kubernetes CRDs for Terraform providers https://kubeform.com](https://github.com/kubeform/kubeform)<br>
Spinnaker - [Spinnaker is an open source, multi-cloud continuous delivery platform for releasing software changes with high velocity and confidence. http://www.spinnaker.io/](https://github.com/spinnaker/spinnaker)<br>
Helmsman - [Helm Charts as Code](https://github.com/Praqma/helmsman/)<br>
Argo - [Argo Workflows: Get stuff done with Kubernetes](https://github.com/argoproj/argo)<br>

## Network Policies

trireme-kubernetes - [Aporeto integration with Kubernetes Network Policies](https://github.com/aporeto-inc/trireme-kubernetes)<br>
Calico - [Cloud native connectivity and network policy ](https://github.com/projectcalico/calico)<br>
kubepox - [Kubernetes network Policy eXploration tool](https://github.com/aporeto-inc/kubepox)<br>
kokotap - [Tools for kubernetes pod network tapping](https://github.com/redhat-nfvpe/kokotap)<br>
Submariner - [Connect all your Kubernetes clusters, no matter where they are in the world](https://github.com/submariner-io/submariner)<br>
egress-operator - [An operator to produce egress gateway pods and control access to them with network policies](https://github.com/monzo/egress-operator)<br>

## K8s Testing Tools

k6 - [A modern load testing tool, using Go and JavaScript](https://github.com/loadimpact/k6) <br>
Network bandwith and load testing - [Test suite for Kubernetes](https://github.com/mrahbar/k8s-testsuite)<br>
test-infra - [Test infrastructure for the Kubernetes project](https://github.com/kubernetes/test-infra)<br>
kube-score - [Kubernetes object analysis with recommendations for improved reliability and security](https://github.com/zegl/kube-score)<br>
Litmus - [Cloud-Native Chaos Engineering; Kubernetes-Native Chaos Engineering; Chaos Engineering for Kubernetes](https://github.com/litmuschaos/litmus)<br>
Datree - [A CLI tool to prevent Kubernetes misconfigurations by ensuring that manifests and Helm charts follow best practices as well as your organization’s policies](https://github.com/datreeio/datree)<br>


## Service Mesh / Ingress

Istio - [Connect, secure, control, and observe services](https://github.com/istio/istio) <br>
Traefik - [The Cloud Native Edge Router](https://github.com/containous/traefik)<br> - [Jan 2020](https://zoom.us/webinar/register/WN_vx_lvFp4To6E2ldb4HfIwg) <br>
NGINX Ingress Controller - [NGINX and NGINX Plus Ingress Controllers for Kubernetes](https://github.com/nginxinc/kubernetes-ingress)<br>
Autopilot - [THE SERVICE MESH SDK](https://docs.solo.io/autopilot/latest)<br>
linkerd-config - [A Kubernetes controller that knows how to reconcile the Linkerd configuration](https://github.com/ihcsim/linkerd-config)<br>
Kong for Kubernetes - [Use Kong for Kubernetes Ingress](https://github.com/Kong/kubernetes-ingress-controller)<br>

## Observability

Kubespy - [Tools for observing Kubernetes resources in real time](https://github.com/pulumi/kubespy) <br>
Popeye - [A Kubernetes cluster resource sanitizer](https://github.com/derailed/popeye) <br>
Stern - [Multi pod and container log tailing for Kubernetes](https://github.com/wercker/stern) <br>
Cri-tools - [CLI and validation tools for Kubelet Container Runtime Interface (CRI)](https://github.com/kubernetes-sigs/cri-tools) <br>
Kubebox - [Terminal and Web console for Kubernetes](https://github.com/astefanutti/kubebox) <br>
Kubewatch - [Watch k8s events and trigger Handlers](https://github.com/bitnami-labs/kubewatch) <br>
kube-state-metrics - [Add-on agent to generate and expose cluster-level metrics](https://github.com/kubernetes/kube-state-metrics)<br>
Sloop - [Kubernetes History Visualization](https://github.com/salesforce/sloop)<br>
kubectl tree 🎄 - [Kubectl plugin to observe object hierarchies through ownerReferences](https://github.com/ahmetb/kubectl-tree)<br>
chaoskube - [chaoskube periodically kills random pods in your Kubernetes cluster](https://github.com/linki/chaoskube)<br>
BotKube - [Helps you monitor your Kubernetes cluster(s), debug critical deployments and gives recommendations for standard practices](https://www.botkube.io/)<br>
Kubestone - [Kubestone is a benchmarking Operator that can evaluate the performance of Kubernetes installations](https://kubestone.io/en/latest)<br>
Chaos Mesh - [A Chaos Engineering Platform for Kubernetes](https://github.com/pingcap/chaos-mesh)<br>

## Machine Learning/Deep Learning

Kubeflow - [Machine Learning Toolkit for Kubernetes](https://github.com/kubeflow/kubeflow)<br>
Volcano - [A Kubernetes Native Batch System](https://github.com/volcano-sh/volcano)<br>

## Compute Edge Tools

KubeEdge - [Kubernetes Native Edge Computing Framework](https://github.com/kubeedge/kubeedge) <br>
Kubeless - [Kubernetes Native Serverless Framework](https://github.com/kubeless/kubeless)<br>

## Kubernetes Tools for Specific Cloud

Kubernetes on AWS (kube-aws) - [A command-line tool to declaratively manage Kubernetes clusters on AWS](https://github.com/kubernetes-incubator/kube-aws) <br>
Draft: Streamlined Kubernetes Development - [A tool for developers to create cloud-native applications on Kubernetes](https://github.com/azure/draft)<br>
helm-ssm - [A low dependency tool for retrieving and injecting secrets from AWS SSM into Helm](https://github.com/totango/helm-ssm)<br>
Skupper - [Multicloud communication for Kubernetes](https://skupper.io/)<br>

## Kubernetes Storage Providers

ChubaoFS - [distributed file system and object storage](https://github.com/chubaofs/chubaofs) <br>
Longhorn - [Cloud-Native distributed block storage built on and for Kubernetes](https://github.com/longhorn/longhorn)<br>
OpenEBS - [Kubernetes native - hyperconverged block storage with multiple storage engines](https://github.com/openebs/openebs)<br>
Rook - [Storage Orchestration for Kubernetes](https://github.com/rook/rook)<br>
TiKV - [Distributed transactional key-value database](https://github.com/tikv/tikv)<br>
velero - [Backup and migrate Kubernetes applications and their persistent volumes](https://github.com/vmware-tanzu/velero)<br>
Vitess - [Vitess is a database clustering system for horizontal scaling of MySQL](https://github.com/vitessio/vitess)<br>
Ubiquity - [Ubiquity Storage Service for Container Ecosystems](https://github.com/IBM/ubiquity)<br>
kubectl-unbound-pvc - [A kubectl plugint to see PVCs which are not in "Bound" state](https://github.com/ishantanu/kubectl-unbound-pvc)<br>

## Kubernetes Security tools

kube-hunter - [Hunt for security weaknesses in Kubernetes clusters](https://github.com/aquasecurity/kube-hunter)<br>
kube-bench - [Checks whether Kubernetes is deployed according to security best practices as defined in the CIS Kubernetes Benchmark](https://github.com/aquasecurity/kube-bench)<br>
Kube-Scan - [kube-scan: Octarine k8s cluster risk assessment tool https://www.octarinesec.com/](https://github.com/octarinesec/kube-scan)<br>
Permission manager - [Permission Manager is a project that brings sanity to Kubernetes RBAC and Users management, Web UI FTW https://sighup.io/](https://github.com/sighupio/permission-manager)<br>
Kubernetes Common Configuration Scoring System (KCCSS) - [Kubernetes Common Configuration Scoring System https://www.octarinesec.com/](https://github.com/octarinesec/kccss)<br>
Sysdig Inspect - [Sysdig Inspect - A powerful opensource interface for container troubleshooting and security investigation https://www.sysdig.org/](https://github.com/draios/sysdig-inspect)<br>

## Kubernetes On Mobile
Cabin, the mobile app for Kubernetes - [The Mobile Dashboard for Kubernetes](https://github.com/bitnami-labs/cabin)<br>
kubenav - [kubenav is the navigator for your Kubernetes clusters right in your pocket. https://kubenav.io](https://github.com/kubenav/kubenav)<br>


## Non-categorize

Rudr - [A Kubernetes implementation of the Open Application Model specification](https://github.com/oam-dev/rudr) <br>
Funktion - [CLI tool for working with funktion](https://github.com/funktionio/funktion)<br>
Alterant - [A simple Kubernetes configuration modifier](https://github.com/cloud66-oss/alterant)<br>
BUCK - [Brigade Universal Controller for Kubernetes](https://github.com/brigadecore/buck)<br>
Chaos Toolkit Kubernetes Support - [Kubernetes driver extension of the Chaos Toolkit probes and actions API](https://github.com/chaostoolkit/chaostoolkit-kubernetes)<br>
kube-fledged - [A kubernetes add-on for creating and managing a cache of container images directly on the cluster worker nodes, so application pods start almost instantly](https://github.com/senthilrch/kube-fledged)<br>


## Maintainer

- [Apurva Bhandari](https://www.linkedin.com/in/apurvabhandari-linux/)


                                             Last Updated Sections - 1st Feb 2020
