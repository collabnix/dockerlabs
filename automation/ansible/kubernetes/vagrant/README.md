# Deploy Kubernetes Cluster on Linux Vagrant Instances using Ansible

The aim of this project is to deploy a Kubernetes cluster on Vagrant instances.

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
  </tr>
  <tr>
    <td class="tg-yw4l"><b>Local (Virtualbox)</b></td>
    <td class="tg-yw4l"><b>3</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
  </tr>
</table>

## Pre-requisite

What things you need to run this Ansible playbook :

*   [Vagrant](https://www.vagrantup.com/docs/installation/) must be installed on your computer
*   Update the Vagrant file based on your computer (CPU, memory), if needed
*   Update the operating system to deploy in the Vagrant file (default: Ubuntu)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Usage

A good point with Vagrant is that you can create, update and destroy all architecture easily with some commands.

Be aware that you need to be in the Vagrant directory to be able to run the commands.

#### Deployment

To deploy Kubernetes on Vagrant instances, just run this command :

```bash
$ vagrant up
```

If everything run as expected, you should be able to list the virtual machine created :

```bash
$ vagrant status

Current machine states:

kubernetes01                   running (virtualbox)
kubernetes02                   running (virtualbox)
kubernetes03                   running (virtualbox)
```

If everything run as expected, you should list the active nodes with this command:

```bash
$ kubectl get node
NAME           STATUS    ROLES     AGE       VERSION
kubernetes01   Ready     master    2h        v1.12.2
kubernetes02   Ready     <none>    2h        v1.12.2
kubernetes03   Ready     <none>    2h        v1.12.2
```

For information, Flannel CNI is deployed by default to manage the Kubernetes networks.

The dashboard is deployed by default but the UI access and the autentication is not managed yet.

#### Destroy

To destroy the Vagrant resources created, just run this command :

```bash
$ vagrant destroy
```

### How-To

This section list some simple command to use and manage the playbook and the Vagrant hosts.

#### Update with Ansible

To update the Kubernetes cluster configuration with Ansible, you just have to run the Ansible playbook kubernetes.yml with this command :

```bash
$ ansible-playbook kubernetes.yml
```

#### Update with Vagrant

To update the Kubernetes cluster configuration with Vagrant, you just have to run provisioning part of the Vagrant file :

```bash
$ vagrant provision
```

#### Connect to Vagrant instance

To be able to connect to a Vagrant instance, you should use the CLI which is configured to automatically use the default SSH key :

```bash
$ vagrant ssh kubernetes01
```

## Contributor

[Wikitops](https://github.com/wikitops) - wikitops5692@gmail.com
