# Docker Content Trust

Docker Content Trust is a feature in the Docker containerization platform that enables remote registry content to be digitally signed, ensuring that the content is unaltered and is the most current available version when users access it. It works via cryptographic keys. Docker Content Trust was introduced in Docker Engine with version 1.8.


Docker Content Trust adds security controls that verify the integrity of container images -- the container files that hold application components and content -- stored in a registry, such as Docker Hub. Enterprise developers and other users can push or pull (upload or download) container images to a registry. Docker Content Trust addresses two concerns with registries. Users might upload a container image infiltrated with malware, and the users accessing it from that remote repository cannot determine its integrity. And secondly, users can put outdated containers on a registry, which creates interoperability, compatibility or performance problems for the business.

When a publisher pushes a container image to a remote registry, Docker Engine applies a cryptographic signature to the container image, using the publisher's cryptographic key. The signed image can be pulled from the registry by users, at which point Docker Engine uses the original publisher's public key to verify it is the same. This key check only verifies that the image is the original file, unaltered. Docker Content Trust does not certify the suitability or performance of a container for any particular task. It is possible to pull a verified container image, only for that container to generate errors or perform poorly because it is not production-ready. A user can still upload a malicious container image, and Docker Content Trust will sign the image. Public registry and repository users still bear the responsibility to test and vet a container image.

## Key features of Docker Content Trust
Docker Content Trust uses two cryptographic keys that are created as trust is established. The first time an image publisher pushes their content to the registry, DCT produces an offline key and a tagging key. The tagging key, also known as a repository key, is applied to the publisher's repository and is the shared key used by anyone who needs to sign content for the repository. The offline key is the private or root trust key for the repository. The term offline key indicates that this key's holder should keep it offline, where it is safe from some types of attacks. Container publishers should protect and back up their cryptographic keys.

Docker Content Trust automatically generates a timestamp key for the uploaded container file, ensuring the image version is authentically the latest upload presented in the repository.

Using these keys, Docker Content Trust can check the cryptographic signature when a user attempts to pull a container. If the keys match, the content is deemed authentic. If not, the user is warned but allowed to proceed if they choose.

Docker Content Trust is based on Docker Notary tool to publish and manage trusted content and The Update Framework (TUF), which is a framework to secure software update systems. The Notary project provides a client-server foundation for establishing trust to verify and work with content collections. Notary is integrated into Docker Content Trust to enable publishers to sign content using offline keys and post trusted content to a trusted collection on public servers. Users can securely obtain the publisher's public key, and then use it to verify the content. Notary relies on TUF for secure software distribution and update operations.

## Docker Content Trust security advantages
The verification system helps guard against man-in-the-middle attacks, as it prevents an attacker from secretly forging or tampering with content. DCT also prevents replay attacks, wherein valid actions are copied and replayed by attackers to fool a system. For example, DCT timestamps prevent attackers from passing off older (typically compromised) images from being passed off as most recent. The TUF framework and use of multiple keys allow DCT to guard the system against tagging key compromise, and allow publishers to change tagging keys on demand, without disrupting users.

Docker designed the Content Trust feature to be unobtrusive for developers that upload images and the people who use this content. Content publishers do not have to learn new commands, or change workflows, but they do need to create and manage keys. Users are completely insulated from the digital signage system, and can use the same push, pull, build, run and other commands as they would without Docker Content Trust.

## Signing Images with Docker Content Trust
Within the Docker CLI we can sign and push a container image with the ```$ docker trust``` command syntax. This is built on top of the Notary feature set, more information on Notary can be found here.

A prerequisite for signing an image is a Docker Registry with a Notary server attached (Such as the Docker Hub or Docker Trusted Registry). Instructions for standing up a self-hosted environment can be found here.

To sign a Docker Image you will need a delegation key pair. These keys can be generated locally using ```$ docker trust key generate```, generated by a certificate authority, or if you are using Docker Enterprise’s Universal Control Plane (UCP), a user’s Client Bundle provides adequate keys for a delegation. Find more information on Delegation Keys here.

First we will add the delegation private key to the local Docker trust repository. (By default this is stored in ```~/.docker/trust/```). If you are generating delegation keys with $ docker trust key generate, the private key is automatically added to the local trust store. If you are importing a separate key, such as one from a UCP Client Bundle you will need to use the ```$ docker trust key load``` command. <br>

```
$ docker trust key generate jeff
Generating key for jeff...
Enter passphrase for new jeff key with ID 9deed25:
Repeat passphrase for new jeff key with ID 9deed25:
Successfully generated and loaded private key. Corresponding public key available: /home/ubuntu/Documents/mytrustdir/jeff.pub 
```

Or if you have an existing key:

```
$ docker trust key load key.pem --name jeff
Loading key from "key.pem"...
Enter passphrase for new jeff key with ID 8ae710e:
Repeat passphrase for new jeff key with ID 8ae710e:
Successfully imported key from key.pem 
```

Next we will need to add the delegation public key to the Notary server; this is specific to a particular image repository in Notary known as a Global Unique Name (GUN). If this is the first time you are adding a delegation to that repository, this command will also initiate the repository, using a local Notary canonical root key. To understand more about initiating a repository, and the role of delegations, head to delegations for content trust.

``` 
$ docker trust signer add --key cert.pem jeff dtr.example.com/admin/demo
Adding signer "jeff" to dtr.example.com/admin/demo...
Enter passphrase for new repository key with ID 10b5e94: 
```

Finally, we will use the delegation private key to sign a particular tag and push it up to the registry.

```
$ docker trust sign dtr.example.com/admin/demo:1
Signing and pushing trust data for local image dtr.example.com/admin/demo:1, may overwrite remote trust data
The push refers to repository [dtr.example.com/admin/demo]
7bff100f35cb: Pushed
1: digest: sha256:3d2e482b82608d153a374df3357c0291589a61cc194ec4a9ca2381073a17f58e size: 528
Signing and pushing trust metadata
Enter passphrase for signer key with ID 8ae710e:
Successfully signed dtr.example.com/admin/demo:1
```

Alternatively, once the keys have been imported an image can be pushed with the $ docker push command, by exporting the DCT environmental variable.
```
$ export DOCKER_CONTENT_TRUST=1
```
```
$ docker push dtr.example.com/admin/demo:1
The push refers to repository [dtr.example.com/admin/demo:1]
7bff100f35cb: Pushed
1: digest: sha256:3d2e482b82608d153a374df3357c0291589a61cc194ec4a9ca2381073a17f58e size: 528
Signing and pushing trust metadata
Enter passphrase for signer key with ID 8ae710e:
Successfully signed dtr.example.com/admin/demo:1 
```

Remote trust data for a tag or a repository can be viewed by the $ docker trust inspect command:

```
$ docker trust inspect --pretty dtr.example.com/admin/demo:1

Signatures for dtr.example.com/admin/demo:1

SIGNED TAG          DIGEST                                                             SIGNERS
1                   3d2e482b82608d153a374df3357c0291589a61cc194ec4a9ca2381073a17f58e   jeff

List of signers and their keys for dtr.example.com/admin/demo:1

SIGNER              KEYS
jeff                8ae710e3ba82

Administrative keys for dtr.example.com/admin/demo:1

  Repository Key:	10b5e94c916a0977471cc08fa56c1a5679819b2005ba6a257aa78ce76d3a1e27
  Root Key:	84ca6e4416416d78c4597e754f38517bea95ab427e5f95871f90d460573071fc
```
Remote Trust data for a tag can be removed by the ```$ docker trust revoke``` command:

```
$ docker trust revoke dtr.example.com/admin/demo:1
Enter passphrase for signer key with ID 8ae710e:
Successfully deleted signature for dtr.example.com/admin/demo:1
```

## Contributor
- [Apurva Bhandari](https://www.linkedin.com/in/apurvabhandari-linux)
