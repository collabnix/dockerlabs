# Running Docker Images for AWS ARM A1 Instance built using New Docker CLI Plugin "buildx" on Docker Desktop


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

