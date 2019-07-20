
            
This is an Example for Multi Container Pod 
Simple tutorial to demonstrate the concept of packaging multiple containers into a single pod.

Web Pod has a Python Flask container and a Redis container
DB Pod has a MySQL container
When data is retrieved through the Python REST API, it first checks within Redis cache before accessing MySQL
Each time data is fetched from MySQL, it gets cached in the Redis container of the same Pod as the Python Flask container
When the additional Web Pods are launched manually or through a Replica Set, co-located pairs of Python Flask and Redis containers are scheduled together

![Architecture](https://github.com/sangam14/Multi-Container-Pods-in-Kubernetes/blob/master/multi-container-pod.png?raw=true)

Make sure that you have access to a Kubernetes cluster.

Deploy both the yaml files in the repository and check the pods and service created

```
kubectl get pods 
NAME                              READY   STATUS    RESTARTS   AGE
web-deployment-59f55d55cc-dr8sg   2/2     Running   0          10h
web-deployment-59f55d55cc-gs6q7   2/2     Running   0          10h
web-deployment-59f55d55cc-kgrwn   2/2     Running   0          10h


kubectl get svc
NAME                      TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
web                       NodePort    10.111.115.205   <none>        80:30363/TCP   22h
```

## Get the IP address of one of the Nodes and the NodePort for the web Service. Populate the variables with the appropriate values
```
kubectl get nodes
export NODE_IP=<NODE_IP>
export NODE_PORT=<NODE_PORT>
```

## Insert some sample data
```
curl -i -H "Content-Type: application/json" -X POST -d '{"uid": "1", "user":"Saiyam Pathak"}' http://$NODE_IP:$NODE_PORT/users/add
curl -i -H "Content-Type: application/json" -X POST -d '{"uid": "2", "user":"Sangam Birdar"}' http://$NODE_IP:$NODE_PORT/users/add
curl -i -H "Content-Type: application/json" -X POST -d '{"uid": "3", "user":"Ajeet Singh Rana"}' http://$NODE_IP:$NODE_PORT/users/add
```

## Access the data 
```
curl http://$NODE_IP:$NODE_PORT/users/1
```
## The second time you access the data, it appends '(c)' indicating that it is pulled from the Redis cache
```
curl http://$NODE_IP:$NODE_PORT/users/1
```
maintainer - Saiyam Pathak (saiyam911@gmail.com) | @saiyampathak | https://medium.com/@saiyampathak
             Sangam Birdar
