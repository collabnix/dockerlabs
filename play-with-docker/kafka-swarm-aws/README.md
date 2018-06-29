# Setting up Kafka on AWS running on 3-Node Docker Swarm Cluster

## Pre-requisite

- Create an account on AWS
- Install Docker Machine on your laptop


## Create a file "credential" under ~/.aws/credential with the below contents:

```
[default]
aws_access_key_id = AKID1234567890
aws_secret_access_key = MY-SECRET-KEY
```

## Ensure that the below info are all ready  to keep all node accessible to each other

```
$ VPC=vpc-1b9ad47c # the VPC to create your nodes in
$ REGION=us-west-1 # the region to use
$ SUBNET=subnet-57d5860c # the subnet to attach your nodes
$ ZONE=c # the zone to use
```

## Creating 3 Node Swarm Cluster

### Swarm Manager

```
docker-machine create -d amazonec2 --amazonec2-vpc-id $VPC --amazonec2-region $REGION --amazonec2-zone $ZONE --amazonec2-instance-type t2.micro --amazonec2-subnet-id $SUBNET --amazonec2-security-group demo-swarm demo-swarm-manager
```

### Swarm Worker Nodes

```

$ docker-machine create -d amazonec2 --amazonec2-vpc-id $VPC --amazonec2-region $REGION --amazonec2-zone $ZONE --amazonec2-instance-type t2.micro --amazonec2-subnet-id $SUBNET --amazonec2-security-group demo-swarm demo-swarm-worker2
$ docker-machine create -d amazonec2 --amazonec2-vpc-id $VPC --amazonec2-region $REGION --amazonec2-zone $ZONE --amazonec2-instance-type t2.micro --amazonec2-subnet-id $SUBNET --amazonec2-security-group demo-swarm demo-swarm-worker3

```



