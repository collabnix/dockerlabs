# Build Prometheus Stack using Helm

```
[Captains-Bay]🚩 >  helm install stable/prometheus
NAME:   hasty-ladybug
LAST DEPLOYED: Sun Jun  3 09:00:30 2018
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/PersistentVolumeClaim
NAME                                   STATUS  VOLUME                                    CAPACITY  ACCESS MODES  STORAGECLASS  AGE
hasty-ladybug-prometheus-alertmanager  Bound   pvc-7732a80b-66de-11e8-b7d4-025000000001  2Gi       RWO           hostpath      2s
hasty-ladybug-prometheus-server        Bound   pvc-773541f3-66de-11e8-b7d4-025000000001  8Gi       RWO           hostpath      2s

==> v1/ServiceAccount
NAME                                         SECRETS  AGE
hasty-ladybug-prometheus-alertmanager        1        2s
hasty-ladybug-prometheus-kube-state-metrics  1        2s
hasty-ladybug-prometheus-node-exporter       1        2s
hasty-ladybug-prometheus-pushgateway         1        2s
hasty-ladybug-prometheus-server              1        2s

==> v1beta1/ClusterRoleBinding
NAME                                         AGE
hasty-ladybug-prometheus-kube-state-metrics  2s
hasty-ladybug-prometheus-server              2s

==> v1beta1/DaemonSet
NAME                                    DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
hasty-ladybug-prometheus-node-exporter  1        1        0      1           0          <none>         2s

==> v1/Pod(related)
NAME                                                          READY  STATUS             RESTARTS  AGE
hasty-ladybug-prometheus-node-exporter-9ggqj                  0/1    ContainerCreating  0         2s
hasty-ladybug-prometheus-alertmanager-5c67b8b874-4xxtj        0/2    ContainerCreating  0         2s
hasty-ladybug-prometheus-kube-state-metrics-5cbcd4d86c-788p4  0/1    ContainerCreating  0         2s
hasty-ladybug-prometheus-pushgateway-c45b7fd6f-2wwzm          0/1    Pending            0         2s
hasty-ladybug-prometheus-server-799d6c7c75-jps8k              0/2    Init:0/1           0         2s

==> v1/ConfigMap
NAME                                   DATA  AGE
hasty-ladybug-prometheus-alertmanager  1     2s
hasty-ladybug-prometheus-server        3     2s

==> v1beta1/ClusterRole
NAME                                         AGE
hasty-ladybug-prometheus-kube-state-metrics  2s
hasty-ladybug-prometheus-server              2s

==> v1/Service
NAME                                         TYPE       CLUSTER-IP     EXTERNAL-IP  PORT(S)   AGE
hasty-ladybug-prometheus-alertmanager        ClusterIP  10.96.193.91   <none>       80/TCP    2s
hasty-ladybug-prometheus-kube-state-metrics  ClusterIP  None           <none>       80/TCP    2s
hasty-ladybug-prometheus-node-exporter       ClusterIP  None           <none>       9100/TCP  2s
hasty-ladybug-prometheus-pushgateway         ClusterIP  10.97.92.108   <none>       9091/TCP  2s
hasty-ladybug-prometheus-server              ClusterIP  10.96.118.138  <none>       80/TCP    2s

==> v1beta1/Deployment
NAME                                         DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
hasty-ladybug-prometheus-alertmanager        1        1        1           0          2s
hasty-ladybug-prometheus-kube-state-metrics  1        1        1           0          2s
hasty-ladybug-prometheus-pushgateway         1        1        1           0          2s
hasty-ladybug-prometheus-server              1        1        1           0          2s


NOTES:
The Prometheus server can be accessed via port 80 on the following DNS name from within your cluster:
hasty-ladybug-prometheus-server.default.svc.cluster.local


Get the Prometheus server URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9090


The Prometheus alertmanager can be accessed via port 80 on the following DNS name from within your cluster:
hasty-ladybug-prometheus-alertmanager.default.svc.cluster.local


Get the Alertmanager URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=alertmanager" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9093


The Prometheus PushGateway can be accessed via port 9091 on the following DNS name from within your cluster:
hasty-ladybug-prometheus-pushgateway.default.svc.cluster.local


Get the PushGateway URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=pushgateway" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9091

For more information on running Prometheus, visit:
https://prometheus.io/
```

## Verifying the list

```
[Captains-Bay]🚩 >  helm ls
NAME         	REVISION	UPDATED                 	STATUS  	CHART           	NAMESPACE
hasty-ladybug	1       	Sun Jun  3 09:00:30 2018	DEPLOYED	prometheus-6.7.0	default
mywp         	1       	Sat Jun  2 07:19:25 2018	DEPLOYED	wordpress-1.0.2 	default
```


## 

```
export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
```

```
kubectl --namespace default port-forward $POD_NAME 9090
```

## Now you can access Prometheus:

```
open http://localhost:9090
```

## Cleaning Up

```
[Captains-Bay]🚩 >  helm delete hasty-ladybug
release "hasty-ladybug" deleted
```
