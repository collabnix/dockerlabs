# How to use Terraform for building up Infrastructure on AWS for Docker

Pre-requisite:

- Create account with aws.amazon.com
- A Ubuntu 16.04 System

## Installing Terraform

```
sudo wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip && tar xvzf terraform_0.11.7_linux_amd64.zip
```

## Ensure that you make right changes for AWS credentials under main.tf file as shown below:

```
provider "aws" {
  access_key = "xxxx"
  secret_key = "xxxx"
  region     = "us-east-1"
}
resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
docker
```

## Initializing Local settings

The first command to run for a new configuration -- or after checking out an existing configuration from version control -- is terraform init, which initializes various local settings and data that will be used by subsequent commands.

```
$ sudo terraform init
Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "aws" (1.27.0)...
The following providers do not have any version constraints in configuration,
so the latest version was installed.
To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.
* provider.aws: version = "~> 1.27"
Terraform has been successfully initialized!
You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.
If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
$
```

## Applying

```
terraform apply


aws_instance.example: Creating...
  ami:                          "" => "ami-2757f631"
  associate_public_ip_address:  "" => "<computed>"
  availability_zone:            "" => "<computed>"
  ebs_block_device.#:           "" => "<computed>"
  ephemeral_block_device.#:     "" => "<computed>"
  get_password_data:            "" => "false"
  instance_state:               "" => "<computed>"
  instance_type:                "" => "t2.micro"
  ipv6_address_count:           "" => "<computed>"
  ipv6_addresses.#:             "" => "<computed>"
  key_name:                     "" => "<computed>"
  network_interface.#:          "" => "<computed>"
  network_interface_id:         "" => "<computed>"
  password_data:                "" => "<computed>"
  placement_group:              "" => "<computed>"
  primary_network_interface_id: "" => "<computed>"
  private_dns:                  "" => "<computed>"
  private_ip:                   "" => "<computed>"
  public_dns:                   "" => "<computed>"
  public_ip:                    "" => "<computed>"
  root_block_device.#:          "" => "<computed>"
  security_groups.#:            "" => "<computed>"
  source_dest_check:            "" => "true"
  subnet_id:                    "" => "<computed>"
  tenancy:                      "" => "<computed>"
  volume_tags.%:                "" => "<computed>"
  vpc_security_group_ids.#:     "" => "<computed>"
aws_instance.example: Still creating... (10s elapsed)
aws_instance.example: Still creating... (20s elapsed)
aws_instance.example: Creation complete after 29s (ID: i-02038e31b23bdbe3a)
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
$ 
```

