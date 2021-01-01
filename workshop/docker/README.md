## Docker WorkShop for Beginners 

![](https://raw.githubusercontent.com/collabnix/dockerlabs/master/workshop/docker/dockerlabs.png)



### Pre-requisite:

- [Creating Your DockerHub Account](https://github.com/collabnix/dockerlabs/blob/master/workshop/docker/dockerhub.md)

### Getting Started with Docker Image


- [Running Hello World Example](https://collabnix.github.io/dockerlabs/beginners/helloworld/) 
  - [Slides](http://dockerlabs.collabnix.com/presentation/docker_workshop_1.html#/)
- [Working with Docker Image](https://collabnix.github.io/dockerlabs/beginners/workingwithdockerimage.html)



  - [Slides](http://dockerlabs.collabnix.com/presentation/docker_workshop_1.html#/12)
- [Saving Images and Containers as Tar Files for Sharing](http://dockerlabs.collabnix.com/beginners/saving-images-as-tar/)
  - [Slides](http://dockerlabs.collabnix.com/presentation/docker_workshop_1.html#/22)
- [Building Your First Alpine Docker Image and Push it to DockerHub](https://collabnix.github.io/dockerlabs/beginners/building-your-first-alpine-container.html)
  - [Slides](http://dockerlabs.collabnix.com/presentation/docker_workshop_1.html#/33)




## Accessing & Managing Docker Container

- [Accessing the Container Shell](http://dockerlabs.collabnix.com/beginners/accessing-the-container.html)<br>
   - [Slides](http://dockerlabs.collabnix.com/presentation/docker_workshop_1.html#/52)
- [Running a Command inside running Container](http://dockerlabs.collabnix.com/beginners/running-command-inside-running-container.html)<br>
   - [Slides](http://dockerlabs.collabnix.com/presentation/docker_workshop_1.html#/57)
- [Managing Docker Containers](http://dockerlabs.collabnix.com/beginners/managing-containers.html)<br>
   - [Slides](http://dockerlabs.collabnix.com/presentation/docker_workshop_1.html#/60)

## Getting Started with Dockerfile

- [What is Dockerfile](https://dockerlabs.collabnix.com/beginners/dockerfile/Writing-dockerfile.html#what-is-a-dockerfile)<br>
  - [Slides](http://dockerlabs.collabnix.com/presentation/docker_workshop_1.html#/70)
- [Understanding Layering Concept with Dockerfile](https://dockerlabs.collabnix.com/beginners/dockerfile/Layering-Dockerfile.html)
- Creating Docker Image with
   - [Lab #1: Installing GIT](https://dockerlabs.collabnix.com/beginners/dockerfile/lab1_dockerfile_git.html)<br>
   - [Lab #2: ADD instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/Lab-2-Create-an-image-with-ADD-instruction.html)<br>
   - [Lab #3: COPY instruction](https://dockerlabs.collabnix.com//beginners/dockerfile/lab4_dockerfile_copy.html)<br>
   - [Lab #4: CMD instruction](https://dockerlabs.collabnix.com//beginners/dockerfile/lab4_cmd.html)<br>
   - [Lab #5: ENTRYPOINT instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/Dockerfile-ENTRYPOINT.html)<br>
   - [Lab #6: WORKDIR instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/WORKDIR_instruction.html)<br>
   - [Lab #7: RUN instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/Lab-7-Create-an-image-with-EXPOSE-instruction.html)<br>
   - [Lab #8: ARG instruction](https://dockerlabs.collabnix.com//beginners/dockerfile/arg.html)<br>
   - [Lab #9: ENV instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/Lab_%239:ENV_instruction.html)<br>
   - [Lab #10: VOLUME instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/Lab%2310:VOLUME_instruction.html)<br>
   - [Lab #11: EXPOSE instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/Lab%2311:EXPOSE_instruction.html)<br>
   - [Lab #12: LABEL instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/Label_instruction.html)<br>
   - [Lab #13: ONBUILD instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/onbuild.html)<br>
   - [Lab #14: HEALTHCHECK instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/healthcheck.html)<br>
   - [Lab #15: SHELL instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/Lab-14-Create-an-image-with-SHELL-instruction.html)<br>
   - [Lab #16: Entrypoint Vs RUN](https://dockerlabs.collabnix.com/beginners/dockerfile/entrypoint-vs-run.html)<br>
   - [Lab #17: USER instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/user.html)
- [Writing Dockerfile with Hello Python Script Added](https://dockerlabs.collabnix.com/beginners/dockerfile/lab_dockerfile_python.html)<br>


## Creating Private Docker Registry

- [Building a Private Docker Registry](https://dockerlabs.collabnix.com/beginners/build-private-docker-registry.html)
- [Building a Private Docker Registry with UI](https://dockerlabs.collabnix.com/beginners/portus/)


### Docker Volumes

- [Managing volumes through Docker CLI](https://collabnix.github.io/dockerlabs/beginners/volume/managing-volumes-via-docker-cli.html)<br>
- [Creating Volume Mount from **docker run** command & sharing same Volume Mounts among multiple containers](https://collabnix.github.io/dockerlabs/beginners/volume/creating-volume-mount-from-dockercli.html)<br>

## Docker Networking

 - [The docker network Command](http://dockerlabs.collabnix.com/beginners/using-docker-network.html)<br>
 - [Lab #1: Listing the Networks](http://dockerlabs.collabnix.com/networking/A1-network-basics.html#step-2-list-networks)
 - [Lab #2: Inspecting a Network](http://dockerlabs.collabnix.com/networking/A1-network-basics.html#step-3-inspect-a-network)
 - [Lab #3: List network driver plugins](http://dockerlabs.collabnix.com/networking/A1-network-basics.html#step-4-list-network-driver-plugins)
 - [Lab #4: Docker Bridge Networking](http://dockerlabs.collabnix.com/networking/A2-bridge-networking.html)
   - [Lab #5: Basics of Docker Bridge Networking](http://dockerlabs.collabnix.com/networking/A2-bridge-networking.html#step-1-the-default-bridge-network)
   - [Lab #6: Connect a Docker container to bridge network](http://dockerlabs.collabnix.com/networking/A2-bridge-networking.html#step-2-connect-a-container)
   - [Lab #7: Test Network Connectivity](http://dockerlabs.collabnix.com/networking/A2-bridge-networking.html#step-3-test-network-connectivity)
   - [Lab #8: Configure NAT for external connectivity](http://dockerlabs.collabnix.com/networking/A2-bridge-networking.html#step-4-configure-nat-for-external-connectivity)
 
 


