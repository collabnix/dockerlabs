# Lab 04: Scaling a Deployment



```
[node1 lab03-creating-deployment-3replicas-nginx]$ kubectl scale deployment nginx-deploy --replicas=6deployment.extensions/nginx-deploy scaled
[node1 lab03-creating-deployment-3replicas-nginx]$ kubectl get deployNAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   5/6     6            5           22m
```

