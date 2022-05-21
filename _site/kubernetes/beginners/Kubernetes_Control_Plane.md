# Kubernetes Control Plane
The Kubernetes Control Plane works to make the cluster’s current state match your desired state. To do so, Kubernetes performs a variety of tasks automatically — for instance, starting or restarting containers, scaling the number of replicas of a given application, and much more.

As defined in the Kubernetes Documentation:

The various parts of the Kubernetes Control Plane, such as the Kubernetes Master and kubelet processes, govern how Kubernetes communicates with your cluster. The Control Plane maintains a record of all of the Kubernetes Objects in the system, and runs continuous control loops to manage the object’s state. At any given time, the Control Plane’s control loops will respond to changes in the cluster and work to make the actual state of all the objects in the system match the desired state that you defined.
The Kubernetes Control Plane performs the task of maintaining the desired state across the cluster. It records the object state and continuously runs a control loop to check if the current state of the object matches the desired state. You can think of it as the Government running the state.

# Kubernetes Master
As a part of the Kubernetes Control Plane, the Kubernetes master works towards continuously maintaining the desired state throughout your cluster. The kubectl command is an interface to communicate with the cluster’s Kubernetes master through the Kubernetes API. Think of it as the police force responsible for maintaining law and order.

As defined in the Kubernetes Documentation:

The “master” refers to a collection of processes managing the cluster state. Typically these processes are all run on a single node in the cluster, and this node is also referred to as the master. The master can also be replicated for availability and redundancy.
The Kubernetes Master controls and coordinates all the nodes in the cluster with the help of three processes that run on one or more master nodes in the cluster. Each Kubernetes master in your cluster runs these three processes:

kube-apiserver: the single point of management for the entire cluster. The API server implements a RESTful interface for communication with tools and libraries. The kubectl command directly interacts with the API server.
kube-controller-manager: regulates the state of the cluster by managing the different kinds of controllers.
kube-scheduler: schedules the workloads across the available nodes in the cluster.
