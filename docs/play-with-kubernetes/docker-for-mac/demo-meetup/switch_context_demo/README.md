# How to view the current context?

```
[Captains-Bay]🚩 >  kubectl config get-contexts
CURRENT   NAME                                              CLUSTER                                           AUTHINFO                                          NAMESPACE
kubernetes-admin@kubernetes                       kubernetes                                        kubernetes-admin
minikube                                          minikube                                          minikube
docker-for-desktop                                docker-for-desktop-cluster                        docker-for-desktop
gke_spheric-temple-187614_asia-east1-a_k8s-lab1   gke_spheric-temple-187614_asia-east1-a_k8s-lab1   gke_spheric-temple-187614_asia-east1-a_k8s-lab1
```


# How to delete the specific context?

```
[Captains-Bay]🚩 >  kubectl config delete-context gce
deleted context gce from /Users/ajeetraina/.kube/config
```

# How to switch from one context to another?

```
[Captains-Bay]🚩 >  kubectl config use-context minikube
Switched to context "minikube".
```
