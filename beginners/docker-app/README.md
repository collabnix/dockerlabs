A First Look at Docker Application Packages (docker-app)

When managing multiple environments for a web application—development, testing, and production—the workflow differs significantly.

In development, you want to test code changes in real-time. This is usually done by mounting a volume with your source code inside the container.

In production, you host the application in a multi-node cluster. Volumes are local to the node where the container runs, so mounting source code becomes complex and requires synchronization. Typically, multiple Docker Compose files are needed for each environment, which can quickly become cumbersome.

To simplify this, Docker introduced docker-app (Application Packages), which makes Compose files more reusable and shareable, enabling a simplified approach to share multi-service applications directly via Docker Hub.

Tested Infrastructure
Platform	Number of Instances	Estimated Reading Time
Play with Docker	5	5 min
Prerequisites

Docker Hub account: https://hub.docker.com

Open Play with Docker (PWD): https://labs.play-with-docker.com/

Click Spanner Sign to launch a template of 3 Manager nodes & 2 Worker nodes

Verify 5-Node Swarm Cluster
$ docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
juld0kwbajyn11gx3bon9bsct *  manager1            Ready               Active              Leader             18.03.1-ce
uu675q2209xotom4vys0el5jw     manager2            Ready               Active              Reachable          18.03.1-ce
05jewa2brfkvgzklpvlze01rr     manager3            Ready               Active              Reachable          18.03.1-ce
n3frm1rv4gn93his3511llm6r     worker1             Ready               Active                                  18.03.1-ce
50vsx5nvwx5rbkxob2ua1c6dr     worker2             Ready               Active                                  18.03.1-ce

Clone the Repository
$ git clone https://github.com/ajeetraina/app

Install docker-app

Option 1: Manual install

wget https://github.com/docker/app/releases/download/v0.3.0/docker-app-linux.tar.gz
tar xf docker-app-linux.tar.gz
cp docker-app-linux /usr/local/bin/docker-app


Option 2: Using install script

$ ./install.sh

Verify Installation
$ docker-app version
Version:      v0.3.0
Git commit:   fba6a09
Built:        Fri Jun 29 13:09:30 2018
OS/Arch:      linux/amd64
Experimental: off
Renderers:    none

Key docker-app Commands
$ docker-app
Build and deploy Docker applications.

Available Commands:
  deploy      Deploy or update an application
  helm        Generate a Helm chart
  init        Start building a Docker application
  inspect     Shows metadata and settings for an application
  ls          List applications
  merge       Merge multi-file application into a single YAML
  push        Push the application to a registry
  render      Render the Compose file
  save        Save the application as a Docker image
  split       Split a single-file application into multiple files
  version     Show version info

WordPress Application Demo

The wordpress.dockerapp folder contains:

metadata

Compose file

Application settings

Create these files using:

docker-app init --single-file wordpress

Listing Application Package Files
$ ls
README.md            install-wp           with-secrets.yml
devel                prod                 wordpress.dockerapp

Dev Environment

Render the WordPress application for development:

$ docker-app render wordpress -f devel/dev-settings.yml


This enables WORDPRESS_DEBUG: true and publishes the container on port 8082.

Prod Environment

Render for production:

$ docker-app render wordpress -f prod/prod-settings.yml


This disables debug mode and publishes the container on port 80.

Inspect the WordPress App
$ docker-app inspect wordpress


Displays settings, maintainers, and default configuration values.

Deploy the WordPress App
Default
$ docker-app deploy wordpress

Dev Environment
$ docker-app deploy wordpress -f devel/dev-settings.yml

Prod Environment
$ docker-app deploy wordpress -f prod/prod-settings.yml

Push to Docker Hub

Login and push the application package:

$ docker login
$ docker-app push --namespace ajeetraina --tag 1.0.1


Pull it on another machine:

$ docker pull ajeetraina/wordpress.dockerapp:1.0.1


Deploy easily:

$ docker-app deploy ajeetraina/wordpress

Merge Application Package
$ docker-app merge -o mywordpress
$ ls
README.md            install-wp           prod                 wordpress.dockerapp
devel                mywordpress          with-secrets.yml


mywordpress contains a single multi-document YAML combining metadata, compose file, and settings.

Contributor

Ajeet Singh Raina