## Searching for Application

```
helm search wordpress
```

```
[node1 ~]$ helm install stable/wordpress
NAME:   ulterior-quail
LAST DEPLOYED: Fri Nov  8 18:34:01 2019
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/ConfigMap
NAME                          AGE
ulterior-quail-mariadb        11s
ulterior-quail-mariadb-tests  11s

==> v1/Deployment
NAME                      AGE
ulterior-quail-wordpress  10s

==> v1/PersistentVolumeClaim
NAME                      AGE
ulterior-quail-wordpress  11s

==> v1/Pod(related)
NAME                                       AGE
ulterior-quail-mariadb-0                   8s
ulterior-quail-wordpress-6b646c8d4d-wkhqv  7s

==> v1/Secret
NAME                      AGE
ulterior-quail-mariadb    11s
ulterior-quail-wordpress  11s

==> v1/Service
NAME                      AGE
ulterior-quail-mariadb    10s
ulterior-quail-wordpress  10s

==> v1/StatefulSet
NAME                    AGE
ulterior-quail-mariadb  10s


NOTES:
1. Get the WordPress URL:

  NOTE: It may take a few minutes for the LoadBalancer IP to be available.
        Watch the status with: 'kubectl get svc --namespace default -w ulterior-quail-wordpress'
  export SERVICE_IP=$(kubectl get svc --namespace default ulterior-quail-wordpress --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
  echo "WordPress URL: http://$SERVICE_IP/"
  echo "WordPress Admin URL: http://$SERVICE_IP/admin"

2. Login with the following credentials to see your blog

  echo Username: user
  echo Password: $(kubectl get secret --namespace default ulterior-quail-wordpress -o jsonpath="{.data.wordpress-password}" | base64 --decode)
  ```

