# How to setup Docker Swarm on AWS



```
[Captains-Bay]🚩 >  cat ~/.aws/credentials
[default]
aws_access_key_id = XXXA 
aws_secret_access_key = XX
```


```
[Captains-Bay]🚩 >  aws --version
aws-cli/1.11.107 Python/2.7.10 Darwin/17.7.0 botocore/1.5.70
```

```
[Captains-Bay]🚩 >  export VPC=vpc-ae59f0d6
[Captains-Bay]🚩 >  export REGION=us-west-2a
[Captains-Bay]🚩 >  export SUBNET=subnet-827651c9
[Captains-Bay]🚩 >  export ZONE=a
[Captains-Bay]🚩 >  export REGION=us-west-2
```


```
[Captains-Bay]🚩 >  vi ~/.aws/credentials 
[Captains-Bay]🚩 >  docker-machine create -d amazonec2 --amazonec2-vpc-id $VPC --amazonec2-region $REGION --amazonec2-zone $ZONE --amazonec2-instance-type t2.micro --amazonec2-subnet-id $SUBNET --amazonec2-security-group demo-swarm demo-swarm-manager
Running pre-create checks...
Creating machine...
(demo-swarm-manager) Launching instance...
Waiting for machine to be running, this may take a few minutes...
Detecting operating system of created instance...
Waiting for SSH to be available...
Detecting the provisioner...
Provisioning with ubuntu(systemd)...
Installing Docker...
Copying certs to the local machine directory...
Copying certs to the remote machine...
Setting Docker configuration on the remote daemon...
Checking connection to Docker...
Docker is up and running!
To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env demo-swarm-manager
[Captains-Bay]🚩 >
```

