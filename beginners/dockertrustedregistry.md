# DTR (Docker Trusted Registry)

## Official Definition
Docker Trusted Registry (DTR) is the enterprise-grade image storage solution from Docker. You install it behind your firewall so that you can securely store and manage the Docker images you use in your applications.

Docker trusted registry or simply Docker registry is an enterprise offering from Docker. the most common terminology that you will hear 
with Docker Enterprise Edition is DTR and UCP (universal control plane).

In order for DTR to work UCP has to be insallted and for UCP to be installed you owuld need Docker Enterprise Edition. Once you install 
Docker EE you can get a free liscense from DockerHub.

## DTR Features:

# Image and job management

DTR can be installed on any platform where  you can store your Docker images securely, behind your firewall.
DTR has a user interface that allows authorized users in your organization to browse Docker images and review repository events. It even allows you to see what Dockerfile lines were used to produce the image and, if security scanning is enabled, to see a list of all of the software installed in your images.

## Availability
DTR is highly available as it has multiple replicas of containers in case anything fails.

## Efficiency
DTR has this ability to clean the unreferenced manifests and cache the images as well for faster pulling of images.

## Built-in access control
STR has great authentication mechanisms like RBAC , LDAP sync. It uses the same authentication as of UCP.

## Security scanning
Image Scanning is built in feature provided out of the box by DTR.

## Image signing
DTR has built in Notary, you can use Docker Content Trust to sign snd verify images.

This is what the UI of DTR looks like :

![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/images/DTR.png)

## Contributor - [Saiyam Pathak](https://www.linkedin.com/in/saiyam-pathak-97685a64/)
