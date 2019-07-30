# What is kubectl?


Before learning how to use kubectl more efficiently, you should have a basic understanding of what it is and how it works.

From a user's point of view, kubectl is your cockpit to control Kubernetes. It allows you to perform every possible Kubernetes operation.

From a technical point of view, kubectl is a client for the Kubernetes API.

The Kubernetes API is an HTTP REST API. This API is the real Kubernetes user interface. Kubernetes is fully controlled through this API. This means that every Kubernetes operation is exposed as an API endpoint and can be executed by an HTTP request to this endpoint.

Consequently, the main job of kubectl is to carry out HTTP requests to the Kubernetes API:



<img src= "https://raw.githubusercontent.com/sangam14/kubernets101/master/pic.svg?sanitize=true">

Kubernetes is a fully resource-centred system. That means, Kubernetes maintains an internal state of resources, and all Kubernetes operations are CRUD operations on these resources. You fully control Kubernetes by manipulating these resources (and Kubernetes figures out what to do based on the current state of resources). For this reason, the Kubernetes API reference is organised as a list of resource types with their associated operations.

Let's consider an example.

Imagine you want to create a [ReplicaSet](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#replicaset-v1-apps) resource. To do so, you would define the ReplicaSet in a file named replicaset.yaml file, and then run the following command:

```
$ kubectl create -f replicaset.yaml

```
Obviously, this creates your ReplicaSet in Kubernetes. But what happens behind the scenes?

Kubernetes has a create ReplicaSet operation, and like all Kubernetes operations, it is exposed as an API endpoint. The specific API endpoint for this operation is as follows:

```
POST /apis/apps/v1/namespaces/{namespace}/replicasets

```

You can find the API endpoints of all Kubernetes operations in the API reference (including the above endpoint). To make an actual request to an endpoint, you need to prepend the URL of the API server to the endpoint paths that are listed in the API reference.

Consequently, when you execute the above command, kubectl makes an HTTP POST request to the above API endpoint. The ReplicaSet definition (that you provided in the replicaset.yaml file) is passed in the body of the request.

This is how kubectl works for all commands that interact with the Kubernetes cluster. In all these cases, kubectl simply makes HTTP requests to the appropriate Kubernetes API endpoints.

Note that it's totally possible to control Kubernetes with a tool like curl by manually issuing HTTP requests to the Kubernetes API. Kubectl just makes it easier for you to use the Kubernetes API.

These are the basics of what kubectl is and how it works. But there is much more about the Kubernetes API that every kubectl user should know. To this end, let's briefly dive into the Kubernetes internals.

## Kubernetes internals

Kubernetes consists of a set of independent components that run as separate processes on the nodes of a cluster. Some components run on the master nodes and others run on the worker nodes, and each component has a very specific function.

These are the most important components on the master nodes:

### Storage backend: stores resource definitions (usually etcd is used)
API server: provides Kubernetes API and manages storage backend
Controller manager: ensures resource statuses match specifications
Scheduler: schedules Pods to worker nodes
And this is the most important component on the worker nodes:

### Kubelet: manages execution of containers on a worker node
To see how these components work together, let's consider an example.

Assume, you just executed kubectl create -f replicaset.yaml, upon which kubectl made an HTTP POST request to the create ReplicaSet API endpoint (passing along your ReplicaSet resource definition).

What effects causes this in the cluster? Watch it below:


<img src="https://raw.githubusercontent.com/sangam14/kubernets101/master/pic1.svg?sanitize=true">


Following ```kubectl create -f replicaset.yaml```, the API server saves your ReplicaSet resource definition in the storage backend.

<img src="https://raw.githubusercontent.com/sangam14/kubernets101/master/pic2.svg?sanitize=true">

This triggers the ReplicaSet controller in the controller manager, who watches for creations, updates, and deletions of ReplicaSet resources.



<img src="https://raw.githubusercontent.com/sangam14/kubernets101/master/pic3.svg?sanitize=true">

The ReplicaSet controller creates a Pod definition for each replica of the ReplicaSet (according to the Pod template in the ReplicaSet definition) and saves them in the storage backend.


<img src="https://raw.githubusercontent.com/sangam14/kubernets101/master/pic4.svg?sanitize=true">

This triggers the scheduler who watches for Pods that have not yet been assigned to a worker node.

<img src="https://raw.githubusercontent.com/sangam14/kubernets101/master/pic5.svg?sanitize=true">

The scheduler chooses a suitable worker node for each Pod and adds this information to the Pod definitions in the storage backend.

<img src="https://raw.githubusercontent.com/sangam14/kubernets101/master/pic6.svg?sanitize=true">

This triggers the kubelet on the worker node that the Pods have been scheduled to, who watches for Pods that have been scheduled to its worker node.
<img src="https://raw.githubusercontent.com/sangam14/kubernets101/master/pic7.svg?sanitize=true">
The kubelet reads the Pod definitions from the storage backend and instructs the container runtime (Docker, for example) to run the containers on the worker node.


And here follows the textual description.

The API request to the create ReplicaSet endpoint is handled by the API server. The API server authenticates the request and saves your ReplicaSet resource definition in the storage backend.

This event triggers the ReplicaSet controller, which is a sub-process of the controller manager. The ReplicaSet controller watches for creations, updates, and deletions of ReplicaSet resources in the storage backend, and gets notified by an event when this happens.

The job of the ReplicaSet controller is to make sure that the required number of replica Pods of a ReplicaSet exists. In our example, no Pods exist yet, so the ReplicaSet controller creates these Pod definitions (according to the Pod template in the ReplicaSet definition) and saves them in the storage backend.

The creation of the new Pods triggers the scheduler, who watches for Pod definitions that are not yet scheduled to a worker node. The scheduler chooses a suitable worker node for each Pod and updates the Pod definitions in the storage backend with this information.

Note that up to this point, no workload code is being run anywhere in the cluster. All that has been done so far is creating and updating resources in the storage backend on the master node.

This event triggers the kubelets who watch for Pods that are scheduled to their worker nodes. The kubelet of the worker node your ReplicaSet Pods have been scheduled to instructs the configured container runtime (which may be Docker) to download the required container images and run the containers.

At this point, finally, your ReplicaSet application is running!

The role of the Kubernetes API

As you can see from the above example, Kubernetes components (except the API server and the storage backend) work by watching for resource changes in the storage backend and manipulating resources in the storage backend.

However, these components do not access the storage backend directly, but only through the Kubernetes API.

Consider the following examples:

The ReplicaSet controller uses the list ReplicaSets API endpoint API operation with a watch parameter for watching for changes to ReplicaSet resources.
The ReplicaSet controller uses the create Pod API endpoint for creating Pods.
The scheduler uses the patch Pod API endpoint for updating Pods with the information about the selected worker node.
As you can see, this is the same API that is also used by kubectl.

This double usage of the Kubernetes API for internal components as well as for external users is a fundamental design concept of Kubernetes.

With this knowledge, you can summarise how Kubernetes works as follows:

The storage backend stores the state (i.e. resources) of Kubernetes.
The API server provides an interface to the storage backend in the form of the Kubernetes API.
All other Kubernetes components and users read, watch, and manipulate the state (i.e. resources) of Kubernetes through the Kubernetes API.
Being familiar with these concepts will help you a lot to understand kubectl better and make the most use of it!

Let's now look at a series of concrete tips and tricks to help you boost your kubectl productivity.



# 1. Save typing with command completion

One of the most useful, but often overlooked, tricks to boost your kubectl productivity is command completion.

Command completion allows you to auto-complete individual parts of kubectl commands with the Tab key. This works for sub-commands, options, and arguments, including hard-to-type things like resource names.

Here you can see kubectl command completion in action:

<img src="https://raw.githubusercontent.com/sangam14/kubernets101/master/pic8.gif">


Command completion is available for the Bash and Zsh shells.

The [official documentation](https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion)contains detailed instructions for setting up command completion, but the following sections provide a recap for you.

## How command completion works

In general, command completion is a shell feature that works by the means of a completion script. A completion script is a shell script that defines the completion behaviour for a specific command. Sourcing a completion script enables completion for the corresponding command.

Kubectl can automatically generate and print out the completion scripts for Bash and Zsh with the following commands:

```
kubectl completion bash
# or
kubectl completion zsh
```



# Contributor -

Sangam biradar - smbiradar14@gmail.com - engineITops.icu




