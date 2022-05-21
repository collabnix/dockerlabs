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

## Listing

```
[manager3] (local) root@192.168.0.11 ~/.aws$ docker-machine ls
NAME                 ACTIVE   DRIVER      STATE     URL                         SWARM   DOCKER        ERRORS
demo-swarm-manager   -        amazonec2   Running   tcp://54.215.195.160:2376           v18.05.0-ce
demo-swarm-worker1   -        amazonec2   Running   tcp://54.183.226.18:2376            v18.05.0-ce
demo-swarm-worker2   -        amazonec2   Running   tcp://52.53.167.110:2376            v18.05.0-ce
[manager3] (local) root@192.168.0.11 ~/.aws
$
```

```
       valid_lft forever preferred_lft forever
ubuntu@demo-swarm-manager:~$ sudo docker swarm init --advertise-addr 172.31.0.39
Swarm initialized: current node (7chtnb3mvh16hi00em7xwvwdh) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-0co3iy3e6q5luadad3plkus44hihfodzlnr0l52fywl6wwntmz-cwqu225oucj1zr82ytgzuqfg6 172.31.0.39:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

```

# THIS WON"T WORK UNLESS YOU PERFORM BELOW STEP-

```

$ aws configure
AWS Access Key ID [****************OTEA]:
AWS Secret Access Key [****************kRHC]: 
Default region name [us-west-1c]: us-west-1
Default output format [None]:

## We will need security group

```
$ SECURITY_GROUP_ID=sg- #Copy the group id here
```



[manager3] (local) root@192.168.0.11 ~/.aws$ aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 2377 --source-g
roup $SECURITY_GROUP_ID
[manager3] (local) root@192.168.0.11 ~/.aws
$ ^C
```
## Allowing Port

```
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 7946 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol udp --port 7946 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 4789 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol udp --port 4789 --source-group $SECURITY_GROUP_ID
```

## 

```
ubuntu@demo-swarm-worker1:~$ sudo docker swarm join --token SWMTKN-1-0co3iy3e6q5luadad3plkus44hihfodzlnr0l52fywl6wwntmz-cwqu225oucj1zr82ytgzuqfg6 172.31.0.39:2377
This node joined a swarm as a worker.ubuntu@demo-swarm-worker1:~$

```

## Our 3-Node Swarm Cluster is Ready

```
ubuntu@demo-swarm-manager:~$ sudo docker node lsID                            HOSTNAME             STATUS              AVAILABILITY        MANAGER STATUS ENGINE VERSION7chtnb3mvh16hi00em7xwvwdh *   demo-swarm-manager   Ready               Active              Leader 18.05.0-ce
uxs3aq57y1bm5mdtsi8z1ovrx     demo-swarm-worker1   Ready               Active 18.05.0-ce
rcdb3bozljhvn4epjmu4jvjt7     demo-swarm-worker2   Ready               Active 18.05.0-ce
ubuntu@demo-swarm-manager:~$
```



## Reference:
```
https://gist.github.com/ghoranyi/f2970d6ab2408a8a37dbe8d42af4f0a5
```






