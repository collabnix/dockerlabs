# Introduction to Kubernetes Namespace

Namespaces are intended for use in environments with many users spread across multiple teams, or projects. For clusters with a few to tens of users, you should not need to create or think about namespaces at all. Start using namespaces when you need the features they provide.

Namespaces provide a scope for names. Names of resources need to be unique within a namespace, but not across namespaces.
Namespaces are a way to divide cluster resources between multiple users (via resource quota).
In future versions of Kubernetes, objects in the same namespace will have the same access control policies by default.
It is not necessary to use multiple namespaces just to separate slightly different resources, such as different versions of the same software: use labels to distinguish resources within the same namespace.

Kubernetes supports multiple virtual clusters backed by the same physical cluster. These virtual clusters are called namespaces.


## Displaying the default Namespace

```
$ kubectl get namespaces
NAME          STATUS    AGE
default       Active    1d
kube-system   Active    1d
kube-public   Active    1d
```
Kubernetes starts with three initial namespaces:

default - The default namespace for objects with no other namespace

kube-system - The namespace for objects created by the Kubernetes system

kube-public -  The namespace is created automatically and readable by all users (including those not authenticated). This namespace is mostly reserved for cluster usage, in case that some resources should be visible and readable publicly throughout the whole cluster. The public aspect of this namespace is only a convention, not a requirement.

## Creating User-defined Namespace


```
Ajeets-MacBook-Air:testenviron ajeetraina$ cat collabnix-namespace.yml 
apiVersion: v1
kind: Namespace
metadata:
  name: collabnix
```

```
kubectl create -f ./collabnix-namespace.yml
```

## Displaying the Namespace

```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl get namespace
NAME          STATUS    AGE
collabnix     Active    29m
```

## How to build Namespace with CPU Limit

```
Ajeets-MacBook-Air:testenviron ajeetraina$ cat cpu-collabnix.yml 
apiVersion: v1
kind: LimitRange
metadata:
  name: cpu-limit-range
spec:
  limits:
  - default:
      cpu: 1
    defaultRequest:
      cpu: 0.5
    type: Container

```

```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl create -f ./cpu-collabnix.yml --namespace=collabnix
limitrange "cpu-limit-range" created
```
## Creating Pod

```
Ajeets-MacBook-Air:testenviron ajeetraina$ cat cpu-collabnix-pods.yml 
apiVersion: v1
kind: Pod
metadata:
  name: default-cpu-demo
spec:
  containers:
  - name: default-cpu-demo-ctr
    image: nginx
```

## Creating Namespace with CPU Limit

```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl create -f ./cpu-collabnix-pods.yml --namespace=collabnix
pod "default-cpu-demo" created
```

## Displaying 




```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl get pods
No resources found.
```

```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl get pod default-cpu-demo --output=yaml --namespace=collabnix
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubernetes.io/limit-ranger: 'LimitRanger plugin set: cpu request for container
      default-cpu-demo-ctr; cpu limit for container default-cpu-demo-ctr'
  creationTimestamp: 2018-01-21T08:10:57Z
  name: default-cpu-demo
  namespace: collabnix
  resourceVersion: "114257"
  selfLink: /api/v1/namespaces/collabnix/pods/default-cpu-demo
  uid: 9bd3b4dd-fe82-11e7-b096-025000000001
spec:
  containers:
  - image: nginx
    imagePullPolicy: Always
    name: default-cpu-demo-ctr
    resources:
      limits:
        cpu: "1"
      requests:
        cpu: 500m
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-d7jm4
      readOnly: true
  dnsPolicy: ClusterFirst
  nodeName: docker-for-desktop
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.alpha.kubernetes.io/notReady
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.alpha.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: default-token-d7jm4
    secret:
      defaultMode: 420
      secretName: default-token-d7jm4
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: 2018-01-21T08:10:57Z
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: 2018-01-21T08:11:06Z
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: 2018-01-21T08:10:57Z
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: docker://3616ef9fd9244651974b6968718646fcc0370860858bdd46b2d49d65d00e29c9
    image: nginx:latest
    imageID: docker-pullable://nginx@sha256:285b49d42c703fdf257d1e2422765c4ba9d3e37768d6ea83d7fe2043dad6e63d
    lastState: {}
    name: default-cpu-demo-ctr
    ready: true
    restartCount: 0
    state:
      running:
        startedAt: 2018-01-21T08:11:05Z
  hostIP: 192.168.65.3
  phase: Running
  podIP: 10.1.0.163
  qosClass: Burstable
  startTime: 2018-01-21T08:10:57Z
  
  ```



## Displaying Pods

```

Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl get pod default-cpu-demo --output=yaml --namespace=collabnix
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubernetes.io/limit-ranger: 'LimitRanger plugin set: cpu request for container
      default-cpu-demo-ctr; cpu limit for container default-cpu-demo-ctr'
  creationTimestamp: 2018-01-21T08:10:57Z
  name: default-cpu-demo
  namespace: collabnix
  resourceVersion: "114257"
  selfLink: /api/v1/namespaces/collabnix/pods/default-cpu-demo
  uid: 9bd3b4dd-fe82-11e7-b096-025000000001
spec:
  containers:
  - image: nginx
    imagePullPolicy: Always
    name: default-cpu-demo-ctr
    resources:
      limits:
        cpu: "1"
      requests:
        cpu: 500m
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-d7jm4
      readOnly: true
  dnsPolicy: ClusterFirst
  nodeName: docker-for-desktop
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.alpha.kubernetes.io/notReady
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.alpha.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: default-token-d7jm4
    secret:
      defaultMode: 420
      secretName: default-token-d7jm4
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: 2018-01-21T08:10:57Z
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: 2018-01-21T08:11:06Z
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: 2018-01-21T08:10:57Z
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: docker://3616ef9fd9244651974b6968718646fcc0370860858bdd46b2d49d65d00e29c9
    image: nginx:latest
    imageID: docker-pullable://nginx@sha256:285b49d42c703fdf257d1e2422765c4ba9d3e37768d6ea83d7fe2043dad6e63d
    lastState: {}
    name: default-cpu-demo-ctr
    ready: true
    restartCount: 0
    state:
      running:
        startedAt: 2018-01-21T08:11:05Z
  hostIP: 192.168.65.3
  phase: Running
  podIP: 10.1.0.163
  qosClass: Burstable
  startTime: 2018-01-21T08:10:57Z
 
 ```

# Describing the Namespace


```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl describe namespace collabnix
Name:         collabnix
Labels:       <none>
Annotations:  <none>
Status:       Active

No resource quota.

Resource Limits
 Type       Resource  Min  Max  Default Request  Default Limit  Max Limit/Request Ratio
 ----       --------  ---  ---  ---------------  -------------  -----------------------
 Container  cpu       -    -    500m             1              -
Ajeets-MacBook-Air:testenviron ajeetraina$ 
```
