# Lab #03: Creating a Deployment with 3 replicas of NGINX service

```
kubectl create -f nginx-deploy.yaml
```


```
kubectl set image deploy nginx-deploy nginx-container=nginx:1.9.1
```

```
[node1 lab03-creating-deployment-3replicas-nginx]$ kubectl rollout status deployment/nginx-deploy
deployment "nginx-deploy" successfully rolled out
[node1 lab03-creating-deployment-3replicas-nginx]$ kubectl describe deploy
Name:                   nginx-deploy
Namespace:              default
CreationTimestamp:      Sat, 13 Jul 2019 18:50:48 +0000
Labels:                 app=nginx-app
Annotations:            deployment.kubernetes.io/revision: 2
Selector:               app=nginx-app
Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=nginx-app
  Containers:
   nginx:
    Image:        nginx:1.9.1
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   nginx-deploy-5985c6547d (3/3 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  20m    deployment-controller  Scaled up replica set nginx-deploy-c9d474fc to 3
  Normal  ScalingReplicaSet  5m35s  deployment-controller  Scaled up replica set nginx-deploy-5985c6547d to 1
  Normal  ScalingReplicaSet  4m57s  deployment-controller  Scaled down replica set nginx-deploy-c9d474fc to 2
  Normal  ScalingReplicaSet  4m57s  deployment-controller  Scaled up replica set nginx-deploy-5985c6547d to 2
  Normal  ScalingReplicaSet  4m19s  deployment-controller  Scaled down replica set nginx-deploy-c9d474fc to 1
  Normal  ScalingReplicaSet  4m19s  deployment-controller  Scaled up replica set nginx-deploy-5985c6547d to 3
  ```


```
kubectl rollout status deployment/nginx-deploy
```
```
kubectl rollout status deployment/nginx-deploy
deployment "nginx-deploy" successfully rolled out
[node1 lab03-creating-deployment-3replicas-nginx]$
```

## Scaling up Nginx App

```
[node1 lab03-creating-deployment-3replicas-nginx]$ kubectl scale deployment nginx-deploy --replicas=6deployment.extensions/nginx-deploy scaled
[node1 lab03-creating-deployment-3replicas-nginx]$ kubectl get deployNAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   5/6     6            5           22m
```
