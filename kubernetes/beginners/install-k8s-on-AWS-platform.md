# Installing Kubernetes on AWS Platform from Scratch

## Pre-requisite:

- AWS Free Tier Account
- Create 2 Ubuntu 18.04 Instance (1 Master and 1 Worker Node)
- Create Key Pair by name "myubuntu"
- Assign the proper permission

```
chmod 400 myubuntu.pem
```


## Connect to Master Node via your Mac.(If you are using Windows, ensure that OpenSSH is installed)


```
ssh -i "myubuntu.pem" ubuntu@ec2-34-220-163-78.us-west-2.compute.amazonaws.com
```

## Executing the script to install Kubernetes Cluster

```
sh prepare-kube.sh
sh install-kube.sh
```

## Install Docker 

```
curl -sSL https://get.docker.com/ | sh
```

##







