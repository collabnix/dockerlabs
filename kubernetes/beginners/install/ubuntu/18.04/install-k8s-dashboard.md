# Installing Kubernetes Dashboard

```
wget https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
```

## Change the YAML file and include at the Dashboard Service section

```

# ------------------- Dashboard Service ------------------- #

kind: Service
apiVersion: v1
metadata:
  labels:
    k8s-app: kubernetes-dashboard
  name: kubernetes-dashboard
  namespace: kube-system
spec:
  type: LoadBalancer
  ports:
    - port: 443
      targetPort: 8443
  selector:
    k8s-app: kubernetes-dashboard
cse@kubemaster:~$

```
Just add type: LoadBalancer as shown above.


```
$ sudo kubectl create -f kubernetes-dashboard.yaml
secret/kubernetes-dashboard-certs created
serviceaccount/kubernetes-dashboard created
role.rbac.authorization.k8s.io/kubernetes-dashboard-minimal created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard-minimal created
deployment.apps/kubernetes-dashboard created
service/kubernetes-dashboard created
```

```
cse@kubemaster:~$ kubectl get svc --namespace=kube-system
NAME                   TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)                  AGE
kube-dns               ClusterIP      10.96.0.10    <none>          53/UDP,53/TCP,9153/TCP   23h
kubernetes-dashboard   LoadBalancer   10.99.35.10   100.98.26.202   443:30725/TCP            12s
cse@kubemaster:~$ ^C
cse@kubemaster:~$
```
