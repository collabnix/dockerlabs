# Kubernetes Workshop for Beginners

## Pre-requisite:

- [Understanding Kubernetes Architecture]() - Pending
- [Preparing 5-Node Kubernetes Cluster]() - Pending

## Pods101

 - [Introductory Slides]() - Pending
 - [Deploying Your First Nginx Pod](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/workshop/pods101/deploy-your-first-nginx-pod.md) - In-Progress
 - [Viewing Your Pod](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/workshop/pods101/deploy-your-first-nginx-pod.md#viewing-your-pods) 
 - [Where is your Pod running on?](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/workshop/pods101/deploy-your-first-nginx-pod.md#which-node-is-this-pod-running-on)
 - [Pod Output in JSON]()
 - [Executing Commands against Pod](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/workshop/pods101/deploy-your-first-nginx-pod.md#executing-commands-against-pods)
 - [Terminating a Pod](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/workshop/pods101/deploy-your-first-nginx-pod.md#deleting-the-pod)
 - [Adding a 2nd container to a Pod]()
 - [Troublehsooting Pod]()
 - [Pods Networking at a Glance]()

## ReplicaSet101

 - [Introductory Slides]()
 - [Creating Your First ReplicaSet - 4 Pods serving Nginx]()
 - [Removing a Pod from ReplicaSet]()
 - [Scaling & Autoscaling a ReplicaSet]()
 - [Best Practices]()
 - [Deleting ReplicaSets]()
 
 ## Deployment101
 
 - [Introductory Slides]()
 - [Performing Updates with Zero Downtime (Deployment Rolling Updates)]()
 - [Kubernetes Deployments Strategies Overview]()
    - [Rolling Updates]()
    - [Recreate Updates]()
 -  [Updating a Deployment while another is in progress (Rollover Updates)]()
 - [Undoing a deployment (aka Rolling Back)]()
 - [Scaling and Autoscaling Deployments]()

## Scheduler101

 - [Introductory Slides]()
 - [How Kubernetes Selects the Right node?]()
 - [Node Affinity]()
 - [Anti-Node Affinity]()
 - [Nodes taints and tolerations]()
 
 ## StatefulSets101
 
 - [The difference between a Statefulset and a Deployment]()
 - [Deploying a Stateful Application Using Kubernetes Statefulset?]()
 - [Storage Class]()
 - [Demonstrating Persistent Volumes and Persistent Volume Claims]()
 - [Provisioning The StatefulSet]()
 - [Creating the StatefulSet]()
 - [Creating a Headless Service for our StatefulSet]()
 - [Listing the created components]()
 - [Connecting one pod to another through the Headless Service]()
 - [Deleting the StatefulSet]()
