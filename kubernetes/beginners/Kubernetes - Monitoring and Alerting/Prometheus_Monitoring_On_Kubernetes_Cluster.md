# How To Setup Prometheus Monitoring On Kubernetes Cluster

```git clone https://github.com/sangam14/Prometheus-Monitoring-with-k8```

Connect to your Kubernetes cluster and set up the proxy for accessing the Kubernetes dashboard.

Note: If you are using GKE, you need to run the following commands as you need privileges to create cluster roles.

```
ACCOUNT=$(gcloud info --format='value(config.account)')
kubectl create clusterrolebinding owner-cluster-admin-binding \
    --clusterrole cluster-admin \
    --user $ACCOUNT
    
 ```
# Create A Namespace

First, we will create a Kubernetes namespace for all our monitoring components. Execute the following command to create a new namespace called monitoring.

```kubectl create namespace monitoring```

You need to assign cluster reader permission to this namespace so that Prometheus can fetch the metrics from kubernetes API’s.

1. Create a file named clusterRole.yaml and copy the content of this file –> ClusterRole Config

2. Create the role using the following command.


```kubectl create -f clusterRole.yaml```

# Create A Config Map

We should create a config map with all the prometheus scrape config and alerting rules, which will be mounted to the Prometheus container in /etc/prometheus as prometheus.yaml and prometheus.rules files. The prometheus.yaml contains all the configuration to dynamically discover pods and services running in the kubernetes cluster. prometheus.rules will contain all the alert rules for sending alerts to alert manager.

1. Create a file called config-map.yaml and copy the contents of this file –> Prometheus Config File

2. Execute the following command to create the config map in kubernetes.

```kubectl create -f config-map.yaml -n monitoring```

# Create A Prometheus Deployment

1. Create a file named prometheus-deployment.yaml and copy the following contents onto the file. In this configuration, we are mounting the Prometheus config map as a file inside /etc/prometheus. It uses the official Prometheus image from docker hub.

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: prometheus-deployment
  namespace: monitoring
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: prometheus-server
    spec:
      containers:
        - name: prometheus
          image: prom/prometheus:v2.1.0
          args:
            - "--config.file=/etc/prometheus/prometheus.yml"
            - "--storage.tsdb.path=/prometheus/"
          ports:
            - containerPort: 9090
          volumeMounts:
            - name: prometheus-config-volume
              mountPath: /etc/prometheus/
            - name: prometheus-storage-volume
              mountPath: /prometheus/
      volumes:
        - name: prometheus-config-volume
          configMap:
            defaultMode: 420
            name: prometheus-server-conf
  
        - name: prometheus-storage-volume
          emptyDir: {}
          
```
4. Create a deployment on monitoring namespace using the above file.

```kubectl create  -f prometheus-deployment.yaml --namespace=monitoring```

5. You can check the created deployment using the following command.

```kubectl get deployments --namespace=monitoring```

You can also get details from the kubernetes dashboard .

# Connecting To Prometheus

You can connect to the deployed Prometheus in two ways.

Using Kubectl port forwarding
Exposing the Prometheus deployment as a service with NodePort or a Load Balancer.
We will look at both the options.

# Using Kubectl Port Forwarding

Using kubectl port forwarding, you can access the pod from your workstation using a selected port on your localhost.

1. First, get the Prometheus pod name.


```kubectl get pods --namespace=monitoring```

The output will look like the following.

```
➜  kubectl get pods --namespace=monitoring
NAME                                     READY     STATUS    RESTARTS   AGE
prometheus-monitoring-3331088907-hm5n1   1/1       Running   0          5m
```
2. Execute the following command with your pod name to access Prometheus from localhost port 8080.

Note: Replace prometheus-monitoring-3331088907-hm5n1 with your pod name.

```
kubectl port-forward prometheus-monitoring-3331088907-hm5n1 8080:9090 -n monitoring
```
3. Now, if you access http://localhost:8080 on your browser, you will get the Prometheus home page.

# Exposing Prometheus As A Service

To access the Prometheus dashboard over a IP or a DNS name, you need to expose it as kubernetes service.

1. Create a file named prometheus-service.yaml and copy the following contents. We will expose Prometheus on all kubernetes node IP’s on port 30000

```apiVersion: v1
kind: Service
metadata:
  name: prometheus-service
spec:
  selector: 
    app: prometheus-server
  type: NodePort
  ports:
    - port: 8080
      targetPort: 9090 
      nodePort: 30000
   ```
   
Note: If you are on AWS or Google Cloud, You can use Loadbalancer type, which will create a load balancer and points it to the service.

2. Create the service using the following command.
```
kubectl create -f prometheus-service.yaml --namespace=monitoring

```
3. Once created, you can access the Prometheus dashboard using any Kubernetes node IP on port 30000. If you are on the cloud, make sure you have the right firewall rules for accessing the apps.


![](https://github.com/sangam14/Prometheus-Monitoring-with-k8/blob/master/img%201.jpg)



4. Now if you go to status –> Targets, you will see all the Kubernetes endpoints connected to Prometheus automatically using service discovery as shown below. So you will get all kubernetes container and node metrics in Prometheus.



![](https://github.com/sangam14/Prometheus-Monitoring-with-k8/blob/master/img%202.jpg)

5. You can head over the homepage and select the metrics you need from the drop-down and get the graph for the time range you mention. An example graph for container memory utilization is shown below.




![](https://github.com/sangam14/Prometheus-Monitoring-with-k8/blob/master/img%203.jpg)




## Contributor - 

Sangam biradar - smbiradar14@gmail.com - engineITops.icu 
