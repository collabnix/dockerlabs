# What is node affinity ?

- In simple words this  allows you to tell Kubernetes to schedule pods only to specific subsets of nodes.
- The initial node affinity mechanism in early versions of Kubernetes was the nodeSelector field in the pod specification. The node had to include all the labels specified in that field to be eligible to become the target for the pod.
- Node affinity is conceptually similar to nodeSelector – it allows you to constrain which nodes your pod is eligible to be scheduled on, based on labels on the node.
- There are currently two types of node affinity
1. requiredDuringSchedulingIgnoredDuringExecution  (Preferred during scheduling, ignored during execution; we are also known as "hard" requirements)
2. preferredDuringSchedulingIgnoredDuringExecution  (Required during scheduling, ignored during execution; we are also known as "soft" requirements)
```apiVersion: v1
kind: Pod
metadata:
  name: with-node-affinity
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: kubernetes.io/e2e-az-name
            operator: In
            values:
            - e2e-az1
            - e2e-az2
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 1
        preference:
          matchExpressions:
          - key: another-node-label-key
            operator: In
            values:
            - another-node-label-value
  containers:
  - name: with-node-affinity
    image: k8s.gcr.io/pause:2.0
   ```

- You can see, this set of rules requires a node to have the label “kubernetes.io/e2e-az-name” with a value indicating the availability zone as either “e2e-az1” or ”e2e-az2”. The rules also prefer a node that has the custom label “another-node-label-key” with the value of “another-node-label-value”, which means if a node exists that satisfies both constraints, it will be the most preferred candidate to run that pod.