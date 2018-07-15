# Terraforming Docker Infrastructure on AWS

## Problem Statement:

The complexity of the AWS system leads to two problems that I hope to address in this three-part series: The first is that a lot of experience and understanding are required to properly configure everything, which results in information silos and unhealthy dependency on subject matter experts. The second problem is that with the cloud, things change at a rapid pace, and attempts to document processes can be a wasted effort.Amazon’s web interface changes on a regular basis, and our attempts to document our processes have been invalidated in just months.

## Solution: Terraform 

Terraform is an open-source infrastructure-as-code tool that allows you to declare your infrastructure using an easy to read and write DSL (domain specific language). Running the Terraform CLI will either create or update your environment to match what you’ve told it you want. Change a value, like which AMI to use for EC2 instances, and it will see the change and replace any instances with new ones.

Terraform provides a declarative way to establish infrastructure rather than an imperative one. You don’t need to code or even know what it takes to establish a piece of infrastructure — you just declare what you want and Terraform figures out how to make it so.

Terraform  automatically recognizes dependencies, builds a full dependency graph, then executes as many parallel processes of work as possible.

One of the huge benefits of an infrastructure-as-code approach is that the details for configuration and component dependencies become self-documenting. I can have a single Git repository represent the full infrastructure stack for an application or cluster of applications depending on how I want to structure the code. Also, launching new environments or changing existing ones becomes easier to understand and execute, such that more members of a team can participate, not just highly trained operations staff.

Some of you may already be familiar with Amazon’s CloudFormation infrastructure-as-code service and be wondering why use Terraform instead of CloudFormation. If 100 percent of your infrastructure is on AWS, then CloudFormation may be sufficient for you. However, it’s much more likely you’ll use AWS plus another service, eg Cloudflare in our case, and CloudFormation cannot manage Cloudflare.

Terraform supports over 70 different service providers officially and many more through community plugins. This means that, using the same scripts and syntax, you can manage and connect multiple service providers.



## Pre-requisite:

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




