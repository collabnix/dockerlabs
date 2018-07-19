#

Steps:

- Install Hashicorp's Terraform

```
$ wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_darwin_amd64.zip
$ unzip terraform_0.11.7_darwin_amd64.zip -d /usr/local/terraform
```

```
terraform version
Terraform v0.11.7
+ provider.google v1.16.2
```

- Install Google Cloud SDK

```
curl https://sdk.cloud.google.com | bash
```

```
gcloud init
```

## Initialize Terraform

```
terraform init
terraform plan
terraform apply
```

# Done.
