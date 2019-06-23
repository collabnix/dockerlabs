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

## 

```
sudo apt-get update && sudo apt-get install -y apt-transport-https curl 
```



