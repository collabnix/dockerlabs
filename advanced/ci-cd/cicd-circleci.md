# 5 Minutes Guide to CI/CD pipelining using Docker & Circle-CI


## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Play with Docker</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side
- circle-ci and github account 


## Continous Integration Pipeline - (Without Docker)

For the purpose of virtualization, we uses virtual machine technology. This technology actually reduces concentration risk when deploy in the right configurations. You can always achieve more failures using fewer x physical machines and hosting more than x virtual machines that are networked to watch each other and take over in the event of partner machines failure.

Another drawback of virtual machine is licensing cost. Virtual machine technology imposes a performance penalty from running an additional layer about the physical hardware. Also virtual machine technology hardware that both virtual machine hypervisor and the guest operating system support. To overcome all these problems Docker is the best solution.

Current CI/CD solutions follow multi-tiered environments approach - development, test, staging and production. Each of these environments are managed independently of each other.Hence, each of these environments may have different configurations different library versions or even different Operating Systems.

![without docker](https://user-images.githubusercontent.com/21982562/47330291-52a7cd00-d695-11e8-8129-1cd48fc2009c.png)

This leads to the popular problem known as “it works on my machine” syndrome where an application that works on one environment stops working on some other due to the above-mentioned problem.

## Docker comes to Rescue

![ci with docker](https://user-images.githubusercontent.com/21982562/47330766-0fe6f480-d697-11e8-9c4e-bd2290beae15.png)

1. Continuous integration and continuous deployment has become one of the most common use cases of Docker early adopters. 
2. CI/CD merges development with testing, allowing developers to build code collaboratively, submit it the master branch, and checked for issues. This allows developers to not only build their code, but also test their code in any environment type and as often as possible to catch bugs early in the applications development lifecycle. 
3. Since Docker can integrate with tools like Jenkins and GitHub, developers can submit code in GitHub, test the code and automatically trigger a build using Jenkins, and once the image is complete, images can be added to Docker registries.
4. This streamlines the process, saves time on build and set up processes, all while allowing developers to run tests in parallel and automate them so that they can continue to work on other projects while tests are being run. 
5. Since Docker works on prem, in the cloud or virtual environment and supports both Linux and Windows, enterprises no longer have to deal with inconsistencies between different environments types. Perhaps one of the most widely known benefits of the Docker CaaS platform


Steps to follow:


Clone the Repository:

```
git clone https://github.com/sangam14/dockerapp1.git
```

Change directory to dockerapp1 as shown below:


```
cd dockerapp1 
```

Bringing up app using Docker Compose:
 
```
docker-compose up 
```

![ play-with-docker- PWD](https://github.com/sangam14/dockerapp1/blob/master/Screenshot%202018-10-25%20at%2010.48.55%20PM.png)

![ play-with-docker- PWD click-button-to-check-web-page](https://github.com/sangam14/dockerapp1/blob/master/Screenshot%202018-10-25%20at%2010.51.29%20PM.png)

output:

![PWD output](https://github.com/sangam14/dockerapp1/blob/master/Screenshot%202018-10-25%20at%2010.51.03%20PM.png)

As shown above, we can save key and value by clicking "Save" button. 

## Integrating Cirecle-ci (Before Docker)

Make sure you add circle-ci config file under .circleci/... as shown under the example https://github.com/sangam14/dockerapp1/tree/master/.circleci


```
.circleci/config.yml
```

```
version: 2
jobs:
  build:
    working_directory: /dockerapp1
    docker:
      - image: docker:17.05.0-ce-git
    steps:
      - checkout
      - setup_remote_docker
      - run:
          name: Install dependencies
          command: |
            apk add --no-cache py-pip=9.0.0-r1
            pip install docker-compose==1.15.0
      - run:
          name: Run tests
          command: |
            docker-compose up -d
            docker-compose run dockerapp1 python test.py
      - deploy:
          name: Push application Docker image
          command: |
            docker login -e $DOCKER_HUB_EMAIL -u $DOCKER_HUB_USER_ID -p $DOCKER_HUB_PWD
            docker tag dockerapp_dockerapp $DOCKER_HUB_USER_ID/dockerapp1:$CIRCLE_SHA1
            docker tag dockerapp_dockerapp $DOCKER_HUB_USER_ID/dockerapp1:latest
            docker push $DOCKER_HUB_USER_ID/dockerapp1:$CIRCLE_SHA1
            docker push $DOCKER_HUB_USER_ID/dockerapp1:latest
```

As shown above,  make sure to add environment variable like  $DOCKER_HUB_EMAIL, $DOCKER_HUB_USER_ID,$DOCKER_HUB_PWD
Once you get circleci job running sucessfully, it should automatically be deployed on DockerHub repository. 

Login to the circl-ci account https://circleci.com using github. Select project which you want to deploy. 

![add_project](https://github.com/sangam14/dockerapp1/blob/master/Screenshot%202018-10-26%20at%207.49.53%20AM.png)

Go to the setting of the project in circleci dashboard and add the environment veriable which declared in .circleci/config.yml file io.
You can also provide Github SSH permission.

![envn_var](https://github.com/sangam14/dockerapp1/blob/master/Screenshot%202018-10-26%20at%207.50.31%20AM.png)

Next, Run the build and it will perform following steps one by one {if it encounter any error, you should see red-colored messages )
<br>

1.Spin up Environment<br>
2.Checkout code<br>
3.Setup a remote Docker engine<br>
4.Install dependencies<br>
5.Run tests<br>
<br>
It should result in test.py. Refer https://github.com/sangam14/dockerapp1/blob/master/app/test.py


### Pushing application Docker image


After it gets successfully completed, you should be able to find the below Docker Image under DockerHub. 

https://hub.docker.com/r/sangam14/dockerapp

You should see it successfully deployed. Cheers !

## Contributor - 

Sangam biradar - smbiradar14@gmail.com -www.codexplus.in 

