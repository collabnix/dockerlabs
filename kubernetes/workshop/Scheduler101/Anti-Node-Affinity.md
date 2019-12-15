# Anti-Node Affinity ?

- Some scenarios require that you don’t use one or more nodes except for particular pods. Think of the nodes that host your monitoring application.
- Those nodes shouldn’t have many resources due to the nature of their role. Thus, if other pods than those which have the monitoring app are scheduled to those nodes, they hurt monitoring and also degrades the application they are hosting.
- In such a case, you need to use node anti-affinity to keep pods away from a set of nodes.

```
apiVersion: v1
kind: Pod
metadata:
 name: mongo
spec:
 affinity:
   nodeAffinity:
     requiredDuringSchedulingIgnoredDuringExecution:
       nodeSelectorTerms:
       - matchExpressions:
         - key: feature
           operator: In
           values:
           - ssd
           - eight-cores
         - key: role
           operator: NotIn
           values:
           - monitoring

 containers:
 - name: mongodb
   image: mogo
```

- Adding another key to the matchExpressions with the operator NotIn will avoid scheduling the mongo pods on any node labelled role=monitoring.
