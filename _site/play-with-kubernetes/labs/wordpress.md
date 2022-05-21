# Lab #1 - Demonstrating WordPress Application on K8s Cluster


```
[node1 ~]$ kubectl create secret generic mysql-pass --from-literal=password=mysql123
```

```
secret "mysql-pass" created
```

```
[node1 ~]$ kubectl get secrets
```

```
NAME                  TYPE                                  DATA      AGEdefault-token-gg4gj   kubernetes.io/service-account-token   3         47mmysql-pass            Opaque                                1         17s
```





