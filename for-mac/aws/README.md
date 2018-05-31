
# Using Docker Stack Deploy to deploy Microservices on AWS CLuster using Docker for Mac

Pre-requisites:

- Docker for Mac 17.12+
- Install AWS CLI using ```brew install aws```
- Create an AWS Account if you are first time user.
- Run the below command to install kops on your macOS:

```
brew update && brew install kops
```

## Adding Access & Secret Key 


```
aws configure
```

This will store your credential under ~/.aws/credentials




## Create a AWS Bucket
```
aws s3api create-bucket --bucket ${bucket_name} --region us-east-1
{
    "Location": "/ajeet-kops-state-store"
}
```

## Configure

```
aws s3api put-bucket-versioning --bucket ${bucket_name} --versioning-configuration Status=Enabled
```


## Configure DNS Name

```
 aws route53 create-hosted-zone --name collabnix.com --caller-reference 2
 
```

```
export KOPS_CLUSTER_NAME=k8.aws.dev.collabnix.com
```

## Export Cluster Name


```
export KOPS_CLUSTER_NAME=k8.aws.dev.collabnix.com
```

## Exporting Kops State Store

```
[Captains-Bay]🚩 >  export KOPS_STATE_STORE=s3://${bucket_name}
```



```
[Captains-Bay]🚩 >  kops create cluster \
> --node-count=2 \
> --node-size=t2.medium \
> --zones=us-east-1a \
> --name=${KOPS_CLUSTER_NAME}
...

Must specify --yes to apply changes

Cluster configuration has been created.

Suggestions:
 * list clusters with: kops get cluster
 * edit this cluster with: kops edit cluster k8.aws.dev.collabnix.com
 * edit your node instance group: kops edit ig --name=k8.aws.dev.collabnix.com nodes
 * edit your master instance group: kops edit ig --name=k8.aws.dev.collabnix.com master-us-east-1a

Finally configure your cluster with: kops update cluster k8.aws.dev.collabnix.com --yes

[Captains-Bay]🚩 >
```

## Deploy Kubernetes

```
kops update cluster --name ${KOPS_CLUSTER_NAME} --yes
```


```
kops get cluster
NAME				CLOUD	ZONES
k8.aws.dev.collabnix.com	aws	us-east-1a
[Captains-Bay]🚩 >
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

![My image](https://github.com/ajeetraina/docker101/blob/master/for-mac/aws/context-aws.png)



