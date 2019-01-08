# Cheatsheet - Kubectl

Kubectl is a command line interface for running commands against Kubernetes clusters.

## Installing

The kubectl version has to be within one minor version difference of the Kubernetes cluster. For example, a v1.2 client should work with v1.1, v1.2, and v1.3 master.

Kubectl can be installed on Ubuntu, Debian, CentOS, RedHat operating systems.

### Ubuntu / Debian

```bash
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

### CentOS / RedHat

```bash
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl
```

For further information about kubectl installation method, please refer to [the Kubernetes documentation.](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## Syntax

Kubectl is a powerful tool to manage each object on a Kubernetes cluster. The command has a simple and unique syntax to manage everything :

```bash
kubectl [command] [TYPE] [NAME] [flags]
```

* *command* : specifies the operation that you want to perform on one or more resources (create, get, describe, delete)
* *type* : specifies the resource type. Resource types are case-insensitive and you can specify the singular, plural, or abbreviated forms
* *name* : specifies the name of the resource. Names are case-sensitive. If the name is omitted, details for all resources are displayed
* *flags* : specifies optional flags.

## Useful commands

The tables following give you some useful commands that you will probably use in the Kubernetes resources management.

### Cluster

Some useful commands on Kubernetes cluster management.

| Description | Command |
 --- | ---
| Get all nodes with their labels | kubectl get nodes --show-labels |
| Describe a node | kubectl describe nodes <node-name> |
| Get nodes resources usage | kubectl top node |
| Get existing context | kubectl config get-contexts |
| Get current context | kubectl config current-context |
| Switch to another context | kubectl config use-context <cluster-name> |
| Delete a context  | kubectl config delete-context <cluster-name> |
| Get all namespaces | kubectl get namespaces |
| Delete resources under a namespace | kubectl -n <namespace-name> delete po,svc --all |
| Delete a specific namespace | kubectl delete namespaces <namespace-name> |
| Get cluster info | kubectl cluster-info |
| Get configuration | kubectl config view |
| List api group | kubectl api-versions |
| List all CRD | kubectl get crd |
| List certificates | kubectl get csr |
| List Resource Quotas | kubectl get resourcequota |
| Get Network Policies | kubectl get NetworkPolicy |
| List Limit Range | kubectl get limitrange |

## Deployments

Some useful commands on Kubectl Deployment management.

|Description|Command|
 --- | ---
| Start a temporary deployment | kubectl run <deployment-name> --rm -i -t --image=alpine -- sh |
| Delete Deployments by labels | kubectl delete deployment -l app=wordpress |
| Update the image of a Deployment | kubectl set deployment <deployment-name> --image  |
| Roll backup | kubectl rollout app-v1 app-v2 --rollback |
| List rollout | kubectl rollout history |
| Check update status | kubectl rollout status deployment/nginx-app |
| Check update history | kubectl rollout history deployment/nginx-app |
| Pause/Resume | kubectl rollout pause deployment/nginx-deployment, resume |
| Rollback to previous version | kubectl rollout undo deployment/nginx-deployment |

## Kubectl

Some useful commands on Kubectl management.

|Description|Command|
 --- | ---
|Explain resource|kubectl explain pods, kubectl explain svc|
|List everything|kubectl get all --all-namespaces|
|Validate yaml file with dry run|kubectl create --dry-run --validate -f pod-dummy.yaml|
|Get kubectl version|kubectl version|
|Similar to docker inspect|kubectl describe pod/nginx-app-413181-cn|
|Similar to docker logs|kubectl logs|
|Copy files|kubectl cp /tmp/foo <namespace1>/<pod1>:/tmp/bar|

## Pods

Some useful commands on Kubectl Pods management.

|Description|Command|
 --- | ---
|List all critical pods|kubectl get -n kube-system pods -a|  |
|List pods with nodes info|kubectl get pod -o wide|
|Check pod environment variables|kubectl exec redis-master-ft9ex env|
|Run curl test temporarily|kubectl run --rm mytest --image=yauritux/busybox-curl -it|
|Open a bash terminal in a pod|kubectl exec -it storage sh|
|Run wget test temporarily|kubectl run --rm mytest --image=busybox -it|
|Run a shell command in a Pod|kubectl exec -it mytest -- ls -l /etc/hosts|
|kubectl run instance with replicas|kubectl run my-nginx --image=nginx --replicas=2 --port=80|
|Watch pods|kubectl get pods -n wordpress --watch|
|Get pods sorted by restart count|kubectl get pods –sort-by=’.status.containerStatuses[0].restartCount’|
|Get resource usage for a given pod|kubectl top <podname> --containers|
|Validate yaml file with dry run|kubectl create --dry-run --validate -f pod-dummy.yaml|
|Get pods sorted by restart count|kubectl get pods –sort-by=’.status.containerStatuses[0].restartCount’|
|Open a bash terminal in a pod|kubectl exec -it storage sh|
|Get pod resource usage|kubectl top pod|
|List resource utilization for all containers|kubectl top pod --all-namespaces --containers=true|
|Delete pod|kubectl delete pod/<pod-name> -n <my-namespace>|
|Delete pods by labels|kubectl delete pod -l env=test|
|List all pods|kubectl get pods|
|List pods for all namespace|kubectl get pods -all-namespaces|
|Get pod info|kubectl describe pod/srv-mysql-server|
|List all pods with labels|kubectl get pods --show-labels|
|Get Pod initContainer status|kubectl get pod --template '{{.status.initContainerStatuses}}' <pod-name>|
|Get pod by selector|podname=$(kubectl get pods -n $namespace –selector=”app=syslog” -o jsonpath='{.items[*].metadata.name}’)|
|List pods and containers|kubectl get pods -o=’custom-columns=PODS:.metadata.name,CONTAINERS:.spec.containers[*].name’|
|List pods, containers and images|kubectl get pods -o=’custom-columns=PODS:.metadata.name,CONTAINERS:.spec.containers[*].name,Images:.spec.containers[*].image’|
|Scale out|kubectl scale --replicas=3 deployment/nginx-app|

## Services

Some useful commands on Kubectl Service management.

|Description|Command|
 --- | ---
|Get services sorted by name|kubectl get services –sort-by=.metadata.name|
|Get all services|kubectl get service --all-namespaces|
|Get services sorted by name|kubectl get services –sort-by=.metadata.name|
|List service endpoints|kubectl get wendpoints|
|Export service details in yaml file|kubectl get service nginx-service -o yaml|
|Get service cluster ip|kubectl get service nginx-service -o go-template='{{.spec.clusterIP}}’|
|Get service cluster port|kubectl get service nginx-service -o go-template='{{(index .spec.ports 0).port}}’|
|Expose deployment as lb service|kubectl expose deployment/my-app --type=LoadBalancer --name=my-service|
|Temporarily add a port-forwarding|kubectl port-forward redis-izl09 6379|
|Add port-forwaring for deployment|kubectl port-forward deployment/redis-master 6379:6379|
|Add port-forwaring for replicaset|kubectl port-forward rs/redis-master 6379:6379|
|Add port-forwaring for service|kubectl port-forward svc/redis-master 6379:6379|
|Expose service as lb service|kubectl expose service/wordpress-1-svc --type=LoadBalancer --name=wordpress-lb|
|Patch service to loadbalancer|kubectl patch svc "$APP_INSTANCE_NAME-grafana" -p '{"spec": {"type": "LoadBalancer"}}'|

## Statefulset

Some useful commands on Kubectl Statefulset management.

|Description|Command|
 --- | ---
|Delete statefulset only (not pods)|kubectl delete sts/<stateful_set_name> --cascade=false|
|List statefulset|kubectl get sts|
|Delete statefulset only (not pods)|kubectl delete sts/<stateful_set_name> --cascade=false|

## Volumes

Some useful commands on Kubectl Statefulset management.

|Description|Command|
 --- | ---
|Check the mounted volumes|kubectl exec storage ls /data|
|Check persist volume|kubectl describe pv/pv0001|
|List storage class|kubectl get storageclass|

# External documentation

To go further in the management of Kubectl, please refer to these documentations :

* Official Kubernetes [overview of Kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) command line
* Official Kubernetes documentation to [install Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) command line
* Official [Kubectl commands](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands) details

 ## Contributors

[Bala](https://www.linkedin.com/in/balasundaram-natarajan-43471115) - balasundarammaster@gmail.com
[Wikitops](https://github.com/wikitops) - wikitops5692@gmail.com
