Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the Ingress resource.

What that means that you can have a global loadbalancer and then Ingress to route you traffic from internet to the services. This way you need not have separate LoadBalancers for each service.

In order for the Ingress resource to work, the cluster must have an ingress controller running. Ingress controllers are not started automatically with a cluster.

In order to make ingress works below are the steps required:-
   - Nginx controlled deployment
   - Config Maps for Nginx Controller
   - RBAC rules
   - Deployment of application and creating service
