
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
Will create resources:
  AutoscalingGroup/master-us-east-1a.masters.ajeet.k8s.local
  	MinSize             	1
  	MaxSize             	1
  	Subnets             	[name:us-east-1a.ajeet.k8s.local]
  	Tags                	{k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup: master-us-east-1a, k8s.io/role/master: 1, Name: master-us-east-1a.masters.ajeet.k8s.local, KubernetesCluster: ajeet.k8s.local}
  	Granularity         	1Minute
  	Metrics             	[GroupDesiredCapacity, GroupInServiceInstances, GroupMaxSize, GroupMinSize, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances]
  	LaunchConfiguration 	name:master-us-east-1a.masters.ajeet.k8s.local

  AutoscalingGroup/nodes.ajeet.k8s.local
  	MinSize             	2
  	MaxSize             	2
  	Subnets             	[name:us-east-1a.ajeet.k8s.local]
  	Tags                	{k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup: nodes, k8s.io/role/node: 1, Name: nodes.ajeet.k8s.local, KubernetesCluster: ajeet.k8s.local}
  	Granularity         	1Minute
  	Metrics             	[GroupDesiredCapacity, GroupInServiceInstances, GroupMaxSize, GroupMinSize, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances]
  	LaunchConfiguration 	name:nodes.ajeet.k8s.local

  DHCPOptions/ajeet.k8s.local
  	DomainName          	ec2.internal
  	DomainNameServers   	AmazonProvidedDNS
  	Shared              	false
  	Tags                	{kubernetes.io/cluster/ajeet.k8s.local: owned, Name: ajeet.k8s.local, KubernetesCluster: ajeet.k8s.local}

  EBSVolume/a.etcd-events.ajeet.k8s.local
  	AvailabilityZone    	us-east-1a
  	VolumeType          	gp2
  	SizeGB              	20
  	Encrypted           	false
  	Tags                	{kubernetes.io/cluster/ajeet.k8s.local: owned, Name: a.etcd-events.ajeet.k8s.local, KubernetesCluster: ajeet.k8s.local, k8s.io/etcd/events: a/a, k8s.io/role/master: 1}

  EBSVolume/a.etcd-main.ajeet.k8s.local
  	AvailabilityZone    	us-east-1a
  	VolumeType          	gp2
  	SizeGB              	20
  	Encrypted           	false
  	Tags                	{kubernetes.io/cluster/ajeet.k8s.local: owned, Name: a.etcd-main.ajeet.k8s.local, KubernetesCluster: ajeet.k8s.local, k8s.io/etcd/main: a/a, k8s.io/role/master: 1}

  IAMInstanceProfile/masters.ajeet.k8s.local

  IAMInstanceProfile/nodes.ajeet.k8s.local

  IAMInstanceProfileRole/masters.ajeet.k8s.local
  	InstanceProfile     	name:masters.ajeet.k8s.local id:masters.ajeet.k8s.local
  	Role                	name:masters.ajeet.k8s.local

  IAMInstanceProfileRole/nodes.ajeet.k8s.local
  	InstanceProfile     	name:nodes.ajeet.k8s.local id:nodes.ajeet.k8s.local
  	Role                	name:nodes.ajeet.k8s.local

  IAMRole/masters.ajeet.k8s.local
  	ExportWithID        	masters

  IAMRole/nodes.ajeet.k8s.local
  	ExportWithID        	nodes

  IAMRolePolicy/masters.ajeet.k8s.local
  	Role                	name:masters.ajeet.k8s.local

  IAMRolePolicy/nodes.ajeet.k8s.local
  	Role                	name:nodes.ajeet.k8s.local

  InternetGateway/ajeet.k8s.local
  	VPC                 	name:ajeet.k8s.local
  	Shared              	false
  	Tags                	{KubernetesCluster: ajeet.k8s.local, kubernetes.io/cluster/ajeet.k8s.local: owned, Name: ajeet.k8s.local}

  Keypair/apiserver-aggregator
  	Signer              	name:apiserver-aggregator-ca id:cn=apiserver-aggregator-ca
  	Subject             	cn=aggregator
  	Type                	client
  	Format              	v1alpha2

  Keypair/apiserver-aggregator-ca
  	Subject             	cn=apiserver-aggregator-ca
  	Type                	ca
  	Format              	v1alpha2

  Keypair/apiserver-proxy-client
  	Signer              	name:ca id:cn=kubernetes
  	Subject             	cn=apiserver-proxy-client
  	Type                	client
  	Format              	v1alpha2

  Keypair/ca
  	Subject             	cn=kubernetes
  	Type                	ca
  	Format              	v1alpha2

  Keypair/kops
  	Signer              	name:ca id:cn=kubernetes
  	Subject             	o=system:masters,cn=kops
  	Type                	client
  	Format              	v1alpha2

  Keypair/kube-controller-manager
  	Signer              	name:ca id:cn=kubernetes
  	Subject             	cn=system:kube-controller-manager
  	Type                	client
  	Format              	v1alpha2

  Keypair/kube-proxy
  	Signer              	name:ca id:cn=kubernetes
  	Subject             	cn=system:kube-proxy
  	Type                	client
  	Format              	v1alpha2

  Keypair/kube-scheduler
  	Signer              	name:ca id:cn=kubernetes
  	Subject             	cn=system:kube-scheduler
  	Type                	client
  	Format              	v1alpha2

  Keypair/kubecfg
  	Signer              	name:ca id:cn=kubernetes
  	Subject             	o=system:masters,cn=kubecfg
  	Type                	client
  	Format              	v1alpha2

  Keypair/kubelet
  	Signer              	name:ca id:cn=kubernetes
  	Subject             	o=system:nodes,cn=kubelet
  	Type                	client
  	Format              	v1alpha2

  Keypair/kubelet-api
  	Signer              	name:ca id:cn=kubernetes
  	Subject             	cn=kubelet-api
  	Type                	client
  	Format              	v1alpha2

  Keypair/master
  	AlternateNames      	[100.64.0.1, 127.0.0.1, api.ajeet.k8s.local, api.internal.ajeet.k8s.local, kubernetes, kubernetes.default, kubernetes.default.svc, kubernetes.default.svc.cluster.local]
  	Signer              	name:ca id:cn=kubernetes
  	Subject             	cn=kubernetes-master
  	Type                	server
  	Format              	v1alpha2

  LaunchConfiguration/master-us-east-1a.masters.ajeet.k8s.local
  	ImageID             	kope.io/k8s-1.9-debian-jessie-amd64-hvm-ebs-2018-03-11
  	InstanceType        	c4.large
  	SSHKey              	name:kubernetes.ajeet.k8s.local-94:24:fd:88:0c:d2:61:01:fb:fc:03:fa:4e:a2:71:a8 id:kubernetes.ajeet.k8s.local-94:24:fd:88:0c:d2:61:01:fb:fc:03:fa:4e:a2:71:a8
  	SecurityGroups      	[name:masters.ajeet.k8s.local]
  	AssociatePublicIP   	true
  	IAMInstanceProfile  	name:masters.ajeet.k8s.local id:masters.ajeet.k8s.local
  	RootVolumeSize      	64
  	RootVolumeType      	gp2
  	SpotPrice

  LaunchConfiguration/nodes.ajeet.k8s.local
  	ImageID             	kope.io/k8s-1.9-debian-jessie-amd64-hvm-ebs-2018-03-11
  	InstanceType        	t2.medium
  	SSHKey              	name:kubernetes.ajeet.k8s.local-94:24:fd:88:0c:d2:61:01:fb:fc:03:fa:4e:a2:71:a8 id:kubernetes.ajeet.k8s.local-94:24:fd:88:0c:d2:61:01:fb:fc:03:fa:4e:a2:71:a8
  	SecurityGroups      	[name:nodes.ajeet.k8s.local]
  	AssociatePublicIP   	true
  	IAMInstanceProfile  	name:nodes.ajeet.k8s.local id:nodes.ajeet.k8s.local
  	RootVolumeSize      	128
  	RootVolumeType      	gp2
  	SpotPrice

  LoadBalancer/api.ajeet.k8s.local
  	LoadBalancerName    	api-ajeet-k8s-local-chl4vq
  	Subnets             	[name:us-east-1a.ajeet.k8s.local]
  	SecurityGroups      	[name:api-elb.ajeet.k8s.local]
  	Listeners           	{443: {"InstancePort":443}}
  	HealthCheck         	{"Target":"SSL:443","HealthyThreshold":2,"UnhealthyThreshold":2,"Interval":10,"Timeout":5}
  	ConnectionSettings  	{"IdleTimeout":300}

  LoadBalancerAttachment/api-master-us-east-1a
  	LoadBalancer        	name:api.ajeet.k8s.local id:api.ajeet.k8s.local
  	AutoscalingGroup    	name:master-us-east-1a.masters.ajeet.k8s.local id:master-us-east-1a.masters.ajeet.k8s.local

  ManagedFile/ajeet.k8s.local-addons-bootstrap
  	Location            	addons/bootstrap-channel.yaml

  ManagedFile/ajeet.k8s.local-addons-core.addons.k8s.io
  	Location            	addons/core.addons.k8s.io/v1.4.0.yaml

  ManagedFile/ajeet.k8s.local-addons-dns-controller.addons.k8s.io-k8s-1.6
  	Location            	addons/dns-controller.addons.k8s.io/k8s-1.6.yaml

  ManagedFile/ajeet.k8s.local-addons-dns-controller.addons.k8s.io-pre-k8s-1.6
  	Location            	addons/dns-controller.addons.k8s.io/pre-k8s-1.6.yaml

  ManagedFile/ajeet.k8s.local-addons-kube-dns.addons.k8s.io-k8s-1.6
  	Location            	addons/kube-dns.addons.k8s.io/k8s-1.6.yaml

  ManagedFile/ajeet.k8s.local-addons-kube-dns.addons.k8s.io-pre-k8s-1.6
  	Location            	addons/kube-dns.addons.k8s.io/pre-k8s-1.6.yaml

  ManagedFile/ajeet.k8s.local-addons-limit-range.addons.k8s.io
  	Location            	addons/limit-range.addons.k8s.io/v1.5.0.yaml

  ManagedFile/ajeet.k8s.local-addons-rbac.addons.k8s.io-k8s-1.8
  	Location            	addons/rbac.addons.k8s.io/k8s-1.8.yaml

  ManagedFile/ajeet.k8s.local-addons-storage-aws.addons.k8s.io-v1.6.0
  	Location            	addons/storage-aws.addons.k8s.io/v1.6.0.yaml

  ManagedFile/ajeet.k8s.local-addons-storage-aws.addons.k8s.io-v1.7.0
  	Location            	addons/storage-aws.addons.k8s.io/v1.7.0.yaml

  Route/0.0.0.0/0
  	RouteTable          	name:ajeet.k8s.local
  	CIDR                	0.0.0.0/0
  	InternetGateway     	name:ajeet.k8s.local

  RouteTable/ajeet.k8s.local
  	VPC                 	name:ajeet.k8s.local
  	Shared              	false
  	Tags                	{Name: ajeet.k8s.local, KubernetesCluster: ajeet.k8s.local, kubernetes.io/cluster/ajeet.k8s.local: owned, kubernetes.io/kops/role: public}

  RouteTableAssociation/us-east-1a.ajeet.k8s.local
  	RouteTable          	name:ajeet.k8s.local
  	Subnet              	name:us-east-1a.ajeet.k8s.local

  SSHKey/kubernetes.ajeet.k8s.local-94:24:fd:88:0c:d2:61:01:fb:fc:03:fa:4e:a2:71:a8
  	KeyFingerprint      	d2:82:fc:e0:85:7a:89:e3:6a:59:ae:e7:73:50:e1:8e

  Secret/admin

  Secret/kube

  Secret/kube-proxy

  Secret/kubelet

  Secret/system:controller_manager

  Secret/system:dns

  Secret/system:logging

  Secret/system:monitoring

  Secret/system:scheduler

  SecurityGroup/api-elb.ajeet.k8s.local
  	Description         	Security group for api ELB
  	VPC                 	name:ajeet.k8s.local
  	RemoveExtraRules    	[port=443]
  	Tags                	{kubernetes.io/cluster/ajeet.k8s.local: owned, Name: api-elb.ajeet.k8s.local, KubernetesCluster: ajeet.k8s.local}

  SecurityGroup/masters.ajeet.k8s.local
  	Description         	Security group for masters
  	VPC                 	name:ajeet.k8s.local
  	RemoveExtraRules    	[port=22, port=443, port=2380, port=2381, port=4001, port=4002, port=4789, port=179]
  	Tags                	{Name: masters.ajeet.k8s.local, KubernetesCluster: ajeet.k8s.local, kubernetes.io/cluster/ajeet.k8s.local: owned}

  SecurityGroup/nodes.ajeet.k8s.local
  	Description         	Security group for nodes
  	VPC                 	name:ajeet.k8s.local
  	RemoveExtraRules    	[port=22]
  	Tags                	{Name: nodes.ajeet.k8s.local, KubernetesCluster: ajeet.k8s.local, kubernetes.io/cluster/ajeet.k8s.local: owned}

  SecurityGroupRule/all-master-to-master
  	SecurityGroup       	name:masters.ajeet.k8s.local
  	SourceGroup         	name:masters.ajeet.k8s.local

  SecurityGroupRule/all-master-to-node
  	SecurityGroup       	name:nodes.ajeet.k8s.local
  	SourceGroup         	name:masters.ajeet.k8s.local

  SecurityGroupRule/all-node-to-node
  	SecurityGroup       	name:nodes.ajeet.k8s.local
  	SourceGroup         	name:nodes.ajeet.k8s.local

  SecurityGroupRule/api-elb-egress
  	SecurityGroup       	name:api-elb.ajeet.k8s.local
  	CIDR                	0.0.0.0/0
  	Egress              	true

  SecurityGroupRule/https-api-elb-0.0.0.0/0
  	SecurityGroup       	name:api-elb.ajeet.k8s.local
  	CIDR                	0.0.0.0/0
  	Protocol            	tcp
  	FromPort            	443
  	ToPort              	443

  SecurityGroupRule/https-elb-to-master
  	SecurityGroup       	name:masters.ajeet.k8s.local
  	Protocol            	tcp
  	FromPort            	443
  	ToPort              	443
  	SourceGroup         	name:api-elb.ajeet.k8s.local

  SecurityGroupRule/master-egress
  	SecurityGroup       	name:masters.ajeet.k8s.local
  	CIDR                	0.0.0.0/0
  	Egress              	true

  SecurityGroupRule/node-egress
  	SecurityGroup       	name:nodes.ajeet.k8s.local
  	CIDR                	0.0.0.0/0
  	Egress              	true

  SecurityGroupRule/node-to-master-tcp-1-2379
  	SecurityGroup       	name:masters.ajeet.k8s.local
  	Protocol            	tcp
  	FromPort            	1
  	ToPort              	2379
  	SourceGroup         	name:nodes.ajeet.k8s.local

  SecurityGroupRule/node-to-master-tcp-2382-4000
  	SecurityGroup       	name:masters.ajeet.k8s.local
  	Protocol            	tcp
  	FromPort            	2382
  	ToPort              	4000
  	SourceGroup         	name:nodes.ajeet.k8s.local

  SecurityGroupRule/node-to-master-tcp-4003-65535
  	SecurityGroup       	name:masters.ajeet.k8s.local
  	Protocol            	tcp
  	FromPort            	4003
  	ToPort              	65535
  	SourceGroup         	name:nodes.ajeet.k8s.local

  SecurityGroupRule/node-to-master-udp-1-65535
  	SecurityGroup       	name:masters.ajeet.k8s.local
  	Protocol            	udp
  	FromPort            	1
  	ToPort              	65535
  	SourceGroup         	name:nodes.ajeet.k8s.local

  SecurityGroupRule/ssh-external-to-master-0.0.0.0/0
  	SecurityGroup       	name:masters.ajeet.k8s.local
  	CIDR                	0.0.0.0/0
  	Protocol            	tcp
  	FromPort            	22
  	ToPort              	22

  SecurityGroupRule/ssh-external-to-node-0.0.0.0/0
  	SecurityGroup       	name:nodes.ajeet.k8s.local
  	CIDR                	0.0.0.0/0
  	Protocol            	tcp
  	FromPort            	22
  	ToPort              	22

  Subnet/us-east-1a.ajeet.k8s.local
  	VPC                 	name:ajeet.k8s.local
  	AvailabilityZone    	us-east-1a
  	CIDR                	172.20.32.0/19
  	Shared              	false
  	Tags                	{SubnetType: Public, Name: us-east-1a.ajeet.k8s.local, KubernetesCluster: ajeet.k8s.local, kubernetes.io/cluster/ajeet.k8s.local: owned, kubernetes.io/role/elb: 1}

  VPC/ajeet.k8s.local
  	CIDR                	172.20.0.0/16
  	EnableDNSHostnames  	true
  	EnableDNSSupport    	true
  	Shared              	false
  	Tags                	{Name: ajeet.k8s.local, KubernetesCluster: ajeet.k8s.local, kubernetes.io/cluster/ajeet.k8s.local: owned}

  VPCDHCPOptionsAssociation/ajeet.k8s.local
  	VPC                 	name:ajeet.k8s.local
  	DHCPOptions         	name:ajeet.k8s.local

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

