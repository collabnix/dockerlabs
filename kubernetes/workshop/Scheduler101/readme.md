## What is Kubernetes Scheduling?

- The Kubernetes scheduler’s default behavior works well for most cases – for example, it ensures that pods are only placed on nodes that have sufficient free resources, it ties to spread pods from the same set (ReplicaSet, StatefulSet, etc.) across nodes, it tries to balance out the resource utilization of nodes, etc.

- But sometimes you want to control how your pods are scheduled. For example, perhaps you want to ensure that certain pods only schedule on nodes with specialized hardware, or you want to co-locate services that communicate frequently, or you want to dedicate a set of nodes to a particular set of users. Ultimately, you know much more about how your applications should be scheduled and deployed than Kubernetes ever will. So Kubernetes 1.6 offers four advanced scheduling features: node affinity/anti-affinity, taints and tolerations, pod affinity/anti-affinity, and custom schedulers. Each of these features are now in beta in Kubernetes 1.6.

## what is the scheduler for?

The Kubernetes scheduler is in charge of scheduling pods onto nodes. Basically it works like this:

   1. You create a pod
   2. The scheduler notices that the new pod you created doesn’t have a node assigned to it
   3. The scheduler assigns a node to the pod

It’s not responsible for actually running the pod – that’s the kubelet’s job. So it basically just needs to make sure every pod has a node assigned to it. Easy, right?

Kubernetes in general has this idea of a “controller”. A controller’s job is to:

  - look at the state of the system
  - notice ways in which the actual state does not match the desired state (like “this pod needs to be assigned a node”)
  - repeat

The scheduler is a kind of controller. There are lots of different controllers and they all have different jobs and operate independently.


## How Kubernetes Selects The Right node?
