# Intermediate Track


   - Scaling your containers
     - Getting ready
     - Scale up and down manually with the kubectl scale command
     - Horizontal Pod Autoscaler (HPA)
   - Updating live containers
     - Deployment update strategy – rolling-update
     - Rollback the update
     - Deployment update strategy – recreate

   - Forwarding container ports
     - Container-to-container communication
     - Pod-to-Pod communication
       - Working with NetworkPolicy
     - Pod-to-Service communication
     - External-to-internal communication
       - Working with Ingress
       
   - Ensuring flexible usage of your containers
     - Pod as DaemonSets
	- Running a stateful Pod
	- Pod recovery by DaemonSets
	- Pod recovery by StatefulSet

   - Submitting Jobs on Kubernetes
     - Pod as a single Job
     - Create a repeatable Job
     - Create a parallel Job
     - Schedule to run Job using CronJob

   - Working with configuration files
     - YAML
     - JSON
     - Pod
     - Deployment
     - Service


## Building High-Availability Clusters

   - Introduction
   - High-availability concepts
     - Redundancy
     - Hot swapping
     - Leader election
     - Smart load balancing
     - Self-healing
   
  - Clustering etcd
    - Static mechanism
    - Discovery  mechanism
    - kubeadm
    - kubespray
    - kops
   
  - Building multiple masters
    - Setting up the first master
    - Setting up the other master with existing certifications
    - Adding nodes in a HA cluster
  
  - High-availability best practices  
  
## Monitoring, Logging, and Troubleshooting

## Configuring Kubernetes Security, Limits, and Accounts

## Running Stateful Applications with Kubernetes

## Handling Kubernetes Storage

## Compose on Kubernetes

[Compose on Kubernetes for Minikube](./compose-on-kubernetes-for-minikube.md)

## Kubernetes on Docker Desktop for Mac

[Bootstrapping GKE Cluster using Docker Desktop for Mac](./bootstrapping-gKE-cluster-docker-desktop-mac.md)
