# 5 Minutes to Build Your First Docker Container on Google Cloud Platform using Terraform

This provides a template for running a simple Nginx container on Google Cloud.

## Pre-requisite:

- Generate SSH keys as follows:

```sh
$ ssh-keygen -f ~/.ssh/gcloud_id_rsa
# press <Enter> when asked (twice) for a pass-phrase
```

Then [download your credentials from Google Cloud Console](https://www.terraform.io/docs/providers/google/#credentials); suggested path for downloaded file is `~/.gcloud/Terraform.json`.

Optionally update `variables.tf` to specify a default value for the `project_name` variable, and check other variables.

## Running TF

```
terraform init
terraform plan
terraform apply
```

## Verifying Nginx Container

Browse to http://<public-ip>:80
  
## Cleaning Up

```
terraform destroy
```

