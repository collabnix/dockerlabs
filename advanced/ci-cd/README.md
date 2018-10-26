
# Quick 5 min CI/CD pipelining using circle-ci with example
# why docker ??
# Problem Statement: CI Pipelining Without Docker 
1. For the purpose of virtualization, we uses virtual machine technology. This technology actually reduces concentration risk when deploy in the right configurations. You can always achieve more failures using fewer x physical machines and hosting more than x virtual machines that are networked to watch each other and take over in the event of partner machines failure.

2. Another drawback of virtual machine is licensing cost. Virtual machine technology imposes a performance penalty from running an additional layer about the physical hardware. Also virtual machine technology hardware that both virtual machine hypervisor and the guest operating system support. To overcome all these problems Docker is the best solution.

3. current CI/CD solutions follow multi-tiered environments approach - development, test, staging and production. Each of these environments are managed independently of each other.

4. Hence, each of these environments may have different configurations different library versions or even different Operating Systems.

![without docker](https://user-images.githubusercontent.com/21982562/47330291-52a7cd00-d695-11e8-8129-1cd48fc2009c.png)

5. This leads to the popular problem known as “it works on my machine” syndrome where an application that works on one environment stops working on some other due to the above-mentioned problem.

    so lets see the solution for it using docker 
# Solution To Problem Statement: Using Docker 

![ci with docker](https://user-images.githubusercontent.com/21982562/47330766-0fe6f480-d697-11e8-9c4e-bd2290beae15.png)

1. Continuous integration and continuous deployment has become one of the most common use cases of Docker early adopters. 
2. CI/CD merges development with testing, allowing developers to build code collaboratively, submit it the master branch, and checked for issues. This allows developers to not only build their code, but also test their code in any environment type and as often as possible to catch bugs early in the applications development lifecycle. 
3. Since Docker can integrate with tools like Jenkins and GitHub, developers can submit code in GitHub, test the code and automatically trigger a build using Jenkins, and once the image is complete, images can be added to Docker registries.
4. This streamlines the process, saves time on build and set up processes, all while allowing developers to run tests in parallel and automate them so that they can continue to work on other projects while tests are being run. 
5. Since Docker works on prem, in the cloud or virtual environment and supports both Linux and Windows, enterprises no longer have to deal with inconsistencies between different environments types. Perhaps one of the most widely known benefits of the Docker CaaS platform



![ play-with-docker- PWD](https://github.com/sangam14/dockerapp1/blob/master/Screenshot%202018-10-25%20at%2010.48.55%20PM.png)



# lets run the dockerapp before integrating to circle-ci:

just pick a git clone using following command 

```
git clone https://github.com/sangam14/dockerapp1.git
```

jump into clone directory that is dockerapp1 using following command 


```
cd dockerapp1 
```
 run the docker compose file by following command 
 
```
docker-compose up 
```
![ play-with-docker- PWD click-button-to-check-web-page](https://github.com/sangam14/dockerapp1/blob/master/Screenshot%202018-10-25%20at%2010.51.29%20PM.png)

output:

![PWD output](https://github.com/sangam14/dockerapp1/blob/master/Screenshot%202018-10-25%20at%2010.51.03%20PM.png)

in this above application you can save key and value by clicking save button 
and you can give key and it will return value for it 

its working perfectly !!

# before integrate to cirecle-ci 

make sure add circle-ci config file under .circleci/...
example https://github.com/sangam14/dockerapp1/tree/master/.circleci
```
.circleci/config.yml
```
.circleci/config.yml

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

in this above make sure to add envirment veriable like  $DOCKER_HUB_EMAIL, $DOCKER_HUB_USER_ID,$DOCKER_HUB_PWD
so after runing circleci job sucessfully it will automatically deployed on dockerhub repo 

login to the circl-ci account https://circleci.com using github 

select project which you want to deploy 

![add_project](https://github.com/sangam14/dockerapp1/blob/master/Screenshot%202018-10-26%20at%207.49.53%20AM.png)

go to the setting of the project in circleci dashboard
add the environment veriable which declared in .circleci/config.yml file io

you can also prvide github ssh permission 

![envn_var](https://github.com/sangam14/dockerapp1/blob/master/Screenshot%202018-10-26%20at%207.50.31%20AM.png)
after that run the build it will perform following steps one by one {if its error it will show red otherwise green )
1.Spin up Environment
2.Checkout code
3.Setup a remote Docker engine
4.Install dependencies
5.Run tests

already given test.py file so it will check test.py after  
```
https://github.com/sangam14/dockerapp1/blob/master/app/test.py

```
6.Push application Docker image


after successfully completed its will deployed in docker hub 

https://hub.docker.com/r/sangam14/dockerapp

see its deployed

# Maintained by: Sangam biradar - smbiradar14@gmail.com -www.codexplus.in 


it help you to understand some docker commands  

dockerfile: https://github.com/sangam14/dockerapp1/blob/master/Dockerfile
```
FROM python:3.5
RUN pip install Flask==0.11.1 redis==2.10.5
RUN useradd -ms /bin/bash admin
USER admin
COPY app /app
WORKDIR /app
CMD ["python", "app.py"] 

```
Docker-compose.yml https://github.com/sangam14/dockerapp1/blob/master/docker-compose.yml
```
version: "3.0"
services:
  dockerapp1:
    build: .
    ports:
      - "5000:5000"
    depends_on:
      - redis
  redis:
    image: redis:3.2.0

```
prod.yml https://github.com/sangam14/dockerapp1/blob/master/prod.yml
```
version: "3.0"
services:
  dockerapp1:
    image: sangam14/dockerapp1
    ports:
      - "5000:5000"
    depends_on:
      - redis
  redis:
    image: redis:3.2.0
```
