
# Setting Up Alert Manager On Kubernetes

AlertManager is an opensource alerting system which works with Prometheus Monitoring system.
In our dockerlab , we have explained Prometheus setup on Kubernetes.


Note: all the Alert Manager Kubernetes objects will be created inside a namespace called monitoring. 
If you use a different namespace, you can replace it in the YAML files.


## Alert Manager On Kubernetes

Alert Manager setup has the following key configurations.

1.A config map for Alert Manager configuration<br>
2.A config Map for Alert Manager alert templates<br>
3.Alert Manager Deployment.<br>
4.Alert Manager service to access the web UI.<br>


## Key Things To Note

1.You should have a working Prometheus setup up and running. Follow this lab for Prometheus setup ==> [Prometheus Setup On Kubernetes](https://github.com/sangam14/Prometheus-Monitoring-with-k8/blob/master/README.md)<br>
2.Prometheus should have the correct alert manager service endpoint in its config.yaml as shown below. Only then, Prometheus will be able to send the alert to Alert Manager.

```
alerting:
   alertmanagers:
      - scheme: http
        static_configs:
        - targets:
          - "alertmanager.monitoring.svc:9093"
 ```
 3.All the alerting rules have to be present on Prometheus config based on your needs. It should be created as part of the Prometheus config map with a file named prometheus.rules and added to the config.yaml in the following way.
```
rule_files:
      - /etc/prometheus/prometheus.rules
      
```      

4. Alerts can be written based on the metrics you receive on Prometheus.
5. For receiving emails for alerts, you need to have a valid SMTP host in the alert manager config.yaml (smarthost prameter). You can customize the email template as per your needs in the Alert Template config map. We have given the generic template in this guide.
Let’s get started with the setup.



Alert Manager reads its configuration from a config.yaml file. It contains the configuration of alert template path, email and other alert receiving configuration. In this setup, we are using email and slack receivers. You can have a look at all the supported alert [receivers from here](https://prometheus.io/docs/alerting/configuration/#%3Creceiver%3E).

Create a file named AlertManagerConfigmap.yaml and copy the following contents.

```

kind: ConfigMap
apiVersion: v1
metadata:
  name: alertmanager-config
  namespace: monitoring
data:
  config.yml: |-
    global:
    templates:
    - '/etc/alertmanager/*.tmpl'
    route:
      receiver: alert-emailer
      group_by: ['alertname', 'priority']
      group_wait: 10s
      repeat_interval: 30m
      routes:
        - receiver: slack_demo
        # Send severity=slack alerts to slack.
          match:
            severity: slack
          group_wait: 10s
          repeat_interval: 1m
 
    receivers:
    - name: alert-emailer
      email_configs:
      - to: demo@engineitops.icu
        send_resolved: false
        from: from-email@email.com
        smarthost: email-host-here
        require_tls: false
    - name: slack_demo
      slack_configs:
      - api_url: enter url of slack hook 
        channel: '#enterchannel_name'

```
## Let’s create the config map using kubectl.
```
kubectl create -f AlertManagerConfigmap.yaml


```
## Config Map For Alert Template

We need alert templates for all the receivers we use (email, slack etc). Alert manager will dynamically substitute the values and delivers alerts to the receivers based on the template. You can customize these templates based on your needs.

Create a file named AlertManagerConfigmap.yaml and copy the contents from this file link ==> Alert Manager Template YAML

## Create the configmap using kubectl.


```
kubectl create -f AlertTemplateConfigMap.yaml

```
## Create A Deployment

In this deployment, we will mount the two config maps we created.

Create a file called Deployment.yaml with the following contents.

```

apiVersion: apps/v1
kind: Deployment
metadata:
  name: alertmanager
  namespace: monitoring
spec:
  replicas: 1
  selector:
    matchLabels:
      app: alertmanager
  template:
    metadata:
      name: alertmanager
      labels:
        app: alertmanager
    spec:
      containers:
      - name: alertmanager
        image: prom/alertmanager:latest
        args:
          - "--config.file=/etc/alertmanager/config.yml"
          - "--storage.path=/alertmanager"
        ports:
        - name: alertmanager
          containerPort: 9093
        volumeMounts:
        - name: config-volume
          mountPath: /etc/alertmanager
        - name: templates-volume
          mountPath: /etc/alertmanager-templates
        - name: alertmanager
          mountPath: /alertmanager
      volumes:
      - name: config-volume
        configMap:
          name: alertmanager-config
      - name: templates-volume
        configMap:
          name: alertmanager-templates
      - name: alertmanager
        emptyDir: {}
```


## Create the deployment using kubectl.

```
kubectl create -f Deployment.yaml

```
## Create A Service

We need to expose the alert manager using NodePort or Load Balancer just to access the Web UI. Prometheus will talk to alert manager using the internal service endpoint.

Create a Service.yaml file with the following contents.

```
apiVersion: v1
kind: Service
metadata:
  name: alertmanager
  namespace: monitoring
  annotations:
      prometheus.io/scrape: 'true'
      prometheus.io/path:   /
      prometheus.io/port:   '8080'
spec:
  selector: 
    app: alertmanager
  type: NodePort  
  ports:
    - port: 9093
      targetPort: 9093
      nodePort: 31000
      
 ```     
## Create the service using kubectl.

```
kubectl create -f Service.yaml

```
Now, you will be able to access Alert Manager on Node Port 31000. For example,

```
http://35.114.150.153:31000

```


## Contributor - 

Sangam biradar - smbiradar14@gmail.com - engineITops.icu  
