# Kubernetes Developer Concepts


Kubernetes has a number of abstractions that map to API objects. These Kubernetes API Objects can be used to describe your cluster's desired state which will include info such as applications and workloads running, replicas, container images, networking resources and more. This section explains the key concepts relevant from an application developer perspecitve.




## Pod

A Pod is the smallest deployable unit that can be created, scheduled, and managed. It’s a logical collection of containers that belong to an application. Pods are created in a namespace. All containers in a pod share the namespace, volumes and networking stack. This allows containers in the pod to "`find`" each other and communicate using `localhost`.

## Create a Pod

Each resource in Kubernetes can be defined using a configuration file. For example, an NGINX pod can be defined with configuration file shown in below:

	apiVersion: v1
	kind: Pod
	metadata:
	  name: nginx-pod
	  labels:
	    name: nginx-pod
	spec:
	  containers:
	  - name: nginx
	    image: nginx:latest
	    ports:
	    - containerPort: 80

Create the pod as shown below:

	$ kubectl create -f templates/pod.yaml
	pod "nginx-pod" created


Get the list of pod:

	$ kubectl get pods
	NAME        READY     STATUS    RESTARTS   AGE
	nginx-pod   1/1       Running   0          22s

Verify that the pod came up fine:

	kubectl -n default port-forward $(kubectl -n default get pod -l name=nginx-pod -o jsonpath='{.items[0].metadata.name}') 8080:80 & open http://localhost:8080/

This opens up a browser window and shows the NGINX main page:

image::nginx-pod-default-page.png[]

If the containers in the pod generate logs, then they can be seen using the command shown:

	$ kubectl logs nginx-pod
	127.0.0.1 - - [03/Nov/2017:17:33:30 +0000] "GET / HTTP/1.1" 200 612 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36" "-"
	127.0.0.1 - - [03/Nov/2017:17:33:32 +0000] "GET /favicon.ico HTTP/1.1" 404 571 "http://localhost:8080/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36" "-"
	2017/11/03 17:33:32 [error] 5#5: *2 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 127.0.0.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "localhost:8080", referrer: "http://localhost:8080/"

## Delete a Pod

Delete the pod as shown below:

	$ kubectl delete -f templates/pod.yaml

##  Deployment

A "`desired state`", such as 4 replicas of a pod, can be described in a Deployment object. The Deployment controller in Kubernetes cluster then ensures the desired and the actual state are matching. Deployment ensures the recreation of a pod when the worker node fails or reboots. If a pod dies, then a new pod is started to ensure the desired vs actual matches. It also allows both up- and down-scaling the number of replicas. This is achieved using ReplicaSet. The Deployment manages the ReplicaSets and provides updates to those pods.

##  Create a Deployment

The folowing example will create a Deployment with 3 replicas of NGINX base image. Let's begin with the template:

	apiVersion: extensions/v1beta1
	kind: Deployment # kubernetes object type
	metadata:
	  name: nginx-deployment # deployment name
	spec:
	  replicas: 3 # number of replicas
	  template:
	    metadata:
	      labels:
	        app: nginx # pod labels
	    spec:
	      containers:
	      - name: nginx # container name
	        image: nginx:1.12.1 # nginx image
	        imagePullPolicy: IfNotPresent # if exists, will not pull new image
	        ports: # container and host port assignments
	        - containerPort: 80
	        - containerPort: 443

This deployment will create 3 instances of NGINX image.

Run the following command to create Deployment:

	$ kubectl create -f templates/deployment.yaml --record
	deployment "nginx-deployment" created

The `--record` flag will track changes made through each revision.

To monitor deployment rollout status:

	$ kubectl rollout status deployment/nginx-deployment
	deployment "nginx-deployment" successfully rolled out

A Deployment creates a ReplicaSet to manage the number of replicas. Let's take a look at existing deployments and replica set.

## Get the deployments:

	$ kubectl get deployments
	NAME               DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
	nginx-deployment   3         3         3            3           25s

## Get the replica set for the deployment:

	$ kubectl get replicaset
	NAME                          DESIRED   CURRENT   READY     AGE
	nginx-deployment-3441592026   3         3         3         1m

## Get the list of running pods:

	$ kubectl get pods
	NAME                                READY     STATUS    RESTARTS   AGE
	nginx-deployment-3441592026-ddpf0   1/1       Running   0          2m
	nginx-deployment-3441592026-kkp8h   1/1       Running   0          2m
	nginx-deployment-3441592026-lx304   1/1       Running   0          2m

## Scaling a Deployment

Number of replicas for a Deployment can be scaled using the following command:

	$ kubectl scale --replicas=5 deployment/nginx-deployment
	deployment "nginx-deployment" scaled

## Verify the deployment:

	$ kubectl get deployments
	NAME               DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
	nginx-deployment   5         5         5            5           2m

## Verify the pods in the deployment:

	$ kubectl get pods
	NAME                                READY     STATUS    RESTARTS   AGE
	nginx-deployment-3441592026-36957   1/1       Running   0          44s
	nginx-deployment-3441592026-8wch5   1/1       Running   0          44s
	nginx-deployment-3441592026-ddpf0   1/1       Running   0          3m
	nginx-deployment-3441592026-kkp8h   1/1       Running   0          3m
	nginx-deployment-3441592026-lx304   1/1       Running   0          3m

## Update a Deployment

A more general update to Deployment can be made by making edits to the pod spec. In this example, let's change to the latest nginx image.

First, type the following to open up a text editor:

	$ kubectl edit deployment/nginx-deployment

Next, change the image from `nginx:1.12.1` to `nginx:latest`.

This should perform a rolling update of the deployment. To track the deployment details such as revision, image version, and ports - type in the following:

```
$ kubectl describe deployments
Name:                   nginx-deployment
Namespace:              default
CreationTimestamp:      Mon, 23 Oct 2017 09:14:36 -0400
Labels:                 app=nginx
Annotations:            deployment.kubernetes.io/revision=2
                        kubernetes.io/change-cause=kubectl edit deployment/nginx-deployment
Selector:               app=nginx
Replicas:               5 desired | 5 updated | 5 total | 5 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  1 max unavailable, 1 max surge
Pod Template:
  Labels:  app=nginx
  Containers:
   nginx:
    Image:        nginx:latest
    Ports:        80/TCP, 443/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
OldReplicaSets:  <none>
NewReplicaSet:   nginx-deployment-886641336 (5/5 replicas created)
Events:
  Type    Reason             Age                From                   Message
  ----    ------             ----               ----                   -------
  Normal  ScalingReplicaSet  4m                 deployment-controller  Scaled up replica set nginx-deployment-3441592026 to 3
  Normal  ScalingReplicaSet  1m                 deployment-controller  Scaled up replica set nginx-deployment-3441592026 to 5
  Normal  ScalingReplicaSet  32s                deployment-controller  Scaled up replica set nginx-deployment-886641336 to 1
  Normal  ScalingReplicaSet  32s                deployment-controller  Scaled down replica set nginx-deployment-3441592026 to 4
  Normal  ScalingReplicaSet  32s                deployment-controller  Scaled up replica set nginx-deployment-886641336 to 2
  Normal  ScalingReplicaSet  29s                deployment-controller  Scaled down replica set nginx-deployment-3441592026 to 3
  Normal  ScalingReplicaSet  29s                deployment-controller  Scaled up replica set nginx-deployment-886641336 to 3
  Normal  ScalingReplicaSet  28s                deployment-controller  Scaled down replica set nginx-deployment-3441592026 to 2
  Normal  ScalingReplicaSet  28s                deployment-controller  Scaled up replica set nginx-deployment-886641336 to 4
  Normal  ScalingReplicaSet  25s (x3 over 26s)  deployment-controller  (combined from similar events): Scaled down replica set nginx-deployment-3441592026 to 0
```

## Rollback a Deployment

To rollback to a previous version, first check the revision history:

	$ kubectl rollout history deployment/nginx-deployment
	deployments "nginx-deployment"
	REVISION  CHANGE-CAUSE
	1         kubectl scale deployment/nginx-deployment --replicas=5
	2         kubectl edit deployment/nginx-deployment

If you only want to rollback to the previous revision, enter the following command:

	$ kubectl rollout undo deployment/nginx-deployment
	deployment "nginx-deployment" rolled back

In our case, the deployment will rollback to use the `nginx:1.12.1` image. Check the image name:

	$ kubectl describe deployments | grep Image
    Image:        nginx:1.12.1

If rolling back to a specific revision then enter:

	$ kubectl rollout undo deployment/nginx-deployment --to-revision=<version>

## Delete a Deployment

Run the following command to delete the Deployment:

	$ kubectl delete -f templates/deployment.yaml
	deployment "nginx-deployment" deleted

## Service

A pod is ephemeral. Each pod is assigned a unique IP address. If a pod that belongs to a replication controller dies, then it is recreated and may be given a different IP address. Further, additional pods may be created using Deployment or Replica Set. This makes it difficult for an application server, such as WildFly, to access a database, such as MySQL, using its IP address.

A Service is an abstraction that defines a logical set of pods and a policy by which to access them. The IP address assigned to a service does not change over time, and thus can be relied upon by other pods. Typically, the pods belonging to a service are defined by a label selector. This is similar mechanism to how pods belong to a replica set.

This abstraction of selecting pods using labels enables a loose coupling. The number of pods in the deployment may scale up or down but the application server can continue to access the database using the service.

A Kubernetes service defines a logical set of pods and enables them to be accessed through microservices.

## Create a Deployment for Service

Pods belong to a service by using a loosely-coupled model where labels are attached to a pod and a service picks the pods by using those labels.

Let's create a Deployment first that will create 3 replicas of a pod:

	apiVersion: extensions/v1beta1
	kind: Deployment
	metadata:
	  name: echo-deployment
	spec:
	  replicas: 3
	  template:
	    metadata:
	      labels:
	        app: echo-pod
	    spec:
	      containers:
	      - name: echoheaders
	        image: gcr.io/google_containers/echoserver:1.4
	        imagePullPolicy: IfNotPresent
	        ports:
	        - containerPort: 8080


This example creates an echo app that responds with HTTP headers from an Elastic Load Balancer.

Type the following to create the deployment:

	$ kubectl create -f templates/echo-deployment.yaml --record

Use the `kubectl describe deployment` command to confirm `echo-app` has been deployed:

```
$ kubectl describe deployment
Name:                   echo-deployment
Namespace:              default
CreationTimestamp:      Mon, 23 Oct 2017 10:07:47 -0400
Labels:                 app=echo-pod
Annotations:            deployment.kubernetes.io/revision=1
                        kubernetes.io/change-cause=kubectl create --filename=templates/echo-deployment.yaml --record=true
Selector:               app=echo-pod
Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  1 max unavailable, 1 max surge
Pod Template:
  Labels:  app=echo-pod
  Containers:
   echoheaders:
    Image:        gcr.io/google_containers/echoserver:1.4
    Port:         8080/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
OldReplicaSets:  <none>
NewReplicaSet:   echo-deployment-3396249933 (3/3 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  10s   deployment-controller  Scaled up replica set echo-deployment-3396249933 to 3
```

## Get the list of pods:

```
$ kubectl get pods
NAME                               READY     STATUS    RESTARTS   AGE
echo-deployment-3396249933-8slzp   1/1       Running   0          1m
echo-deployment-3396249933-bjwqj   1/1       Running   0          1m
echo-deployment-3396249933-r05nr   1/1       Running   0          1m
```

## Check the label for a pod:

```
$ kubectl describe pods/echo-deployment-3396249933-8slzp | grep Label
Labels:         app=echo-pod
```

Each pod in this deployment has `app=echo-pod` label attached to it.

## Create a Service

In the following example, we create a service `echo-service`:

	apiVersion: v1
	kind: Service
	metadata:
	  name: echo-service
	spec:
	  selector:
	    app: echo-pod
	  ports:
	  - name: http
	    protocol: TCP
	    port: 80
	    targetPort: 8080
	  type: LoadBalancer

The set of pods targeted by the service are determined by the label `app: echo-pod` attached to them. It also defines an inbound port 80 to the target port of 8080 on the container.

Kubernetes supports both TCP and UDP protocols.

## Publish a Service

A service can be published to an external IP using the `type` attribute. This attribute can take one of the following values:

. `ClusterIP`: Service exposed on an IP address inside the cluster. This is the default behavior.
. `NodePort`: Service exposed on each Node's IP address at a defined port.
. `LoadBalancer`: If deployed in the cloud, exposed externally using a cloud-specific load balancer.
. `ExternalName`: Service is attached to the `externalName` field. It is mapped to a CNAME with the value.

Let's publish the service load balancer and expose your services, add a `type` field of `LoadBalancer`.

This template will expose `echo-app` service on an Elastic Load Balancer (ELB):

	apiVersion: v1
	kind: Service
	metadata:
	  name: echo-service
	spec:
	  selector:
	    app: echo-pod
	  ports:
	  - name: http
	    protocol: TCP
	    port: 80
	    targetPort: 8080
	  type: LoadBalancer

Run the following command to create the service:

	$ kubectl create -f templates/service.yaml --record

## Get more details about the service:

```
$ kubectl get svc
NAME           TYPE           CLUSTER-IP       EXTERNAL-IP        PORT(S)        AGE
echo-service   LoadBalancer   100.66.161.199   ad0b47976b7fe...   80:30125/TCP   40s
kubernetes     ClusterIP      100.64.0.1       <none>             443/TCP        1h
$ kubectl describe service echo-service
Name:                     echo-service
Namespace:                default
Labels:                   <none>
Annotations:              kubernetes.io/change-cause=kubectl create --filename=templates/service.yaml --record=true
Selector:                 app=echo-pod
Type:                     LoadBalancer
IP:                       100.66.161.199
LoadBalancer Ingress:     ad0b47976b7fe11e7a8870e55a29a6a9-1770422890.us-east-1.elb.amazonaws.com
Port:                     http  80/TCP
TargetPort:               8080/TCP
NodePort:                 http  30125/TCP
Endpoints:                100.96.3.8:8080,100.96.4.9:8080,100.96.5.9:8080
Session Affinity:         None
External Traffic Policy:  Cluster
Events:
  Type    Reason                Age   From                Message
  ----    ------                ----  ----                -------
  Normal  CreatingLoadBalancer  58s   service-controller  Creating load balancer
  Normal  CreatedLoadBalancer   56s   service-controller  Created load balancer
```

The output shows `LoadBalancer Ingress` as the addres of an Elastic Load Balancer (ELB). It takes about 2-3 minutes for the ELB to be provisioned and be available. Wait for a couple of minutes, and then access the service:

```
$ curl http://ad0b47976b7fe11e7a8870e55a29a6a9-1770422890.us-east-1.elb.amazonaws.com
CLIENT VALUES:
client_address=172.20.45.253
command=GET
real path=/
query=nil
request_version=1.1
request_uri=http://ad0b47976b7fe11e7a8870e55a29a6a9-1770422890.us-east-1.elb.amazonaws.com:8080/

SERVER VALUES:
server_version=nginx: 1.10.0 - lua: 10001

HEADERS RECEIVED:
accept=*/*
host=ad0b47976b7fe11e7a8870e55a29a6a9-1770422890.us-east-1.elb.amazonaws.com
user-agent=curl/7.51.0
BODY:
-no body in request-
```

Note the `client_address` value shown in the output. This is the IP address of the pod serving the request. Multiple invocations of this command will show different values for this attribute.

Now, the number of pods in the deployment can be scaled up and down. Or the pods may terminate and restart on a different host. But the service will still be able to target those pods because of the labels attached to the pod and used by the service.

## Delete a Service

Run the following command to delete the Service:

    $ kubectl delete -f templates/service.yaml

The backend Deployment needs to be explicitly deleted as well:

    $ kubectl delete -f templates/echo-deployment.yaml

## Daemon Set

Daemon Set ensure that a copy of the pod runs on a selected set of nodes. By default, all nodes in the cluster are selected. A selection critieria may be specified to select a limited number of nodes.

As new nodes are added to the cluster, pods are started on them. As nodes are removed, pods are removed through garbage collection.

## Create a DaemonSet

The folowing is an example DaemonSet that runs a Prometheus container. Let's begin with the template:

	apiVersion: extensions/v1beta1
	kind: DaemonSet
	metadata:
	  name: prometheus-daemonset
	spec:
	  template:
	    metadata:
	      labels:
	        tier: monitoring
	        name: prometheus-exporter
	    spec:
	      containers:
	      - name: prometheus
	        image: prom/node-exporter
	        ports:
	        - containerPort: 80

Run the following command to create the ReplicaSet and pods:

	$ kubectl create -f templates/daemonset.yaml --record

The `--record` flag will track changes made through each revision.

## Get basic details about the DaemonSet:

	$ kubectl get daemonsets/prometheus-daemonset
	NAME                   DESIRED   CURRENT   READY     UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
	prometheus-daemonset   5         5         5         5            5           <none>          7s

## Get more details about the DaemonSet:

```
$ kubectl describe daemonset/prometheus-daemonset
Name:           prometheus-daemonset
Selector:       name=prometheus-exporter,tier=monitoring
Node-Selector:  <none>
Labels:         name=prometheus-exporter
                tier=monitoring
Annotations:    kubernetes.io/change-cause=kubectl create --filename=templates/daemonset.yaml --record=true
Desired Number of Nodes Scheduled: 5
Current Number of Nodes Scheduled: 5
Number of Nodes Scheduled with Up-to-date Pods: 5
Number of Nodes Scheduled with Available Pods: 5
Number of Nodes Misscheduled: 0
Pods Status:  5 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  name=prometheus-exporter
           tier=monitoring
  Containers:
   prometheus:
    Image:        prom/node-exporter
    Port:         80/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age   From        Message
  ----    ------            ----  ----        -------
  Normal  SuccessfulCreate  28s   daemon-set  Created pod: prometheus-daemonset-pzfl8
  Normal  SuccessfulCreate  28s   daemon-set  Created pod: prometheus-daemonset-sjcgh
  Normal  SuccessfulCreate  28s   daemon-set  Created pod: prometheus-daemonset-ctrg4
  Normal  SuccessfulCreate  28s   daemon-set  Created pod: prometheus-daemonset-rxg79
  Normal  SuccessfulCreate  28s   daemon-set  Created pod: prometheus-daemonset-cnbkh
```

## Get pods in the DaemonSet:

```
$ kubectl get pods -lname=prometheus-exporter
NAME                         READY     STATUS    RESTARTS   AGE
prometheus-daemonset-cnbkh   1/1       Running   0          57s
prometheus-daemonset-ctrg4   1/1       Running   0          57s
prometheus-daemonset-pzfl8   1/1       Running   0          57s
prometheus-daemonset-rxg79   1/1       Running   0          57s
prometheus-daemonset-sjcgh   1/1       Running   0          57s
```

## Limit DaemonSets to specific nodes

Verify that the Prometheus pod was successfully deployed to the cluster nodes:

	kubectl get pods -o wide

The output should look as shown:

	$ kubectl get pods -o wide
	NAME                         READY     STATUS    RESTARTS   AGE       IP            NODE
	prometheus-daemonset-sjcgh   1/1       Running   0          1m        100.96.7.10   ip-172-20-52-200.ec2.internal
	prometheus-daemonset-cnbkh   1/1       Running   0          1m        100.96.3.10   ip-172-20-57-5.ec2.internal
	prometheus-daemonset-ctrg4   1/1       Running   0          1m        100.96.6.10   ip-172-20-64-152.ec2.internal
	prometheus-daemonset-pzfl8   1/1       Running   0          1m        100.96.5.10   ip-172-20-125-181.ec2.internal
	prometheus-daemonset-rxg79   1/1       Running   0          1m        100.96.4.9    ip-172-20-107-81.ec2.internal

Rename one of the node labels as follows:

	$ kubectl label node ip-172-20-52-200.ec2.internal app=prometheus-node
	node "ip-172-20-52-200.ec2.internal" labeled

Next, edit the DaemonSet template using the command shown:

	$ kubectl edit ds/prometheus-daemonset

Change the `spec.template.spec` to include a `nodeSelector` that matches the changed label:
```
      nodeSelector:
        app: prometheus-node
```

After the update is performed, we have now configured Prometheus to run on a specific node:

	$ kubectl get ds/prometheus-daemonset
	NAME                   DESIRED   CURRENT   READY     UP-TO-DATE   AVAILABLE   NODE SELECTOR         AGE
	prometheus-daemonset   1         1         1         0            1           app=prometheus-node   2m

## Delete a DaemonSet

Run the following command to delete the DaemonSet:

	$ kubectl delete -f templates/daemonset.yaml

## Job

A Job creates one or more pods and ensures that a specified number of them successfully complete. A job keeps track of successful completion of a pod. When the specified number of pods have successfully completed, the job itself is complete. The job will start a new pod if the pod fails or is deleted due to hardware failure. A successful completion of the specified number of pods means the job is complete.

This is different from a replica set or a deployment which ensures that a certain number of pods are always running. So if a pod in a replica set or deployment terminates, then it is restarted again. This makes replica set or deployment as long-running processes. This is well suited for a web server, such as NGINX. But a job is completed if the specified number of pods successfully completes. This is well suited for tasks that need to run only once. For example, a job may convert an image format from one to another. Restarting this pod in replication controller would not only cause redundant work but may be harmful in certain cases.

Jobs are complementary to Replica Set. A Replica Set manages pods which are not expected to terminate (e.g. web servers), and a Job manages pods that are expected to terminate (e.g. batch jobs).

Job is only appropriate for pods with `RestartPolicy` equal to `OnFailure` or `Never`.

## Non-parallel Job

Only one pod per job is started, unless the pod fails. Job is complete as soon as the pod terminates successfully.

Here is the job specification:

	apiVersion: batch/v1
	kind: Job
	metadata:
	  name: wait
	spec:
	  template:
	    metadata:
	      name: wait
	    spec:
	      containers:
	      - name: wait
	        image: ubuntu
	        command: ["sleep",  "20"]
	      restartPolicy: Never

It creates an Ubuntu container, sleeps for 20 seconds and that's it!

Create a job using the command:

	$ kubectl apply -f templates/job.yaml
	job "wait" created

Look at the job:

	$ kubectl get jobs
	NAME      DESIRED   SUCCESSFUL   AGE
	wait      1         0            0s

The output shows that the job is not successful yet. Watch the pod status to confirm:

	$ kubectl get -w pods
	NAME         READY     STATUS    RESTARTS   AGE
	wait-lk49x   1/1       Running   0          7s
	wait-lk49x   0/1       Completed   0         24s

To begin with, it shows that the pod for the job is running. The pod successfully exits after a few seconds and shows the `Completed` status.

Now, watch the job status again:

	$ kubectl get jobs
	NAME      DESIRED   SUCCESSFUL   AGE
	wait      1         1            1m

The output shows that the job was successfully executed.

The completed pod is not shown in the `kubectl get pods` command. Instead it can be shown by passing an additional option as shown below:

	$ kubectl get pods --show-all
	NAME         READY     STATUS      RESTARTS   AGE
	wait-lk49x   0/1       Completed   0          1m

## To delete the job, you can run this command

	$ kubectl delete -f templates/job.yaml

## Parallel Job

Non-parallel job runs only one pod per job. This API is used to run multiple pods in parallel for the job. The number of pods to complete is defined by `.spec.completions` attribute in the configuration file. The number of pods to run in parallel is defined by `.spec.parallelism` attribute in the configuration file. The default value for both of these attributes is 1.

The job is complete when there is one successful pod for each value in the range in 1 to `.spec.completions`. For that reason, it is also called as _fixed completion count_ job.

Here is a job specification:

	apiVersion: batch/v1
	kind: Job
	metadata:
	  name: wait
	spec:
	  completions: 6
	  parallelism: 2
	  template:
	    metadata:
	      name: wait
	    spec:
	      containers:
	      - name: wait
	        image: ubuntu
	        command: ["sleep",  "20"]
	      restartPolicy: Never

This job specification is similar to the non-parallel job specification. It has two new attributes added: `.spec.completions` and `.spec.parallelism`. This means the job will be complete when six pods have successfully completed. A maximum of two pods will run in parallel at a given time.

## Create a parallel job using the command:

	$ kubectl apply -f templates/job-parallel.yaml

## Watch the status of the job as shown:

	$ kubectl get -w jobs
	NAME      DESIRED   SUCCESSFUL   AGE
	wait      6         0            2s
	wait      6         1         22s
	wait      6         2         22s
	wait      6         3         43s
	wait      6         4         43s
	wait      6         5         1m
	wait      6         6         1m

The output shows that 2 pods are created about every 20 seconds.

In another terminal window, watch the status of pods created:

	$ kubectl get -w pods -l job-name=wait
	NAME         READY     STATUS    RESTARTS   AGE
	wait-f7kgb   1/1       Running   0          5s
	wait-smp4t   1/1       Running   0          5s
	wait-smp4t   0/1       Completed   0         22s
	wait-jbdp7   0/1       Pending   0         0s
	wait-jbdp7   0/1       Pending   0         0s
	wait-jbdp7   0/1       ContainerCreating   0         0s
	wait-f7kgb   0/1       Completed   0         22s
	wait-r5v8n   0/1       Pending   0         0s
	wait-r5v8n   0/1       Pending   0         0s
	wait-r5v8n   0/1       ContainerCreating   0         0s
	wait-r5v8n   1/1       Running   0         1s
	wait-jbdp7   1/1       Running   0         1s
	wait-r5v8n   0/1       Completed   0         21s
	wait-ngrgl   0/1       Pending   0         0s
	wait-ngrgl   0/1       Pending   0         0s
	wait-ngrgl   0/1       ContainerCreating   0         0s
	wait-jbdp7   0/1       Completed   0         21s
	wait-6l22s   0/1       Pending   0         0s
	wait-6l22s   0/1       Pending   0         0s
	wait-6l22s   0/1       ContainerCreating   0         0s
	wait-ngrgl   1/1       Running   0         1s
	wait-6l22s   1/1       Running   0         1s
	wait-ngrgl   0/1       Completed   0         21s
	wait-6l22s   0/1       Completed   0         21s

After all the pods have completed, `kubectl get pods` will not show the list of completed pods. The command to show the list of pods is shown below:

	$ kubectl get pods -a
	NAME         READY     STATUS      RESTARTS   AGE
	wait-6l22s   0/1       Completed   0          1m
	wait-f7kgb   0/1       Completed   0          2m
	wait-jbdp7   0/1       Completed   0          2m
	wait-ngrgl   0/1       Completed   0          1m
	wait-r5v8n   0/1       Completed   0          2m
	wait-smp4t   0/1       Completed   0          2m

Similarly, `kubectl get jobs` shows the status of the job after it has completed:

	$ kubectl get jobs
	NAME      DESIRED   SUCCESSFUL   AGE
	wait      6         6            3m

Deleting a job deletes all the pods as well. Delete the job as:

	$ kubectl delete -f templates/job-parallel.yaml

## Cron Job

## Pre-requisites

For Kubernetes cluster versions < 1.8, Cron Job can be created with API version `batch/v2alpha1`. You can check the cluster version using this command,

  $ kubectl version
  Client Version: version.Info{Major:"1", Minor:"8", GitVersion:"v1.8.1", GitCommit:"f38e43b221d08850172a9a4ea785a86a3ffa3b3a", GitTreeState:"clean", BuildDate:"2017-10-12T00:45:05Z", GoVersion:"go1.9.1", Compiler:"gc", Platform:"darwin/amd64"}
  Server Version: version.Info{Major:"1", Minor:"7", GitVersion:"v1.7.4", GitCommit:"793658f2d7ca7f064d2bdf606519f9fe1229c381", GitTreeState:"clean", BuildDate:"2017-08-17T08:30:51Z", GoVersion:"go1.8.3", Compiler:"gc", Platform:"linux/amd64"}

Notice that the server version is at v1.7.4. In this case, you need to explicitly enable API version `batch/v2alpha1` in Kubernetes cluster and perform a rolling-update. These steps are explained in link:../cluster-install#turn-on-an-api-version-for-your-cluster[Turn on an API version for your cluster].

NOTE: Once you switch API versions, you need to perform rolling-update of the cluster which generally takes 30 - 45 mins to complete for 3 master nodes and 5 worker nodes cluster.

If you have cluster version >= 1.8, `batch/v2alpha1` API is deprecated for this version but you can switch to `batch/v1beta1` to create Cron Jobs

## Create Cron Job

A Cron Job is a job that runs on a given schedule, written in Cron format. There are two primary use cases:

. Run jobs once at a specified point in time
. Repeatedly at a specified point in time

Here is the job specification:

	apiVersion: batch/v2alpha1
	kind: CronJob
	metadata:
	  name: hello
	spec:
	  schedule: "*/1 * * * *"
	  jobTemplate:
	    spec:
	      template:
	        spec:
	          containers:
	          - name: hello
	            image: busybox
	            args:
	            - /bin/sh
	            - -c
	            - date; echo Hello World!
	          restartPolicy: OnFailure

This job prints the current timestamp and the message "`Hello World`" every minute.

Create the Cron Job as shown in the command:

	$ kubectl create -f templates/cronjob.yaml --validate=false

`--validate=false` is required because kubectl CLI version is 1.8. Without this option, you'll get the error:

	error: error validating "templates/cronjob.yaml": error validating data: unknown object type schema.GroupVersionKind{Group:"batch", Version:"v2alpha1", Kind:"CronJob"}; if you choose to ignore these errors, turn validation off with --validate=false

Watch the status of the job as shown:

	$ kubectl get -w cronjobs
	NAME      SCHEDULE      SUSPEND   ACTIVE    LAST SCHEDULE   AGE
	hello     */1 * * * *   False     0         <none>
	hello     */1 * * * *   False     0         <none>
	hello     */1 * * * *   False     1         Tue, 24 Oct 2017 15:41:00 -0700
	hello     */1 * * * *   False     0         Tue, 24 Oct 2017 15:41:00 -0700
	hello     */1 * * * *   False     1         Tue, 24 Oct 2017 15:42:00 -0700
	hello     */1 * * * *   False     0         Tue, 24 Oct 2017 15:42:00 -0700

In another terminal window, watch the status of pods created:

	$ kubectl get -w pods -l app=hello-cronpod
	NAME                     READY     STATUS    RESTARTS   AGE
	hello-1508884860-cq004   0/1       Pending   0          0s
	hello-1508884860-cq004   0/1       Pending   0         0s
	hello-1508884860-cq004   0/1       ContainerCreating   0         0s
	hello-1508884860-cq004   0/1       Completed   0         1s
	hello-1508884920-wl5bx   0/1       Pending   0         0s
	hello-1508884920-wl5bx   0/1       Pending   0         0s
	hello-1508884920-wl5bx   0/1       ContainerCreating   0         0s
	hello-1508884920-wl5bx   0/1       Completed   0         2s
	hello-1508884980-45ktd   0/1       Pending   0         0s
	hello-1508884980-45ktd   0/1       Pending   0         0s
	hello-1508884980-45ktd   0/1       ContainerCreating   0         0s
	hello-1508884980-45ktd   0/1       Completed   0         2s

Get logs from one of the pods:

    $ kubectl logs hello-1508884860-cq004
	Tue Oct 24 22:41:02 UTC 2017
	Hello World!

## Delete Cron Job

Delete the Cron Job as shown in the following command:

	$ kubectl delete -f templates/cronjob.yaml
	cronjob "hello" deleted
