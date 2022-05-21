
# Manage Your Kubernetes Cluster on AWS using Kops running on Docker Desktop for MacOS

Kops refers to Kubernetes Operations. It is a set of tools for installing, operating, and deleting Kubernetes clusters in the cloud. A rolling upgrade of an older version of Kubernetes to a new version can also be performed. It also manages the cluster add-ons. After the cluster is created, the usual kubectl CLI can be used to manage resources in the cluster.

Under this tutorial, I will showcase how Kubernetes Cluster can be deployed and Managed using Kops via Docker Desktop for Mac.

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Docker Desktop for MacOS </b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisites:

- Docker Desktop for Mac 
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


```
bucket_name=collabstore
```


## Create a AWS Bucket
```
[Captains-Bay]🚩 >  baws s3api create-bucket --bucket ${bucket_name} --region us-east-1
{
    "Location": "/collabstore"
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
export KOPS_CLUSTER_NAME=ajeet.k8s.local
```

## Export Cluster Name


```
export KOPS_CLUSTER_NAME=ajeet.k8s.local
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
 * edit your node instance group: kops edit ig --name=ajeet.k8s.local nodes
 * edit your master instance group: kops edit ig --name=ajeet.k8s.local master-us-east-1a

Finally configure your cluster with: kops update cluster ajeet.k8s.local --yes

[Captains-Bay]🚩 >
```


```
[Captains-Bay]🚩 >  kops get cluster
NAME		CLOUD	ZONES
ajeet.k8s.local	aws	us-east-1a
[Captains-Bay]🚩 >
```


## Deploy Kubernetes

```
kops update cluster --name ${KOPS_CLUSTER_NAME} --yes
```


```
kops get cluster
NAME				CLOUD	ZONES
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

![My image](https://github.com/collabnix/dockerlabs/blob/master/os/macOS/aws/context-aws.png)


## Contributor

[Ajeet S Raina](ajeetraina@gmail.com)



