# What is Kubernetes?

Kubernetes (commonly referred to as K8s) is an orchestration engine for container technologies such as Docker and rkt that is taking over the DevOps scene in the last couple of years. It is already available on Azure and Google Cloud as a managed service.

Kubernetes can speed up the development process by making easy, automated deployments, updates (rolling-update) and by managing our apps and services with almost zero downtime. It also provides self-healing. Kubernetes can detect and restart services when a process crashes inside the container. Kubernetes is originally developed by Google, it is open-sourced since its launch and managed by a large community of contributors.

Any developer can package up applications and deploy them on Kubernetes with basic Docker knowledge.

# What is K8s made up of?

## Kubectl:

- A CLI tool for Kubernetes

![alt text](https://raw.githubusercontent.com/ajeetraina/kubernetes101/master/architecture/kubernetes-kubectl.png)



## Master Node:

![alt text](https://raw.githubusercontent.com/ajeetraina/kubernetes101/master/architecture/kubernetes-kubelet.png)

- The main machine that controls the nodes
- Main entrypoint for all administrative tasks
- It handles the orchestration of the worker nodes

## Worker Node

![alt text](https://raw.githubusercontent.com/ajeetraina/kubernetes101/master/architecture/kubernetes-worker-node.png)

- It is a worker machine in Kubernetes (used to be known as minion)
- This machine performs the requested tasks. Each Node is controlled by the Master Node
- Runs containers inside pods
- This is where the Docker engine runs and takes care of downloading images and starting containers

## Kubelet

![alt text](https://raw.githubusercontent.com/ajeetraina/kubernetes101/master/architecture/kubernetes-kubelet.png)

- Primary node agent
- Ensures that containers are running and healthy

## Kubernetes Pod:

- A Pod can host multiple containers and storage volumes
- Pods are instances of Deployments (see Deployment)
- One Deployment can have multiple pods
- With Horizontal Pod Autoscaling, Pods of a Deployment can be automatically started and halted based on CPU usage
- Containers within the same pod have access to shared volumes
- Each Pod has its unique IP Address within the cluster
- Pods are up and running until someone (or a controller) destroys them
- Any data saved inside the Pod will disappear without a persistent storage

![alt text](https://raw.githubusercontent.com/ajeetraina/kubernetes101/master/architecture/kubernetes-pod-new.png)


## Deployment:

- A deployment is a blueprint for the Pods to be create (see Pod)
- Handles update of its respective Pods.
- A deployment will create a Pod by it’s spec from the template.
- Their target is to keep the Pods running and update them (with rolling-update) in a more controlled way.
- Pod(s) resource usage can be specified in the deployment.
- Deployment can scale up replicas of Pods.
- kubernetes-deployment

![alt text](https://raw.githubusercontent.com/ajeetraina/kubernetes101/master/architecture/kubernetes-deployment%20(1).png)

![alt text](https://raw.githubusercontent.com/ajeetraina/kubernetes101/master/architecture/kubernetes-deployment%20(1).png)

## Secret:

- A Secret is an object, where we can store sensitive informations like usernames and passwords.
- In the secret files, values are base64 encoded.
- To use a secret, we need to refer to the secret in our Pod.
- Or we can put it inside a volume and mount that to the container.
- Secrets are not encrypted by default. For encryption we need to create an EncryptionConfig.
- You can read more about encryption here

## Service:

- A service is responsible for making our Pods discoverable inside the network or exposing them to the internet
- A Service identifies Pods by its LabelSelector
- There are 3 types of services:

## ClusterIP:
- The deployment is only visible inside the cluster
- The deployment gets an internal ClusterIP assigned to it
- Traffic is load balanced between the Pods of the deployment

## Node Port:
- The deployment is visible inside the cluster
- The deployment is bound to a port of the Master Node
- Each Node will proxy that port to your Service
- The service is available at http(s)://:/
- Traffic is load balanced between the Pods of the deployment

## Load Balancer:
- The deployment gets a Public IP address assigned
- The service is available at http(s)://:<80||42>/
- Traffic is load balanced between the Pods of the deployment

## Credits:
- https://blog.risingstack.com/what-is-kubernetes-how-to-get-started/

[Next: Preparing 5-Node Kubernetes Cluster](http://dockerlabs.collabnix.com/kubernetes/workshop/kube101.html)
