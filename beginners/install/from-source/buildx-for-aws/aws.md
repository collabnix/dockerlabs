# Running Docker Containers on AWS ARM A1 Instance built using New Docker CLI Plugin "buildx" on Docker Desktop


## Pre-requisites:

-  Open up https://beta.docker.com page and it will ask to register for public beta as shown below:

![My Image](https://github.com/collabnix/dockerlabs/blob/master/beginners/install/from-source/buildx-for-aws/a001.png)


- Click on "Register for Public Beta". This will open up various options to test drive Docker products

![My Image](https://github.com/collabnix/dockerlabs/blob/master/beginners/install/from-source/buildx-for-aws/a002.png)


- Don't forget to Select "Docker Desktop CE with Multi-Arch images (Arm Enabled) - Edge Release Amazon Cloud Credits available for limited time" option.
- Enter your details and this will open. 
- You will see an option to sign up for credits for Amazon EC2 A1 instances via https://www.surveymonkey.com/r/DockerCon19AWS. 
- Click on Sign Up

## Creating AWS Account


- Go to aws.amazon.com and create Free Tier Accounts
- You must have received email from Amazon on Free Credits of $50. 
- Open up https://aws.amazon.com/amazoncredits and add this Promo Code

## Creating AWS A1 Instance 

We will use Docker Desktop for Windows which comes installed with Docker Machine to bring up ARM instances quickly.

Run the below command:

```
PS C:\Users\Ajeet_Raina> set ACCESS_KEY_ID=XXX
PS C:\Users\Ajeet_Raina> set SECRET_ACCESS_KEY=XX
```

## Running Docker Machine to bring up our first Docker Node on AWS A1 ARM instance 

```
PS C:\Users\Ajeet_Raina> docker-machine create  --driver amazonec2  --amazonec2-access-key=${ACCESS_KEY_ID}  --amazonec2-secret-key=${SECRET_ACCESS_KEY} --amazonec2-region=us-west-2 --amazon
ec2-vpc-id=vpc-ae59f0d6 --amazonec2-ami=ami-0db180c518750ee4f  --amazonec2-instance-type=a1.medium arm-node1
```

## Listing out the ARM Nodes

```
PS C:\Users\Ajeet_Raina> docker-machine ls
NAME        ACTIVE   DRIVER      STATE     URL                         SWARM   DOCKER     ERRORS
arm-node1   -        amazonec2   Running   tcp://34.218.208.175:2376           v18.09.6
PS C:\Users\Ajeet_Raina>
```

## Login into the first Node

```
PS C:\Users\Ajeet_Raina> docker-machine ssh arm-node1
Welcome to Ubuntu 18.04.1 LTS (GNU/Linux 4.15.0-1028-aws aarch64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu May 16 04:35:16 UTC 2019

  System load:  0.06              Processes:              116
  Usage of /:   9.1% of 15.34GB   Users logged in:        0
  Memory usage: 10%               IP address for ens5:    172.31.60.52
  Swap usage:   0%                IP address for docker0: 172.17.0.1


  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

178 packages can be updated.
86 updates are security updates.
```

This node comes with Docker 18.09.6 installed.

```
ubuntu@arm-node1:~$ docker version
Client:
 Version:           18.09.6
 API version:       1.39
 Go version:        go1.10.8
 Git commit:        481bc77
 Built:             Sat May  4 02:40:48 2019
 OS/Arch:           linux/arm64
 Experimental:      false
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.so
 connect: permission denied
ubuntu@arm-node1:~$ sudo docker version
Client:
 Version:           18.09.6
 API version:       1.39
 Go version:        go1.10.8
 Git commit:        481bc77
 Built:             Sat May  4 02:40:48 2019
 OS/Arch:           linux/arm64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.6
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.8
  Git commit:       481bc77
  Built:            Sat May  4 02:00:10 2019
  OS/Arch:          linux/arm64
  Experimental:     false
ubuntu@arm-node1:~$
```

# Checking the Node IP

```
PS C:\Users\Ajeet_Raina> docker-machine ip arm-node1
34.218.208.175
```

# Creating Swarm Worker Nodes

```
PS C:\Users\Ajeet_Raina> docker-machine create  --driver amazonec2  --amazonec2-access-key=${ACCESS_KEY_ID}  --amazonec2-secret-key=${SECRET_ACCESS_KEY} --amazonec2-region=us-west-2 --amazon
ec2-vpc-id=vpc-ae59f0d6 --amazonec2-ami=ami-0db180c518750ee4f  --amazonec2-instance-type=a1.medium arm-node2
```

```
PS C:\Users\Ajeet_Raina> docker-machine create  --driver amazonec2  --amazonec2-access-key=${ACCESS_KEY_ID}  --amazonec2-secret-key=${SECRET_ACCESS_KEY} --amazonec2-region=us-west-2 --amazon
ec2-vpc-id=vpc-ae59f0d6 --amazonec2-ami=ami-0db180c518750ee4f  --amazonec2-instance-type=a1.medium arm-node3
```

## Initiating Docker Swarm Cluster

Identify Security Group from your instance

```
$ SECURITY_GROUP_ID=sg- #Copy the group id here
$ aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 2377 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 7946 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol udp --port 7946 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 4789 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol udp --port 4789 --source-group $SECURITY_GROUP_ID
```

## Joining Worker Nodes




## Method:2

There is a manual way to create instance if you're new to Docker Machine

- Go to Create Instance under EC2(shown below)

![My Image](https://github.com/collabnix/dockerlabs/blob/master/beginners/install/from-source/buildx-for-aws/a003.png)


- Select Ubuntu 18.04 64-bit ARM Type Instance

![My Image](https://github.com/collabnix/dockerlabs/blob/master/beginners/install/from-source/buildx-for-aws/a004.png)


- Choose the right size of instance as per Free Tier Account

![My Image](https://github.com/collabnix/dockerlabs/blob/master/beginners/install/from-source/buildx-for-aws/a005.png)


- Bring up Instance

![My Image](https://github.com/collabnix/dockerlabs/blob/master/beginners/install/from-source/buildx-for-aws/a007.png)


## Logging into AWS A1 Instance

You can use Putty to login into this A1 instance with the right .PEM file uploaded under Putty > Connections > SSH > Auth.
Or you can run the below command on Your Linux system:

```
[root@ki ~]# chmod 400 a1instance.pem
[root@ki ~]# ssh -i "a1instance.pem" ubuntu@ec2-52-35-234-202.us-west-2.compute.amazonaws.com
The authenticity of host 'ec2-52-35-234-202.us-west-2.compute.amazonaws.com (52.35.234.202)' can't be established.
ECDSA key fingerprint is a4:3d:e4:c4:5d:79:94:aa:32:aa:c0:5d:74:03:67:d0.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'ec2-52-35-234-202.us-west-2.compute.amazonaws.com,52.35.234.202' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 18.04.1 LTS (GNU/Linux 4.15.0-1028-aws aarch64)

```

## Verifying the correct System Architecture


```
ubuntu@ip-172-31-62-91:~$ dpkg --print-architecture
arm64
```

## Configure VPC 

We will be setting up VPC so as to allow ports to be accessible from outside world. At the end of this blog post, we will see how to setup Portainer on A1 Instance.

Method: 1 - Manual 

## Installing Docker 19.03.0

```
ubuntu@ip-172-31-62-91:~$ curl -sSL https://test.docker.com/ | ^C
ubuntu@ip-172-31-62-91:~$ curl -fsSL https://test.docker.com -o test-docker.sh | sh
ubuntu@ip-172-31-62-91:~$ sh test-docker.sh
# Executing docker install script, commit: 2f4ae48
+ sudo -E sh -c apt-get update -qq >/dev/null
+ sudo -E sh -c apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
+ sudo -E sh -c curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add -qq - >/dev/null
Warning: apt-key output should not be parsed (stdout is not a terminal)
+ sudo -E sh -c echo "deb [arch=arm64] https://download.docker.com/linux/ubuntu bionic test" > /etc/apt/sources.list.d/docker.list
+ sudo -E sh -c apt-get update -qq >/dev/null
+ [ -n  ]
+ sudo -E sh -c apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
+ sudo -E sh -c docker version
Client:
 Version:           19.03.0-beta3
 API version:       1.40
 Go version:        go1.12.4
 Git commit:        c55e026
 Built:             Thu Apr 25 03:08:03 2019
 OS/Arch:           linux/arm64
 Experimental:      false

Server:
 Engine:
  Version:          19.03.0-beta3
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.4
  Git commit:       c55e026
  Built:            Thu Apr 25 03:06:36 2019
  OS/Arch:          linux/arm64
  Experimental:     false
 containerd:
  Version:          1.2.5
  GitCommit:        bb71b10fd8f58240ca47fbb579b9d1028eea7c84
 runc:
  Version:          1.0.0-rc6+dev
  GitCommit:        2b18fe1d885ee5083ef9f0838fee39b62d653e30
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
If you would like to use Docker as a non-root user, you should now consider
adding your user to the "docker" group with something like:

  sudo usermod -aG docker ubuntu

Remember that you will have to log out and back in for this to take effect!

WARNING: Adding a user to the "docker" group will grant the ability to run
         containers which can be used to obtain root privileges on the
         docker host.
         Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
         for more information.
```

```
ubuntu@ip-172-31-62-91:~$ sudo docker version
Client:
 Version:           19.03.0-beta3
 API version:       1.40
 Go version:        go1.12.4
 Git commit:        c55e026
 Built:             Thu Apr 25 03:08:03 2019
 OS/Arch:           linux/arm64
 Experimental:      false

Server:
 Engine:
  Version:          19.03.0-beta3
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.4
  Git commit:       c55e026
  Built:            Thu Apr 25 03:06:36 2019
  OS/Arch:          linux/arm64
  Experimental:     false
 containerd:
  Version:          1.2.5
  GitCommit:        bb71b10fd8f58240ca47fbb579b9d1028eea7c84
 runc:
  Version:          1.0.0-rc6+dev
  GitCommit:        2b18fe1d885ee5083ef9f0838fee39b62d653e30
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
```

## Creating Docker Swarm Cluster

```
ubuntu@ip-172-31-62-91:~$ sudo docker swarm init --advertise-addr  172.31.62.91 --listen-addr 172.31.62.91:2377
Swarm initialized: current node (osjvbz0ry567q93vysn1ntduv) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-0fvah2dp0p32zksxnx9sqly12f8t7vobo9xjsv5p2xxnd2l80j-4w9d4jnaiq5efpcapiy5ubkli 172.31.62.91:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

## Verifying the Cluster Nodes

```
ubuntu@ip-172-31-62-91:~$ sudo docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
osjvbz0ry567q93vysn1ntduv *   ip-172-31-62-91     Ready               Active              Leader              19.03.0-beta3
```

## Running Portainer on top of AWS A1 Instance

Before we run Portainer container, we need to identify if portainer support ARM platform through another container called mplatform/mquery as shown below:

```
ubuntu@ip-172-31-62-91:~$ sudo docker run --rm mplatform/mquery portainer/portainer
Unable to find image 'mplatform/mquery:latest' locally
latest: Pulling from mplatform/mquery
db6020507de3: Pull complete
713cdc222639: Pull complete
Digest: sha256:e15189e3d6fbcee8a6ad2ef04c1ec80420ab0fdcf0d70408c0e914af80dfb107
Status: Downloaded newer image for mplatform/mquery:latest
Image: portainer/portainer
 * Manifest List: Yes
 * Supported platforms:
   - linux/amd64
   - linux/arm
   - linux/arm64
   - linux/ppc64le
   - windows/amd64:10.0.14393.2551
   - windows/amd64:10.0.16299.967
   - windows/amd64:10.0.17134.590
   - windows/amd64:10.0.17763.253
```

```
ubuntu@ip-172-31-62-91:~$ curl -L https://downloads.portainer.io/portainer-agent-stack.yml -o portainer-agent-stack.yml
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   962  100   962    0     0   5692      0 --:--:-- --:--:-- --:--:--  5692
```

```
ubuntu@ip-172-31-62-91:~$ sudo docker stack deploy --compose-file=portainer-agent-stack.yml portainer
Creating network portainer_agent_network
Creating service portainer_portainer
Creating service portainer_agent
ubuntu@ip-172-31-62-91:~$
```

```
ubuntu@ip-172-31-62-91:~$ sudo docker stack services portainer
ID                  NAME                  MODE                REPLICAS            IMAGE                        PORTS
qgejarr87g7w        portainer_agent       global              1/1                 portainer/agent:latest
y1pc7bqdybop        portainer_portainer   replicated          1/1                 portainer/portainer:latest   *:9000->9000/tcp
```


## Setting up 3-Node Swarm Cluster

```
ubuntu@ip-172-31-62-91:~$ docker swarm join-token worker
To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-0fvah2dp0p32zksxnx9sqly12f8t7vobo9xjsv5p2xxnd2l80j-4w9d4jnaiq5efpcapiy5ubkli 172.31.62.91:2377

ubuntu@ip-172-31-62-91:~$ ^C
ubuntu@ip-172-31-62-91:~$ sudo docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
8psul7qy81gocurxlw6qmf8vb     ip-172-31-50-106    Ready               Active                                  19.03.0-beta3
j6orudsoxy6rdeitxbw9aw0wh     ip-172-31-58-242    Ready               Active                                  19.03.0-beta3
osjvbz0ry567q93vysn1ntduv *   ip-172-31-62-91     Ready               Active              Leader              19.03.0-beta3
```


Method-II : Using Docker Desktop for Windows

```
PS C:\Users\Ajeet_Raina> aws configure
AWS Access Key ID [None]: AKIATSQXXXXX
AWS Secret Access Key [None]: wbq3VHDZun4OXXXXX
Default region name [None]: us-east-1
Default output format [None]:
PS C:\Users\Ajeet_Raina>
```


