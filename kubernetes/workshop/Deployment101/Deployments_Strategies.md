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
