## What is Statefulset and how is it different from Deployment?

A Statefulset is a Kubernetes controller that is used to manage and maintain one or more Pods. However, so do other controllers like ReplicaSets and, the more robust, Deployments. So what does Kubernetes use StatefulSets for? To answer this question, we need to discuss stateless versus stateful applications.

A stateless application is one that does not care which network it is using, and it does not need permanent storage. Examples of stateless apps may include web servers (Apache, Nginx, or Tomcat).

On the other hand, we have stateful apps. Let’s say you have a Solr database cluster that is managed by several Zookeeper instances. For such an application to function correctly, each Solr instance must be aware of the Zookeeper instances that are controlling it. Similarly, the Zookeeper instances themselves establish connections between each other to elect a master node. Due to such a design, Solr clusters are an example of stateful applications. If you deploy Zookeeper on Kubernetes, you’ll need to ensure that pods can reach each other through a unique identity that does not change (hostnames, IPs...etc.). Other examples of stateful applications include MySQL clusters, Redis, Kafka, MongoDB, and others.

Given this difference, Deployment is more suited to work with stateless applications. As far as a Deployment is concerned, Pods are interchangeable. While a StatefulSet keeps a unique identity for each Pod it manages. It uses the same identity whenever it needs to reschedule those Pods.

## Exposing a StatefulSet

A Kubernetes Service acts as an abstraction layer. In a stateless application like an Nginx web server, the client does not (and should not) care which pod receives a response to the request. The connection reaches the Service, and it routes it to any backend pod. This is not the case in stateful apps. In the above diagram, a Solr pod may need to reach the Zookeeper master, not any pod. For this reason, part of the Statefulset definition entails a Headless Service. A Headless Service does not contain a ClusterIP. Instead, it creates several Endpoints that are used to produce DNS records. Each DNS record is bound to a pod. All of this is done internally by Kubernetes, but it’s good to have an idea about how it does it.

# Deploying a Stateful Application Using Kubernetes Statefulset

If you look at web_stateful.yaml file, you will find a snippet around how we are deploying a stateful application. For simplicity, are we using Nginx  as the pod image. The deployment is made up of 2 Nginx web servers; both of them are connected to a persistent volume. For example, look at web_stateful.yaml file under the current location.

Before we start discussing the details of this definition, notice that the file actually contains two definitions: the storage class that the StatefulSet is using and the StatefulSet itself.


## Storage Class

Storage classes are Kubernetes objects that let the users specify which type of storage they need from the cloud provider. Different storage classes represent various service quality, such as disk latency and throughput, and are selected depending on the scenario they are used for and the cloud provider’s support. Persistent Volumes and Persistent Volume Claims use Storage Classes.

## Persistent Volumes and Persistent Volume Claims

Persistent volumes act as an abstraction layer to save the user from going into the details of how storage is managed and provisioned by each cloud provider (in this example, we are using Google GCE). By definition, StatefulSets are the most frequent users of Persistent Volumes since they need permanent storage for their pods.

A Persistent Volume Claim is a request to use a Persistent Volume. If we are to use the Pods and Nodes analogy, then consider Persistent Volumes as the “nodes” and Persistent Volume Claims as the “pods” that use the node resources. The resources we are talking about here are storage properties, such as storage size, latency, throughput, etc.



## Creating The StatefulSet

Now that we have the definition file in place, we can use kubectl to apply it as follows:

```
kubectl apply -f web-stateful.yaml
```

Since the definition file contains a StorageClass and a StatefulSet resource, the following output is displayed:

```
storageclass.storage.k8s.io/www-disk created
statefulset.apps/webapp created
```

Our resources are available. Let’s see whether or not we have pods:

```
kubectl get pods
NAME   	READY   STATUS          	RESTARTS   AGE
webapp-0   0/1 	ContainerCreating   0      	8s
```

You may notice two things here: 
(1) there is only one pod created while we asked for three, and 
(2) the pod name contains the StatefulSet name.

This is the expected behavior. The StatefulSet will not create all the pods at once, like a Deployment, for example. It maintains order when starting and stopping the pods. Since StatefulSets maintain the pod identity, the pod name is the StatefulSet name followed by an incremental number.

Wait a few seconds and issue kubectl get pods again, you should see an output similar to the following:

```
NAME   	READY   STATUS          	RESTARTS   AGE
webapp-0   1/1 	Running         	0      	43s
webapp-1   0/1 	ContainerCreating   0      	11s
```

Later on, the output becomes:

```
NAME   	READY   STATUS	RESTARTS   AGE
webapp-0   1/1 	Running   0      	112m
webapp-1   1/1 	Running   0      	111m
webapp-2   1/1 	Running   0      	111m
```

All our pods are now started.

## Creating a Headless Service For Our StatefulSet

Right now, the pods are running. But how can a web server access another one? This is done through the Service, so we need to create one. Open a new YAML file called apache_statefulset_service.yaml and add the following to it:

## Create the service by using kubectl:

```
kubectl apply -f Web_statefulset_service.yamlservice/web-access-svc created
```

## Listing The Created Components

Let’s have a look at the created components:

 ```
 $ kubectl get statefulset
NAME 	READY   AGE
webapp   3/3 	21h
```

```
$ kubectl get pv
NAME                                   	CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM              	STORAGECLASS   REASON   AGE
pvc-077a1891-a25b-11e9-9ecf-42010a800184   1Gi    	RWO        	Delete       	Bound	default/www-webapp-2   www-disk            	21h
pvc-e79d8843-a25a-11e9-9ecf-42010a800184   1Gi    	RWO        	Delete       	Bound	default/www-webapp-0   www-disk            	21h
pvc-fa398e2a-a25a-11e9-9ecf-42010a800184   1Gi    	RWO        	Delete       	Bound	default/www-webapp-1   www-disk            	21h
```

We have the Persistent Volumes

```
$ kubectl get pvc
NAME       	STATUS   VOLUME                                 	CAPACITY   ACCESS MODES   STORAGECLASS   AGE
www-webapp-0   Bound	pvc-e79d8843-a25a-11e9-9ecf-42010a800184   1Gi    	RWO        	www-disk   	21h
www-webapp-1   Bound	pvc-fa398e2a-a25a-11e9-9ecf-42010a800184   1Gi    	RWO        	www-disk   	21h
www-webapp-2   Bound	pvc-077a1891-a25b-11e9-9ecf-42010a800184   1Gi    	RWO        	www-disk   	21h
```

And the Persistent Volume Claims. Let’s see how we can connect and use our pods.

# Connecting One Pod To Another Through The Headless Service

We need to test our setup. Let’s open a bash shell to one of the pods:

```
kubectl exec -it webapp-0 bash
```
The httpd image isn’t shipped with curl by default, so we need to install it:


```
apt update && apt install curl
```
Once it is installed, we can try connecting to the Service:

```
root@webapp-0:/usr/local/apache2# curl web-svc<html><body><h1>It works!</h1></body></html>>
```

This is the default page that Apache displays. The Service is routing the request to the backend pods.

The StatefulSet is all about uniquely identifying pods. So, let’s try connecting to a specific pod:

```
root@webapp-0:/usr/local/apache2# curl webapp-1.web-svc<html><body><h1>It works!</h1></body></html>
```

By prefixing the service name to the pod name, you can connect to that specific pod.


# Deleting The StatefulSet

We start by deleting the Headless Service:

```
kubectl delete -f apache_stateful_service.yamlservice "web-svc" deleted
```
We could equally achieve the same result by running kubectl delete service web-svc

To delete the StatefulSet with the Persistent Volume and the Persistent Volume Claims, we use the definition file:

```
kubectl delete -f apache_stateful.yaml storageclass.storage.k8s.io "www-disk" deletedstatefulset.apps "webapp" deleted
```

The controller honors the ten seconds grace time and gives the pods time to clean up. In our example, Apache should not take more than a few milliseconds to shut down. But, if it were serving thousands of requests, it would take more time to terminate.
