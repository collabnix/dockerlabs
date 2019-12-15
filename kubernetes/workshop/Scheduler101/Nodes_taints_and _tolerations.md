# What is Node taints and tolerations ?

- This Kubernetes feature allows users to mark a node (taint the node) so that no pods can be scheduled to it, unless a pod explicitly tolerates the taint.
- When you taint a node, it is automatically excluded from pod scheduling. When the schedule runs the predicate tests on a tainted node, they’ll fail unless the pod has toleration for that node. 

# Taints – The Theory
- one node in the cluster is reserved for special purposes because it has specialized hardware like a GPU. 
- one node in the cluster isn’t licensed for some software running on it
- one node is in a different network zone for compliance reasons.
- Like last monitoring example: Let assume  new member joins the development team, writes a Deployment for her application, but forgets to exclude the monitoring nodes from the target nodes? Kubernetes administrators need a way to repel pods from nodes without having to modify every pod definition. 

```
kubectl taint nodes mon01 role=monitoring:NoSchedule
```
# Tolerations 
- How about use case where we had really slow spinning disks in a node. We applied a taint to that node so that our normal pods won’t be placed on that piece of hardware, due to it’s poor performance, but we have some pods that don’t need fast disks. This is where Tolerations could come into play.

- A toleration is a way of ignoring a taint during scheduling. Tolerations aren’t applied to nodes, but rather the pods. So, in the example above, if we apply a toleration to the PodSpec, we could “tolerate” the slow disks on that node and still use it.

```
apiVersion: apps/v1
kind: Deployment 
metadata: 
  name: nginx-deployment
  labels:
    app: nginx
spec:
  strategy:
    type: RollingUpdate
    rollingUpdate:
    number at a time
      maxUnavailable: 1
    matchLabels:
      app: nginx 
  deployed
    metadata:
        app: nginx
    spec:
      tolerations:
      - key: "hardware"
        operator: "Equal"
        value: "slow"
        effect: "NoSchedule"
      containers:
      - name: nginx-container #the name of the container within the pod
        image: nginx:1.7.9
        ports:
        - containerPort: 80 
```
- An important thing to notice, though, is that tolerations may enable a tainted node to accept a pod but it does not guarantee that this pod runs on that specific node.
- In other words, the tainted node  will be considered as one of the candidates for running our pod. However, if another node has a higher priority score, it will be chosen instead. For situations like this, you need to combine the toleration with nodeSelector or node affinity parameters.
    