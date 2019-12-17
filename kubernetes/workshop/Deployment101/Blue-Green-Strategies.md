## Kubernetes Deployments Strategies Overview (Rolling Update)
If you want to use the rolling update strategy, you needn’t specify any parameters in the definition file.


```
spec:
 strategy:
 type: RollingUpdate
 rollingUpdate:
   maxSurge: 1
   maxUnavailable: 50%

```

## Step 1 : Create the Blue Deployment

The Deployment will start up a few nginx containers as the application. The Deployment has a name and version label. This is significant as the Service will use these labels to switch to the green version later.

```
Biradars-MacBook-Air-4:~ sangam$ kubectl apply -f blue-deploy.yaml
deployment.extensions/nginx-1.10 created
```
The service is of type=LoadBalancer so it can be accessed via a Network Load Balancer on GCP. It uses the name and version labels specified in the Deployment to select the pods for the service.

```
Biradars-MacBook-Air-4:~ sangam$ kubectl apply -f service.yaml
service/nginx created
Biradars-MacBook-Air-4:~ sangam$ 
```
Create the Service:
```
$ kubectl apply -f service.yaml
```
You can update the Blue Deployment's file directly or use a tool like sed:

Create the new Deployment:
```
Biradars-MacBook-Air-4:~ sangam$ sed 's/1\.10/1.11/' blue-deploy.yaml | kubectl apply -f -
deployment.extensions/nginx-1.11 created
```
test new version 
```
Biradars-MacBook-Air-4:~ sangam$ kubectl get pods --output=wide
NAME                          READY   STATUS    RESTARTS   AGE     IP           NODE             NOMINATED NODE   READINESS GATES
nginx-1.10-547948f549-9wvhd   1/1     Running   0          48m     10.1.0.244   docker-desktop   <none>           <none>
nginx-1.10-547948f549-grf5m   1/1     Running   0          48m     10.1.0.246   docker-desktop   <none>           <none>
nginx-1.10-547948f549-j5cqk   1/1     Running   0          48m     10.1.0.245   docker-desktop   <none>           <none>
nginx-1.11-848b9b487-4l5nh    1/1     Running   0          7m15s   10.1.0.250   docker-desktop   <none>           <none>
nginx-1.11-848b9b487-sggtp    1/1     Running   0          7m16s   10.1.0.249   docker-desktop   <none>           <none>
nginx-1.11-848b9b487-zf4k8    1/1     Running   0          7m15s   10.1.0.251   docker-desktop   <none>           <none>
Biradars-MacBook-Air-4:~ sangam$ 
```

## Automating Blue/Green Deployments

While ideally Blue/Green Deployments would be implemented server side, one way to automate them is on the client-side using scripts. This very simple bash script creates the new Deployment and waits for it to become ready before updating the Service's selector.

```
#!/bin/bash

# bg-deploy.sh <servicename> <version> <green-deployment.yaml>
# Deployment name should be <service>-<version>

DEPLOYMENTNAME=$1-$2
SERVICE=$1
VERSION=$2
DEPLOYMENTFILE=$3

kubectl apply -f $DEPLOYMENTFILE

# Wait until the Deployment is ready by checking the MinimumReplicasAvailable condition.
READY=$(kubectl get deploy $DEPLOYMENTNAME -o json | jq '.status.conditions[] | select(.reason == "MinimumReplicasAvailable") | .status' | tr -d '"')
while [[ "$READY" != "True" ]]; do
    READY=$(kubectl get deploy $DEPLOYMENTNAME -o json | jq '.status.conditions[] | select(.reason == "MinimumReplicasAvailable") | .status' | tr -d '"')
    sleep 5
done

# Update the service selector with the new version
kubectl patch svc $SERVICE -p "{\"spec\":{\"selector\": {\"name\": \"${SERVICE}\", \"version\": \"${VERSION}\"}}}"

echo "Done."


```



