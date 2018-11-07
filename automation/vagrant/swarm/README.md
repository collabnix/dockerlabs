# Deploy Docker Swarm Cluster on Linux Vagrant Instances using Ansible

The aim of this project is to deploy a Docker Swarm cluster on Linux Vagrant instances.

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

*   [Virtualbox](https://www.virtualbox.org/wiki/Downloads) must be installed on your computer
*   [Vagrant](https://www.vagrantup.com/docs/installation/) must be installed on your computer
*   Update the Vagrant file based on your computer (CPU, memory), if needed
*   Update the operating system to deploy in the Vagrant file (default: Ubuntu)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Usage

A good point with Vagrant is that you can create, update and destroy all architecture easily with some commands.

Be aware that you need to be in the Vagrant directory to be able to run the commands.

#### Deployment

To deploy Docker Swarm cluster on Vagrant instances, just run this command :

```bash
$ vagrant up
```

If everything run as expected, you should be able to list the virtual machine created :

```bash
$ vagrant status

Current machine states:

swarm01                   running (virtualbox)
swarm02                   running (virtualbox)
swarm03                   running (virtualbox)
```

If everything run as expected, you should have a Docker Swarm cluster up and running on the Vagrant instances :

```
$ vagrant@swarm01:~$ docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
b7vnvuieywv4hrx4lm76p3rst *   swarm01             Ready               Active              Leader              18.06.1-ce
rfxhu9g390xiflalj1y4ylft1     swarm02             Ready               Active                                  18.06.1-ce
gir3bomdlygo44dsphcgfzj9z     swarm03             Ready               Active                                  18.06.1-ce
```

#### Destroy

To destroy the Vagrant resources created, just run this command :

```bash
$ vagrant destroy
```

### How-To

This section list some simple command to use and manage the playbook and the Vagrant hosts.

#### Update with Ansible

To update the Docker Swarm cluster configuration with Ansible, you just have to run the Ansible playbook swarm.yml with this command :

```bash
$ ansible-playbook swarm.yml
```

#### Update with Vagrant

To update the Docker Swarm cluster configuration with Vagrant, you just have to run provisioning part of the Vagrant file :

```bash
$ vagrant provision
```

#### Connect to Vagrant instance

To be able to connect to a Vagrant instance, you should use the CLI which is configured to automatically use the default SSH key :

```bash
$ vagrant ssh swarm01
```

## Contributor

[Wikitops](https://github.com/wikitops) - wikitops5692@gmail.com
