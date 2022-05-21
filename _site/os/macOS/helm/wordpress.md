```
[Captains-Bay]🚩 >  helm version
Client: &version.Version{SemVer:"v2.8.2", GitCommit:"a80231648a1473929271764b920a8e346f6de844", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.8.2", GitCommit:"a80231648a1473929271764b920a8e346f6de844", GitTreeState:"clean"}
[Captains-Bay]🚩 >
```

```
[Captains-Bay]🚩 >  helm search wordpress
NAME            	CHART VERSION	APP VERSION	DESCRIPTION
stable/wordpress	1.0.2        	4.9.4      	Web publishing platform for building blogs and ...
[Captains-Bay]🚩 >

```

```
[Captains-Bay]🚩 >  helm install stable/wordpress --name mywp
NAME:   mywp
LAST DEPLOYED: Sat Jun  2 07:19:25 2018
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1beta1/Deployment
NAME            DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
mywp-mariadb    1        1        1           0          0s
mywp-wordpress  1        1        1           0          0s

==> v1/Pod(related)
NAME                             READY  STATUS             RESTARTS  AGE
mywp-mariadb-b689ddf74-mlprh     0/1    Init:0/1           0         0s
mywp-wordpress-774555bd4b-hcdc2  0/1    ContainerCreating  0         0s

==> v1/Secret
NAME            TYPE    DATA  AGE
mywp-mariadb    Opaque  2     1s
mywp-wordpress  Opaque  2     1s

==> v1/ConfigMap
NAME                DATA  AGE
mywp-mariadb        1     1s
mywp-mariadb-tests  1     1s

==> v1/PersistentVolumeClaim
NAME            STATUS   VOLUME                                    CAPACITY  ACCESS MODES  STORAGECLASS  AGE
mywp-mariadb    Bound    pvc-2e1f1122-6607-11e8-8d79-025000000001  8Gi       RWO           hostpath      1s
mywp-wordpress  Pending  hostpath                                  1s

==> v1/Service
NAME            TYPE          CLUSTER-IP      EXTERNAL-IP  PORT(S)                     AGE
mywp-mariadb    ClusterIP     10.98.65.236    <none>       3306/TCP                    0s
mywp-wordpress  LoadBalancer  10.109.204.199  localhost    80:31016/TCP,443:30638/TCP  0s


NOTES:
1. Get the WordPress URL:

  NOTE: It may take a few minutes for the LoadBalancer IP to be available.
        Watch the status with: 'kubectl get svc --namespace default -w mywp-wordpress'

  export SERVICE_IP=$(kubectl get svc --namespace default mywp-wordpress -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
  echo http://$SERVICE_IP/admin

2. Login with the following credentials to see your blog

  echo Username: user
  echo Password: $(kubectl get secret --namespace default mywp-wordpress -o jsonpath="{.data.wordpress-password}" | base64 --decode)

[Captains-Bay]🚩 >
```

Let's check the status:

```
[Captains-Bay]🚩 >  kubectl get svc --namespace default -w mywp-wordpress
NAME             TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
mywp-wordpress   LoadBalancer   10.109.204.199   localhost     80:31016/TCP,443:30638/TCP   47s
```


```
kubectl get svc
NAME              TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
kubernetes        ClusterIP      10.96.0.1        <none>        443/TCP                      52d
mywp-mariadb      ClusterIP      10.98.65.236     <none>        3306/TCP                     2m
mywp-wordpress    LoadBalancer   10.109.204.199   localhost     80:31016/TCP,443:30638/TCP   2m
wordpress-mysql   ClusterIP      None             <none>        3306/TCP                     7d
```

## Cleaning up

```
[Captains-Bay] > helm delete mywp
release "mywp" deleted
```

