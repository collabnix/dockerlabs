# How to use Terraform for building up Infrastructure on AWS for Docker

Pre-requisite:

- Create account on aws.amazon.com(Free Tier for beginners)
- A Test Ubuntu System ( or laptop)


## Installing Terraform on your local Ubuntu system

```
sudo wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip && tar xvzf terraform_0.11.7_linux_amd64.zip

```

This guide is for beginners. To make it simple, I have created individual directory for each scenerios.
Each folder has main.tf to demonstrate TF features.

## Demo #1 : Setting up Provider

## Specifying TF provider

Ensure that you make right changes for AWS credentials under main.tf file as shown below:

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

## Applying the changes

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
Terraform also wrote some data into the terraform.tfstate file. This state file is extremely important; it keeps track of the IDs of created resources so that Terraform knows what it is managing. This file must be saved and distributed to anyone who might run Terraform. It is generally recommended to setup remote state when working with Terraform, to share the state automatically, but this is not necessary for simple situations like this Getting Started guide.

```
dockerworxinc@instance-1:~$ cat terraform.tfstate 
{
    "version": 3,
    "terraform_version": "0.11.7",
    "serial": 1,
    "lineage": "785f9f55-6424-a676-62b5-b38bcb087995",
    "modules": [
        {
            "path": [
                "root"
            ],
            "outputs": {},
            "resources": {
                "aws_instance.example": {
                    "type": "aws_instance",
                    "depends_on": [],
                    "primary": {
                        "id": "i-02038e31b23bdbe3a",
                        "attributes": {
                            "ami": "ami-2757f631",
                            "associate_public_ip_address": "true",
                            "availability_zone": "us-east-1b",
                            "credit_specification.#": "1",
                            "credit_specification.0.cpu_credits": "standard",
                            "disable_api_termination": "false",
                            "ebs_block_device.#": "0",
                            "ebs_optimized": "false",
                            "ephemeral_block_device.#": "0",
                            "get_password_data": "false",
                            "iam_instance_profile": "",
                            "id": "i-02038e31b23bdbe3a",
                            ...
                            rworxinc@instance-1:~$ cat terraform.tfstate 
{
    "version": 3,
    "terraform_version": "0.11.7",
    "serial": 1,
    "lineage": "785f9f55-6424-a676-62b5-b38bcb087995",
    "modules": [
        {
            "path": [
                "root"
            ],
            "outputs": {},
            "resources": {
                "aws_instance.example": {
                    "type": "aws_instance",
                    "depends_on": [],
                    "primary": {
                        "id": "i-02038e31b23bdbe3a",
                        "attributes": {
                            "ami": "ami-2757f631",
                            "associate_public_ip_address": "true",
                            "availability_zone": "us-east-1b",
                            "credit_specification.#": "1",
                            "credit_specification.0.cpu_credits": "standard",
                            "disable_api_termination": "false",
                            "ebs_block_device.#": "0",
                            "ebs_optimized": "false",
                            "ephemeral_block_device.#": "0",
                            "get_password_data": "false",
                            "iam_instance_profile": "",
                            "id": "i-02038e31b23bdbe3a",
                            "instance_state": "running",
                            "instance_type": "t2.micro",
                            "ipv6_addresses.#": "0",
                            "key_name": "",
                            "monitoring": "false",
                            "network_interface.#": "0",
                            "network_interface_id": "eni-88b2f5dd",
                            "password_data": "",
                            "placement_group": "",
                            "primary_network_interface_id": "eni-88b2f5dd",
                            "private_dns": "ip-172-31-95-236.ec2.internal",
                            "private_ip": "172.31.95.236",
                            "public_dns": "ec2-54-164-145-156.compute-1.amazonaws.com",
                            "public_ip": "54.164.145.156",
                            "root_block_device.#": "1",
                            "id": "i-02038e31b23bdbe3a",
                            "root_block_device.0.delete_on_termination": "true",
                            "root_block_device.0.iops": "100",
                            "root_block_device.0.volume_id": "vol-0b31d655768c321f0",
                            "root_block_device.0.volume_size": "8",
                            "root_block_device.0.volume_type": "gp2",
                            "security_groups.#": "1",
                            "security_groups.3814588639": "default",
                            "source_dest_check": "true",
                            "subnet_id": "subnet-c17cb2ef",
                            "tags.%": "0",
                            "tenancy": "default",
                            "volume_tags.%": "0",
                            "vpc_security_group_ids.#": "1",
                            "vpc_security_group_ids.2745663399": "sg-a55c07ed"
                        },
                        "meta": {
                            "e2bfb730-ecaa-11e6-8f88-34363bc7c4c0": {
                                "create": 600000000000,
                                "delete": 1200000000000,
                                "update": 600000000000
                            },
                            "schema_version": "1"
                        },
                        "tainted": false
                    },
                    "deposed": [],
                    "provider": "provider.aws"
                }
            },
            "depends_on": []
        }
    ]
}
```
Congratulations! You've built your first infrastructure with Terraform. You've seen the configuration syntax, an example of a basic execution plan, and understand the state file.

## Inspecting Terraform state or plan

```
sudo terraform show
aws_instance.example:
  id = i-02038e31b23bdbe3a
  ami = ami-2757f631
  associate_public_ip_address = true
  availability_zone = us-east-1b
  credit_specification.# = 1
  credit_specification.0.cpu_credits = standard
  disable_api_termination = false
  ebs_block_device.# = 0
  ebs_optimized = false
  ephemeral_block_device.# = 0
  get_password_data = false
  iam_instance_profile = 
  instance_state = running
  instance_type = t2.micro
  ipv6_addresses.# = 0
  key_name = 
  monitoring = false
  network_interface.# = 0
  network_interface_id = eni-88b2f5dd
  password_data = 
  placement_group = 
  primary_network_interface_id = eni-88b2f5dd
  private_dns = ip-172-31-95-236.ec2.internal
  private_ip = 172.31.95.236
  public_dns = ec2-54-164-145-156.compute-1.amazonaws.com
  public_ip = 54.164.145.156
  root_block_device.# = 1
  root_block_device.0.delete_on_termination = true
  root_block_device.0.iops = 100
  root_block_device.0.volume_id = vol-0b31d655768c321f0
  root_block_device.0.volume_size = 8
  ```
  
# Demo #2: Demonstrating Tag

Browse to tag-demo folder and run the below command:

## Providing Tag to EC2 Instance

```
$ sudo terraform apply
aws_instance.example: Refreshing state... (ID: i-02038e31b23bdbe3a)
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  ~ update in-place
Terraform will perform the following actions:
  ~ aws_instance.example
      tags.%:    "0" => "1"
      tags.Name: "" => "terraform-example"
Plan: 0 to add, 1 to change, 0 to destroy.
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.
  Enter a value: yes
aws_instance.example: Modifying... (ID: i-02038e31b23bdbe3a)
  tags.%:    "0" => "1"
  tags.Name: "" => "terraform-example"
aws_instance.example: Modifications complete after 7s (ID: i-02038e31b23bdbe3a)
Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
```

# Demo #3: Demonstrating how to add ELB

## Adding Elastic Load Balancer on AWS

I have added a file elb/main.tf for Elastic Load Balancer. Check it out -



```
~$ sudo terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.
aws_instance.example: Refreshing state... (ID: i-02038e31b23bdbe3a)
------------------------------------------------------------------------
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
Terraform will perform the following actions:
  + aws_elb.example
      id:                                     <computed>
      arn:                                    <computed>
      availability_zones.#:                   "2"
      availability_zones.1305112097:          "us-east-1b"
      availability_zones.3569565595:          "us-east-1a"
      connection_draining:                    "false"
      connection_draining_timeout:            "300"
      cross_zone_load_balancing:              "true"
      dns_name:                               <computed```
      health_check.#:                         <computed>
      idle_timeout:                           "60"
      instances.#:                            "1"
      instances.1524067361:                   "i-02038e31b23bdbe3a"
      internal:                               <computed>
      listener.#:                             "1"
      listener.3931999347.instance_port:      "8080"
      listener.3931999347.instance_protocol:  "http"
      listener.3931999347.lb_port:            "80"
      listener.3931999347.lb_protocol:        "http"
      listener.3931999347.ssl_certificate_id: ""
      name:                                   "example"
      security_groups.#:                      <computed>
      source_security_group:                  <computed>
      source_security_group_id:               <computed>
      subnets.#:                              <computed>
      zone_id:                                <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
dockerworxinc@instance-1:~$ 

```

```
 Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.
  Enter a value: yes
aws_elb.example: Creating...
  arn:                                    "" => "<computed>"
  availability_zones.#:                   "" => "2"
  availability_zones.1305112097:          "" => "us-east-1b"
  availability_zones.3569565595:          "" => "us-east-1a"
  connection_draining:                    "" => "false"
  connection_draining_timeout:            "" => "300"
  cross_zone_load_balancing:              "" => "true"
  dns_name:                               "" => "<computed>"
  health_check.#:                         "" => "<computed>"
  idle_timeout:                           "" => "60"
  instances.#:                            "" => "1"
  instances.1524067361:                   "" => "i-02038e31b23bdbe3a"
  internal:                               "" => "<computed>"
  listener.#:                             "" => "1"
  listener.3931999347.instance_port:      "" => "8080"
  listener.3931999347.instance_protocol:  "" => "http"
  listener.3931999347.lb_port:            "" => "80"
  listener.3931999347.lb_protocol:        "" => "http"
  listener.3931999347.ssl_certificate_id: "" => ""
  name:                                   "" => "example"
  security_groups.#:                      "" => "<computed>"
  source_security_group:                  "" => "<computed>"
  source_security_group_id:               "" => "<computed>"
  subnets.#:                              "" => "<computed>"
  zone_id:                                "" => "<computed>"
aws_elb.example: Still creating... (10s elapsed)
aws_elb.example: Creation complete after 12s (ID: example)
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
:~$ 
```

## Demo #4: Running Nginx Docker container

Browse to docker/main.tf for running Nginx docker container on top of this AWS instance.

```
$ cd docker/
$ sudo terraform init
$ sudo terraform apply
```
