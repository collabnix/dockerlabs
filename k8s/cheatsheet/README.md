# The Ultimate Kubernetes Cheatsheet


|Name|	Command|
 --- | ---
|Run curl test temporarily|	kubectl run --rm mytest --image=yauritux/busybox-curl -it|
|Run wget test temporarily|	kubectl run --rm mytest --image=busybox -it|
|List everything|	kubectl get all --all-namespaces|
|List pods with nodes info|	kubectl get pod -o wide|
|Show nodes with labels|	kubectl get nodes --show-labels|
|Validate yaml file with dry run|	kubectl create --dry-run --validate -f pod-dummy.yaml|
|Start a temporary pod for testing|	kubectl run --rm -i -t --image=alpine test-$RANDOM -- sh|
|kubectl run shell command|	kubectl exec -it mytest -- ls -l /etc/hosts|
|Get system conf via configmap|	kubectl -n kube-system get cm kubeadm-config -o yaml|
|kubectl run instance with replicas|	kubectl run my-nginx --image=nginx --replicas=2 --port=80|
|Explain resource|	kubectl explain pods, kubectl explain svc|
|Get all services|	kubectl get service --all-namespaces|
|Watch pods|	kubectl get pods -n wordpress --watch|
|Query healthcheck endpoint|	curl -L http://127.0.0.1:10250/healthz|
|Open a bash terminal in a pod|	kubectl exec -it storage sh|
|Check pod environment variables|	kubectl exec redis-master-ft9ex env|
|Enable kubectl shell autocompletion|	echo "source <(kubectl completion bash)" >>~/.bashrc, and reload|
|Use minikube dockerd in your laptop|	eval $(minikube docker-env), No need to push docker hub any more|
|Get services sorted by name|	kubectl get services –sort-by=.metadata.name|
|Get pods sorted by restart count|	kubectl get pods –sort-by=’.status.containerStatuses[0].restartCount’|
|Get node resource usage|	kubectl top node|
|Get pod resource usage|	kubectl top pod|
|Get resource usage for a given pod|	kubectl top <podname> --containers|
|List resource utilization for all containers|	kubectl top pod --all-namespaces --containers=true|
|Delete pod|	kubectl delete pod/<pod-name> -n <my-namespace>|
|Delete pods by labels|	kubectl delete pod -l env=test|
|Delete deployments by labels|	kubectl delete deployment -l app=wordpress|
|Delete all resources filtered by labels|	kubectl delete pods,services -l name=myLabel|
|Delete resources under a namespace|	kubectl -n my-ns delete po,svc --all|
|Delete persist volumes by labels|	kubectl delete pvc -l app=wordpress|
|Delete statefulset only (not pods)|	kubectl delete sts/<stateful_set_name> --cascade=false|
|List all pods|	kubectl get pods|
|List pods for all namespace|	kubectl get pods -all-namespaces|
|List all critical pods|	kubectl get -n kube-system pods -a|
|List pods with more info|	kubectl get pod -o wide, kubectl get pod/<pod-name> -o yaml|
|Get pod info|	kubectl describe pod/srv-mysql-server|
|List all pods with labels|	kubectl get pods --show-labels|
|Get Pod initContainer status|	kubectl get pod --template '{{.status.initContainerStatuses}}' <pod-name>|
|kubectl run command|	kubectl exec -it -n “$ns” “$podname” – sh -c “echo $msg >>/dev/err.log”|
|Watch pods|	kubectl get pods -n wordpress --watch|
|Get pod by selector|	podname=$(kubectl get pods -n $namespace –selector=”app=syslog” -o jsonpath='{.items[*].metadata.name}’)|
|List pods and containers|	kubectl get pods -o=’custom-columns=PODS:.metadata.name,CONTAINERS:.spec.containers[*].name’|
|List pods, containers and images|	kubectl get pods -o=’custom-columns=PODS:.metadata.name,CONTAINERS:.spec.containers[*].name,Images:.spec.containers[*].image’|
|Scale out|	kubectl scale --replicas=3 deployment/nginx-app|
|online rolling upgrade|	kubectl rollout app-v1 app-v2 --image=img:v2|
|Roll backup|	kubectl rollout app-v1 app-v2 --rollback|
|List rollout|	kubectl get rs|
|Check update status|	kubectl rollout status deployment/nginx-app|
|Check update history|	kubectl rollout history deployment/nginx-app|
|Pause/Resume|	kubectl rollout pause deployment/nginx-deployment, resume|
|Rollback to previous version|	kubectl rollout undo deployment/nginx-deployment|
|List Resource Quota|	kubectl get resourcequota|
|List Limit Range|	kubectl get limitrange|
|Customize resource definition|	kubectl set resources deployment nginx -c=nginx --limits=cpu=200m,memory=512Mi|
|List all services|	kubectl get services|
|List service endpoints|	kubectl get endpoints|
|Get service detail|	kubectl get service nginx-service -o yaml|
|Get service cluster ip|	kubectl get service nginx-service -o go-template='{{.spec.clusterIP}}’|
|Get service cluster port|	kubectl get service nginx-service -o go-template='{{(index .spec.ports 0).port}}’|
|Expose deployment as lb service|	kubectl expose deployment/my-app --type=LoadBalancer --name=my-service|
|Expose service as lb service|	kubectl expose service/wordpress-1-svc --type=LoadBalancer --name=wordpress-lb|
|List statefulset|	kubectl get sts|
|Delete statefulset only (not pods)|	kubectl delete sts/<stateful_set_name> --cascade=false|
|Scale statefulset|	kubectl scale sts/<stateful_set_name> --replicas=5|
|Patch service to loadbalancer|	kubectl patch svc "$APP_INSTANCE_NAME-grafana" -p '{"spec": {"type": "LoadBalancer"}}'|
|Check the mounted volumes|	kubectl exec storage ls /data|
|Check persist volume|	kubectl describe pv/pv0001|
|List storage class|	kubectl get storageclass|
|Copy files|	kubectl cp /tmp/foo <namespace1>/<pod1>:/tmp/bar|
|List certificates|	kubectl get csr|
|List api group|	kubectl api-versions|
|List all CRD|	kubectl get crd|
|Validate yaml file with dry run|	kubectl create --dry-run --validate -f pod-dummy.yaml|
|Start a temporary pod for testing|	kubectl run --rm -i -t --image=alpine test-$RANDOM -- sh|
|Run wget test temporarily|	kubectl run --rm mytest --image=busybox -it|
|Run curl test temporarily|	kubectl run --rm mytest --image=yauritux/busybox-curl -it|
|Get system conf via configmap|	kubectl -n kube-system get cm kubeadm-config -o yaml|
|Explain resource|	kubectl explain pods, kubectl explain svc|
|Get all services|	kubectl get service --all-namespaces|
|Get services sorted by name|	kubectl get services –sort-by=.metadata.name|
|Get pods sorted by restart count|	kubectl get pods –sort-by=’.status.containerStatuses[0].restartCount’|
|Query healthcheck endpoint|	curl -L http://127.0.0.1:10250/healthz|
|Open a bash terminal in a pod|	kubectl exec -it storage sh|
|Check pod environment variables|	kubectl exec redis-master-ft9ex env|
|Enabling shell autocompletion for kubectl|	echo "source <(kubectl completion bash)" >> ~/.bashrc, then reconnect|
|Get node resource usage|	kubectl top node|
|Get pod resource usage|	kubectl top pod|
|Get resource usage for a given pod|	kubectl top <podname> --containers|
|List resource utilization for all containers|	kubectl top pod --all-namespaces --containers=true|
|Delete pod|	kubectl delete pod hello-node-95913-n63qs -n $my-namespace|
|Delete pods by labels|	kubectl delete pod -l env=test|
|Delete deployments by labels|	kubectl delete deployment -l app=wordpress|
|Delete persist volumes by labels|	kubectl delete pvc -l app=wordpress|
|Delete statefulset only (not pods)|	kubectl delete sts <stateful_set_name> --cascade=false|
|List authenticated contexts|	kubectl config get-contexts|
|Load context from config file|	kubectl get cs --kubeconfig kube_config.yml|
|List contexts|	kubectl config get-contexts|
|Switch context|	kubectl config use-context <cluster-name>|
|Delete the specified context|	kubectl config delete-context <cluster-name>|
|List all namespaces defined|	kubectl get namespaces|
|kubectl config file|	~/.kube/config|
|Temporarily add a port-forwarding|	kubectl port-forward redis-izl09 6379|
|Add port-forwaring for deployment|	kubectl port-forward deployment/redis-master 6379:6379|
|Add port-forwaring for replicaset|	kubectl port-forward rs/redis-master 6379:6379|
|Add port-forwaring for service|	kubectl port-forward svc/redis-master 6379:6379|
|Get network policy|	kubectl get NetworkPolicy|
|Get cluster info|	kubectl cluster-info|
|Get configuration|	kubectl config view|
|Get kubectl version|	kubectl version|
|Get component status|	kubectl get componentstatus|
|Similar to docker ps|	kubectl get nodes|
|Similar to docker inspect|	kubectl describe pod/nginx-app-413181-cn|
|Similar to docker logs|	kubectl logs|
|Similar to docker exec|	kubectl exec|
|Get services for current namespace|	kubectl get svc|
|Get node status|	kubectl describe node/<node_name>|
|API Server.log= in master node|	/var.log=/kube-apiserver.log|
|Scheduler.log= in master node|	/var.log=/kube-scheduler.log|
|Controller.log= in master node|	/var.log=/kube-controller-manager.log|
|Kubelet.log= in worker node|	/var.log=/kubelet.log|
|Kube Proxy.log= in worker node|	/var.log=/kubelet-proxy.log|
|Config folder|	/etc/kubernetes/|
|Certificate files|	/etc/kubernetes/pki/|
|Credentials to API server|	/etc/kubernetes/kubelet.conf|
|Superuser credentials|	/etc/kubernetes/admin.conf|
|Kubernets working dir|	/var/lib/kubelet/|
|Docker working dir|	/var/lib/docker/|
|Etcd working dir|	/var/lib/etcd/|
|Network cni|	/etc/cni/net.d/|
|Docker container log|	/var/log/containers/|
|Log files|	/var/log/pods/|
|Env|	export KUBECONFIG=/etc/kubernetes/admin.conf|
|Env|	/etc/systemd/system/kubelet.service.d/10-kubeadm.conf|
|Get ExternalIPs of all nodes|	kubectl get nodes -o jsonpath=’{.items[*].status.addresses[?(@.type==”ExternalIP”)].address}’|
|Add a label|	kubectl label pods busybox-sleep new-label=new-busybox-sleep|
|Add an annotation|	kubectl annotate pods busybox-sleep icon-url=http://goo.gl/XXBTWq|
|Auto scale a deployment nginx|	kubectl autoscale deployment nginx --min=2 --max=5|
|Rolling update pods of frontend-v1|	kubectl rolling-update frontend-v1 -f frontend-v2.json|
|Force replace, delete and then re-create the resource. Will cause a service outage|	kubectl replace --force -f ./pod.json|
|Create a service for a replicated nginx, which serves on port 80 and connects to the containers on port 8000|	kubectl expose rc nginx --port=80 --target-port=8000|
|Partially update a node|	kubectl patch node k8s-node-1 -p ‘{“spec”:{“unschedulable”:true}}’|
|Update a container’s image; spec.containers[*].name is required because it’s a merge key|	kubectl patch pod valid-pod -p ‘{“spec”:{“containers”:[{“name”:”kubernetes-serve-hostname”,”image”:”new image”}]}}’|
|Edit the service named docker-registry|	kubectl edit svc/docker-registry|
|Scale multiple replication controllers|	kubectl scale --replicas=5 rc/foo rc/bar rc/baz|
|Delete pods and services with same names “baz” and “foo”|	kubectl delete pod,service baz foo|
|dump pod logs (stdout)|	kubectl logs busybox-sleep|
|stream pod logs (stdout)|	kubectl logs -f hello-minikube-3015430129-vfgei|
|Run pod as interactive shell|	kubectl run -i --tty busybox --image=busybox -- sh|
|Attach to Running Container|	kubectl attach my-pod -i|
|Mark a specific node as unschedulable|	kubectl cordon minikube|
|Mark a specific node as schedulable|	kubectl uncordon minikube|
|Dump current cluster state to stdout|	kubectl cluster-info dump|
|Dump current cluster state to /path/to/cluster-state|	kubectl cluster-info dump --output-directory=/path/to/cluster-state|
|Print the version of the API Server|	kubectl API version|
|Removes pods from node via graceful termination for maintenance|	kubectl drain NODE|
|Find the names of the objects that will be removed|	kubectl drain NODE --dryrun=true|
|Removes pods even if they are not managed by controller|	kubectl drain NODE --force=true|
|Taint a node so they can only run dedicated workloads or certain pods that need specialized hardware|	kubectl taint nodes node1 key=value:NoSchedule|
|Create a clusterIP for a service named foo|	kubectl create service clusterip foo --tcp=5678:8080|
|Autoscale pod foo with a minimum of 2 and maximum of 10 replicas when CPU utilization is equal to or greater than 70%|	kubectl autoscale deployment foo --min=2 --max=10 --cpupercent=70|

 
 ## Contributor
 
 - Bala
