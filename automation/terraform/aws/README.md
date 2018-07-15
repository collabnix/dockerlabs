# How to use Terraform for building up Infrastructure on AWS for Docker

Pre-requisite:

- Create account with aws.amazon.com
- A Ubuntu 16.04 System

## Installing Terraform

```
sudo wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip && tar xvzf terraform_0.11.7_linux_amd64.zip
```

## Cloning this Repository

```
git clone https://github.com/ajeetraina/docker101
cd docker101/automation/terraform/aws
```

## Export the Values

```
$ export TF_VAR_aws_region=us-east-1
$ export TF_VAR_aws_access_key_id=ABC123
$ export TF_VAR_aws_secret_access_key=DEF123
```

