# Introduction to Namespace


# Displaying Namespace


# Creating Namespace


```
Ajeets-MacBook-Air:testenviron ajeetraina$ cat collabnix-namespace.yml 
apiVersion: v1
kind: Namespace
metadata:
  name: collabnix
```
Ajeets-MacBook-Air:testenviron ajeetraina$ vi cpu-collabnix.yml
```

```

# How to build Pods

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

Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl create -f ./cpu-collabnix.yml --namespace=collabnix
limitrange "cpu-limit-range" created
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
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl create -f ./cpu-defaults-pod.yaml --namespace=collabnix
Ajeets-MacBook-Air:testenviron ajeetraina$ ls
collabnix-namespace.yml	cpu-collabnix.yml	docker-compose.yml
Ajeets-MacBook-Air:testenviron ajeetraina$ vi cpu-collabnix-pods.yml
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl create -f ./cpu-collabnix-pods.yml --namespace=collabnix
pod "default-cpu-demo" created
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl get pods
No resources found.
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl get pods
No resources found.
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

# Creating Namespace with CPU Limits


# Displaying Pods

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


# Displaying the Namespace



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
