
# Using Docker Stack Deploy to deploy Microservices on AWS CLuster using Docker for Mac

```
aws configure
```


```
aws s3api create-bucket --bucket ${bucket_name} --region us-east-1
{
    "Location": "/ajeet-kops-state-store"
}
```



```
aws s3api put-bucket-versioning --bucket ${bucket_name} --versioning-configuration Status=Enabled
```

```
[Captains-Bay]🚩 >  export KOPS_CLUSTER_NAME=ajeet.k8s.local
[Captains-Bay]🚩 >  export KOPS_STATE_STORE=s3://${bucket_name}
```

```
[Captains-Bay]🚩 >  kops create cluster \
> --node-count=2 \
> --node-size=t2.medium \
> --zones=us-east-1a \
> --name=${KOPS_CLUSTER_NAME}
I0531 06:46:21.485253    1298 create_cluster.go:1318] Using SSH public key: /Users/ajeetraina/.ssh/id_rsa.pub
I0531 06:46:25.167675    1298 create_cluster.go:472] Inferred --cloud=aws from zone "us-east-1a"
I0531 06:46:27.487123    1298 subnets.go:184] Assigned CIDR 172.20.32.0/19 to subnet us-east-1a
Previewing changes that will be made:

I0531 06:46:42.026677    1298 apply_cluster.go:456] Gossip DNS: skipping DNS validation
I0531 06:46:42.093880    1298 executor.go:91] Tasks: 0 done / 77 total; 30 can run
I0531 06:46:44.265115    1298 executor.go:91] Tasks: 30 done / 77 total; 24 can run
I0531 06:46:46.829782    1298 executor.go:91] Tasks: 54 done / 77 total; 19 can run
I0531 06:46:48.801772    1298 executor.go:91] Tasks: 73 done / 77 total; 3 can run
W0531 06:46:49.199269    1298 keypair.go:140] Task did not have an address: *awstasks.LoadBalancer {"Name":"api.ajeet.k8s.local","Lifecycle":"Sync","LoadBalancerName":"api-ajeet-k8s-local-chl4vq","DNSName":null,"HostedZoneId":null,"Subnets":[{"Name":"us-east-1a.ajeet.k8s.local","Lifecycle":"Sync","ID":null,"VPC":{"Name":"ajeet.k8s.local","Lifecycle":"Sync","ID":null,"CIDR":"172.20.0.0/16","AdditionalCIDR":null,"EnableDNSHostnames":true,"EnableDNSSupport":true,"Shared":false,"Tags":{"KubernetesCluster":"ajeet.k8s.local","Name":"ajeet.k8s.local","kubernetes.io/cluster/ajeet.k8s.local":"owned"}},"AvailabilityZone":"us-east-1a","CIDR":"172.20.32.0/19","Shared":false,"Tags":{"KubernetesCluster":"ajeet.k8s.local","Name":"us-east-1a.ajeet.k8s.local","SubnetType":"Public","kubernetes.io/cluster/ajeet.k8s.local":"owned","kubernetes.io/role/elb":"1"}}],"SecurityGroups":[{"Name":"api-elb.ajeet.k8s.local","Lifecycle":"Sync","ID":null,"Description":"Security group for api ELB","VPC":{"Name":"ajeet.k8s.local","Lifecycle":"Sync","ID":null,"CIDR":"172.20.0.0/16","AdditionalCIDR":null,"EnableDNSHostnames":true,"EnableDNSSupport":true,"Shared":false,"Tags":{"KubernetesCluster":"ajeet.k8s.local","Name":"ajeet.k8s.local","kubernetes.io/cluster/ajeet.k8s.local":"owned"}},"RemoveExtraRules":["port=443"],"Shared":null,"Tags":{"KubernetesCluster":"ajeet.k8s.local","Name":"api-elb.ajeet.k8s.local","kubernetes.io/cluster/ajeet.k8s.local":"owned"}}],"Listeners":{"443":{"InstancePort":443}},"Scheme":null,"HealthCheck":{"Target":"SSL:443","HealthyThreshold":2,"UnhealthyThreshold":2,"Interval":10,"Timeout":5},"AccessLog":null,"ConnectionDraining":null,"ConnectionSettings":{"IdleTimeout":300},"CrossZoneLoadBalancing":null}
I0531 06:46:50.626505    1298 executor.go:91] Tasks: 76 done / 77 total; 1 can run
I0531 06:46:50.966711    1298 executor.go:91] Tasks: 77 done / 77 total; 0 can run
.....
.....

Must specify --yes to apply changes

Cluster configuration has been created.

Suggestions:
 * list clusters with: kops get cluster
 * edit this cluster with: kops edit cluster ajeet.k8s.local
 * edit your node instance group: kops edit ig --name=ajeet.k8s.local nodes
 * edit your master instance group: kops edit ig --name=ajeet.k8s.local master-us-east-1a

Finally configure your cluster with: kops update cluster ajeet.k8s.local --yes

[Captains-Bay]🚩 >
```

```
kops get cluster
NAME		CLOUD	ZONES
ajeet.k8s.local	aws	us-east-1a
```


```
[Captains-Bay]🚩 >  kops update cluster --name ${KOPS_CLUSTER_NAME} --yes
I0531 07:01:41.613598    1366 apply_cluster.go:456] Gossip DNS: skipping DNS validation
I0531 07:01:44.786395    1366 executor.go:91] Tasks: 0 done / 77 total; 30 can run
I0531 07:01:46.893202    1366 executor.go:91] Tasks: 30 done / 77 total; 24 can run
I0531 07:01:49.007022    1366 executor.go:91] Tasks: 54 done / 77 total; 19 can run
I0531 07:01:51.649219    1366 executor.go:91] Tasks: 73 done / 77 total; 3 can run
I0531 07:01:53.079596    1366 executor.go:91] Tasks: 76 done / 77 total; 1 can run
I0531 07:01:53.440746    1366 executor.go:91] Tasks: 77 done / 77 total; 0 can run
I0531 07:01:54.102339    1366 update_cluster.go:291] Exporting kubecfg for cluster
kops has set your kubectl context to ajeet.k8s.local

Cluster changes have been applied to the cloud.


Changes may require instances to restart: kops rolling-update cluster

[Captains-Bay]🚩 >
```

Now you can see K8s cluster under Context UI.



