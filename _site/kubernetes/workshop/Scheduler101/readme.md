## What is Kubernetes Scheduling?

- The Kubernetes Scheduler is a core component of Kubernetes: After a user or a controller creates a Pod, the Kubernetes Scheduler, monitoring the Object Store for unassigned Pods, will assign the Pod to a Node. Then, the Kubelet, monitoring the Object Store for assigned Pods, will execute the Pod.

## what is the scheduler for?

![](https://raw.githubusercontent.com/collabnix/dockerlabs/master/kubernetes/workshop/Scheduler101/schedulerhow.png)

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
