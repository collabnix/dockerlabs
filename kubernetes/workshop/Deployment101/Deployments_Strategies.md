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


