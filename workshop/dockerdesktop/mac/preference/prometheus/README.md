# Configuring Prometheus with Docker Desktop

Prometheus is an open-source systems monitoring and alerting toolkit. Prometheus collects metrics from monitored targets by scraping metrics from HTTP endpoints on these targets. Docker instance can be configured as Prometheus target.
Different targets to scrape are defined in the Prometheus configuration file. Targets may be statically configured via the static_configs parameter in the configuration fle or dynamically discovered using one of the supported service-discovery mechanisms (Consul, DNS, Etcd, etc.).
Prometheus collects metrics from monitored targets by scraping metrics from HTTP endpoints on these targets. Since Prometheus also exposes data in the same manner about itself, it can also scrape and monitor its own health.

## Docker metrics for Prometheus

Docker exposes Prometheus-compatible metrics on port 9323. This support is only available as an experimental feature.

1. For Docker for Mac, click on Docker icon in the status menu

2. Select Preferences…, Daemon, Advanced tab

3. Update daemon settings:

```
{
  "metrics-addr" : "0.0.0.0:9323",
  "experimental" : true
}
```

4. Click on Apply & Restart to restart the daemon

![image](https://user-images.githubusercontent.com/34368930/205006568-86f172ef-c72a-4c8b-b019-41d66d3c97c5.png)



5. Show the complete list of metrics using curl http://localhost:9323/metrics

6. Show the list of engine metrics using curl http://localhost:9323/metrics | grep engine

## Start Prometheus

In this section, we’ll start Prometheus and use it to scrape it’s own health.

1. Create a new directory prometheus and change to that directory

2. Create a text file prometheus.yml and use the following content:

```
# A scrape configuration scraping a Node Exporter and the Prometheus server
# itself.
scrape_configs:
  # Scrape Prometheus itself every 5 seconds.
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
 ```
 
 This configuration file scrapes data from the Prometheus container which will be started subsequently on port 9090.

3. Start a single-replica Prometheus service:

```
docker service create \
  --replicas 1 \
  --name metrics \
  --mount type=bind,source=`pwd`/prometheus.yml,destination=/etc/prometheus/prometheus.yml \
  --publish 9090:9090/tcp \
  prom/prometheus
```

This will start the Prometheus container on port 9090.

4. Prometheus dashboard is at http://localhost:9090. Check the list of enabled targets at http://localhost:9090/targets (also accessible from Status → Targets menu).
 
 ![image](https://user-images.githubusercontent.com/34368930/205007008-3f4d02fb-51a4-4476-9109-c459756e45af.png)


It shows that the Prometheus endpoint is available for scraping.


5. Click on Graph and click on -insert metric at cursor- to see the list of metrics available:

![image](https://user-images.githubusercontent.com/34368930/205007088-ff7f422f-5ce2-463a-b271-09f364640903.png)




These are all the metrics published by the Prometheus endpoint.

6. Choose http_request_total metrics, click on Execute


![image](https://user-images.githubusercontent.com/34368930/205007246-072e6177-f7ad-4ca5-92db-26a11a51abc3.png)


7. Switch from Console to Graph

![image](https://user-images.githubusercontent.com/34368930/205007301-e74188d1-c55d-4faa-a38a-421239a42038.png)



8. Change the duration from 1h to 5m

![image](https://user-images.githubusercontent.com/34368930/205007349-3cc78911-2fdc-42a6-aab3-e6dc0c08ea63.png)



9. Click on Add Graph, select a different metric, say http_requests_duration_microseconds, and click on Execute

![image](https://user-images.githubusercontent.com/34368930/205007409-88aa5f81-0f7e-47e4-a0f2-69768fd279e5.png)



10. Switch from Console to Graph and change the duration from 1h to 5m

![image](https://user-images.githubusercontent.com/34368930/205007471-e9ac4166-0f8f-48ef-9794-480cd7f7c082.png)





