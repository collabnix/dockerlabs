# Deployment 101

## Step #1. Check the list of application deployment


Run command would have created only one Pod for running our application. But in the real life scenario,when traffic increases, 
we will need to scale the application to keep up with user demand. Running multiple instances of an application will 
require a way to distribute the traffic to all of them. Services have an integrated load-balancer that will 
distribute network traffic to all Pods of an exposed Deployment.
Services will monitor continuously the running Pods using endpoints, to ensure the traffic is sent only to available Pods.

```
# vi nginx-dep.yaml

apiVersion: apps/v1beta2
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80
  ```      
  
  ```
  kubectl create -f nginx-dep.yaml
  deployment.apps/nginx-deployment created
  ```

To list your deployments use the get deployments command:
```
Biradars-MacBook-Air-4:~ sangam$ kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   2/2     2            2           63s

```


We should have 1 Pod. If not, run the command again. This shows:

    The DESIRED state is showing the configured number of replicas
    The CURRENT state show how many replicas are running now
    The UP-TO-DATE is the number of replicas that were updated to match the desired (configured) state
    The AVAILABLE state shows how many replicas are actually AVAILABLE to the users

## Step #2. Scale up/down application deployment

Now let’s scale the Deployment to 4 replicas. We are going to use the kubectl scale command,
followed by the deployment type, name and desired number of instances:


The change was applied, and we have 4 instances of the application available. Next, 
let’s check if the number of Pods changed:


Now There should be 4 pods running in the cluster



There are 4 Pods now, with different IP addresses. T
he change was registered in the Deployment events log. To check that, use the describe command:




You can also view in the output of this command that there are 4 replicas now.

To scale down the Service to 2 replicas, run again the scale command:



## Step #3. Perform rolling updates to application deployment

If you have multiple instances of an Application running, there could be scenarios where old instances can clash with the new instances and if you shutdown the cluster for updates,downtime could never be not acceptable.Users expect applications to be available all the time and 
developers are expected to deploy new versions of them several times a day.
In Kubernetes this is done with rolling updates. Rolling updates allow Deployments update to take place with zero downtime by incrementally updating Pods instances with new ones. The new Pods will be scheduled on Nodes with available resources.

Rolling updates allow the following actions:

   -  Promote an application from one environment to another (via container image updates)
   -  Rollback to previous versions
    - Continuous Integration and Continuous Delivery of applications with zero downtime



To update the image of the application to new version, use the set image command,
followed by the deployment name and the new image version:

The command notified the Deployment to use a different image for your app and initiated a rolling update. Check the status of the new Pods, and view the old one terminating with the get pods command:
## Step #4. Rollback updates to application deployment



The rollout command reverted the deployment to the previous known state. Updates are versioned and you can revert to any previously know state of a Deployment. List again the Pods:

After the rollout succeeds, you may want to get the Deployment.

## Step #5. Cleanup

Finally you can clean up the resources you created in your cluster:
```
kubectl delete service my-nginx
kubectl delete deployment my-nginx
```





