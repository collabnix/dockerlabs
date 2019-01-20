
# Compose on Kubernetes for Play with Kubernetes(PWK)

Why Compose on Kubernetes? 

The Kubernetes API is really quite large. There are more than 50 first-class objects in the latest release, from Pods and Deployments to ValidatingWebhookConfiguration and ResourceQuota. This can lead to a verbosity in configuration, which then needs to be managed by you, the developer. 

The Kubernetes API is amazingly general purpose — it exposes low-level primitives for building the full range of distributed systems. Compose, meanwhile, isn't an API, but a high-level tool focused on developer productivity. That's why combining them together makes sense. For the common case of a set of interconnected web services, Compose provides an abstraction that simplifies Kubernetes configuration. For everything else, you can still drop down to the raw Kubernetes API primitives.

Now you can use Swarm CLI to manage Kubernetes Cluster in lot easier way. 

First, we need to install the Compose on Kubernetes controller into your Kubernetes cluster. This controller uses the standard Kubernetes extension points to introduce the "Stack" to the Kubernetes API. You can use any Kubernetes cluster you like, but if you don't already have one available then remember that Docker Desktop comes with Kubernetes and the Compose controller built-in, and enabling it is as simple as ticking a box in the settings.

Kops, short for Kubernetes Operations, is a set of tools for installing, operating, and deleting Kubernetes clusters in the cloud. A rolling upgrade of an older version of Kubernetes to a new version can also be performed. It also manages the cluster add-ons. After the cluster is created, the usual kubectl CLI can be used to manage resources in the cluster.

## Pre-requisite

- Go to https://labs.play-with-k8s.com
- Clone the Repository



![My Image](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/Intermediate/dockerdesktop1.png)





## Verifying Docker Desktop
