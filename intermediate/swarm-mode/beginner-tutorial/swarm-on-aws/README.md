# Apache Kafka on 2-Node Docker Swarm Mode Cluster running on Amazon EC2 Instance

Apache Kafka is a distributed, partitioned, and replicated publish-subscribe messaging system that is used to send high volumes of data, in the form of messages, from one point to another. Kafka replicates these messages across a cluster of servers in order to prevent data loss and allows both online and offline message consumption. This in turn shows the fault-tolerant behavior of Kafka in the presence of machine failures that also supports low latency message delivery. In a broader sense, Kafka is considered as a unified platform which guarantees zero data loss and handles real-time data feeds. In order to understand the functionality of Kafka, there are few methodologies that need to be discussed before moving deep into the architecture. A stream of messages is divided into particular categories called topics. These messages are published to specific topics using dedicated processes which we call producers. A separate set of processes called consumers are used to pull data from the brokers by subscribing to one or more topics. At a high level, we can say that the producers send messages to the Kafka cluster which then consumed by the consumers [16]. Kafka has the following benefits.

- Durability: Kafka allows messages to persist on the disk in order to prevent data loss. It uses distributed commit log for replicating messages across the cluster, and thus making it a durable system.
- Scalability: It can easily be expanded without any downtime. Since a single Kafka cluster is acting as a central backbone for handling the large organization, we can elastically spread it to multiple clusters.
- Reliability: It is reliable over time, as it is considered as a distributed, repli- cated, and fault tolerant messaging system.
- Efficiency: Kafka publishes and subscribes messages efficiently which shows high system throughput. It can store terabytes of messages without any performance impact.

The overall architecture of Kafka is shown above. It is composed of three server machines which together act as a cluster computing platform. In a typical Kafka cluster, each server is configured to behave as a single broker system that shows the persistence and replication of message data. In other words, we can say that there is more than one broker in a typical Kafka cluster. Essentially, broker is the key component of Kafka cluster which is basically responsible for maintaining published data. Each broker instance can easily handle thousands of reads and writes per topic, as they have a stateless behavior. At a basic level, Kafka broker uses topics to handle message data. The topic is first created and then divided into multiple partitions in order to balance load. Figure 2.8 illustrates the basic concept of topic which is divided into three partitions. Each partition has multiple offsets in which messages are stored. As an example, suppose that the topic has a replication factor of value ‘3’, then Kafka will create three identical replicas of each partition regarding the topic and distribute them across the cluster. In order to balance load and maintaining data replication, each broker stores one or more partition replicas. Suppose that there are N brokers and N number of partitions then each broker will store one partition.

Moreover, Kafka uses Zookeeper to maintain cluster state. Zookeeper is a syn- chronization and coordination service for managing Kafka brokers and its main functionality is to perform leader election across multiple broker instances. It will be described in detail in Section 2.3.2. As can be seen from Figure 2.7 that one server acts as a leader and the other two servers act as followers. Leader node handles all reads and writes per partition. Follower node just follows the instructions given by the leader node. If the leader fails, then the follower node will be automatically appointed as a new leader.

Furthermore, Kafka uses producer applications to send data to the topics of their choice. Producers send data to the brokers which then append messages at the end of the topic queue. Whenever a new broker started, the producers automatically send messages to this new broker. Each producer has two choices to publish data to the partition; they can either select the partitions randomly or they can semantically use the partitioning key and function to determine specific partitions. In order to pull data from brokers, Kafka uses consumer applications. The consumers maintain offset value which shows the number of messages being consumed. Each broker is listening for an asynchronous pull request from the consumers and then update the buffer bytes to be consumed next. Kafka also offers a single abstraction called consumer group which consists of one or more consumers having the same group id and name as well. All groups are used to jointly consume messages by first subscribing to a particular topic and each message is delivered to only one consumer instance within a subscribed group. This shows the load balancing nature among the consumers and the coordination overhead is also neglected.






## Adding Your Credentials:

```
[Captains-Bay]🚩 >  cat ~/.aws/credentials
[default]
aws_access_key_id = XXXA 
aws_secret_access_key = XX
```

## Verifying AWS Version

```
[Captains-Bay]🚩 >  aws --version
aws-cli/1.11.107 Python/2.7.10 Darwin/17.7.0 botocore/1.5.70
```

## Setting up Environmental Variable

```
[Captains-Bay]🚩 >  export VPC=vpc-ae59f0d6
[Captains-Bay]🚩 >  export REGION=us-west-2a
[Captains-Bay]🚩 >  export SUBNET=subnet-827651c9
[Captains-Bay]🚩 >  export ZONE=a
[Captains-Bay]🚩 >  export REGION=us-west-2
```


```
[Captains-Bay]🚩 >  vi ~/.aws/credentials 
[Captains-Bay]🚩 >  docker-machine create  --driver amazonec2  --amazonec2-access-key=${ACCESS_KEY_ID}  --amazonec2-secret-key=${SECRET_ACCESS_KEY} --amazonec2-region=us-west-2 --amazonec2-vpc-id=vpc-ae59f0d6 --amazonec2-ami=ami-78a22900 --amazonec2-instance-type=t2.micro kafka-swarm-node1
```

## Listing out the Nodes

```
[Captains-Bay]🚩 >  docker-machine ls
NAME                ACTIVE   DRIVER      STATE     URL                         SWARM   DOCKER     ERRORS
kafka-swarm-node1   -        amazonec2   Running   tcp://35.161.106.158:2376           v18.09.6   
kafka-swarm-node2   -        amazonec2   Running   tcp://54.201.99.75:2376             v18.09.6 
```

## Initialiating Docker Swarm Manager Node

```
ubuntu@kafka-swarm-node1:~$ sudo docker swarm init --advertise-addr 172.31.53.71 --listen-addr 172.31.53.71:2377
Swarm initialized: current node (yui9wqfu7b12hwt4ig4ribpyq) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-2xjkynhin0n2zl7i1r9wjc4of36b4iw6g7b4odimr075to2v3k-decb975h5g5da7rd34qvilxen 172.31.53.71:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

## Adding Worker Node

```
ubuntu@kafka-swarm-node2:~$ sudo docker swarm join --token SWMTKN-1-2xjkynhin0n2zl7i1r9wjc4of36b4iw6g7b4odimr075to2v3k-decb975h5g5da7rd34qvilxen 172.31.53.71:2377
This node joined a swarm as a worker.
```

## Verifying 2-Node Docker Swarm Mode Cluster

```
ubuntu@kafka-swarm-node1:~$ sudo docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
yui9wqfu7b12hwt4ig4ribpyq *   kafka-swarm-node1   Ready               Active              Leader              18.09.6
vb235xtkejim1hjdnji5luuxh     kafka-swarm-node2   Ready               Active                                  18.09.6
```

## Installing Docker Compose

```
root@kafka-swarm-node1:/home/ubuntu/dockerlabs/solution/kafka-swarm# curl -L https://github.com/docker/compose/releases/download/1.25.0-rc1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   617    0   617    0     0   2212      0 --:--:-- --:--:-- --:--:--  2211
100 15.5M  100 15.5M    0     0  8693k      0  0:00:01  0:00:01 --:--:-- 20.1M
root@kafka-swarm-node1:/home/ubuntu/dockerlabs/solution/kafka-swarm# chmod +x /usr/local/bin/docker-compose
root@kafka-swarm-node1:/home/ubuntu/dockerlabs/solution/kafka-swarm# exit
exit
ubuntu@kafka-swarm-node1:~/dockerlabs/solution/kafka-swarm$ sudo docker-compose version
docker-compose version 1.25.0-rc1, build 8552e8e2
docker-py version: 4.0.1
CPython version: 3.7.3
OpenSSL version: OpenSSL 1.1.0j  20 Nov 2018
```

## Building up Kafka Application

```
ubuntu@kafka-swarm-node1:~/dockerlabs/solution/kafka-swarm$ sudo docker stack deploy -c docker-compose.yml mykafka
Creating network mykafka_default
Creating service mykafka_zkui
Creating service mykafka_broker
Creating service mykafka_manager
Creating service mykafka_producer
Creating service mykafka_zookeeper
ubuntu@kafka-swarm-node1:~/dockerlabs/solution/kafka-swarm$
```

## Verifying Apache Kafka Stack

```
ubuntu@kafka-swarm-node1:~/dockerlabs/solution/kafka-swarm$ sudo docker stack lsNAME                SERVICES            ORCHESTRATOR
mykafka             5                   Swarm
```

## Verifying Apache Kafka Services

```
ubuntu@kafka-swarm-node1:~/dockerlabs/solution/kafka-swarm$ sudo docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE                                                                                     PORTS
t04p6i8zky4z        mykafka_broker      replicated          0/3                 qnib/plain-kafka:2018-04-25_1.1.0                                                         *:9092->9092/tcp
r5f0x9clnwix        mykafka_manager     replicated          1/1                 qnib/plain-kafka-manager:2018-04-25                                                       *:9000->9000/tcp
jzwvrt4df66b        mykafka_producer    replicated          3/3                 qnib/golang-kafka-producer:2018-05-01.12                                                  
09lkbevsktt9        mykafka_zkui        replicated          1/1                 qnib/plain-zkui@sha256:30c4aa1236ee90e4274a9059a5fa87de2ee778d9bfa3cb48c4c9aafe7cfa1a13   *:9090->9090/tcp
b1hqfk1vc4lu        mykafka_zookeeper   replicated          1/1                 qnib/plain-zookeeper:2018-04-25                                                           *:2181->2181/tcp
ubuntu@kafka-swarm-node1:~/dockerlabs/solution/kafka-swarm$ 
```


