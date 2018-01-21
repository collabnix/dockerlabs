# Setting up Kubernetes Dashboard under Docker for Mac 18.01

```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl create -f ./kubernetes-dashboard.yaml
```

```
secret "kubernetes-dashboard-certs" created
serviceaccount "kubernetes-dashboard" created
role "kubernetes-dashboard-minimal" created
rolebinding "kubernetes-dashboard-minimal" created
deployment "kubernetes-dashboard" created
service "kubernetes-dashboard" created
```

# Displaying the Deployments


```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl get deployment
NAME      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
db        1         1         1            1           7h
web       1         1         1            1           7h
```

# Displaying the Pods

```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl get pods
NAME                   READY     STATUS    RESTARTS   AGE
db-6d45958ddf-jzcf8    1/1       Running   0          25m
web-69bccb5f54-5fhxx   1/1       Running   0          25m
```

```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl get deployments --namespace kube-system
NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
kube-dns               1         1         1            1           7d
kubernetes-dashboard   1         1         1            0           28s
```

As we are connected via the proxy we do not need to sign in using either Kubeconfig or with a Token, 
so just press Skip, this will take you straight to the Dashboard;
```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl proxy
Starting to serve on 127.0.0.1:8001
```

# Accessing through UI

```
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```
