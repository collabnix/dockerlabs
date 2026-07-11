
# CI - CD using Docker & Azure DevOps integrated with MS Teams

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>URL</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b>Azure DevOps</b></td>
    <td class="tg-yw4l"><b>https://dev.azure.com/sujithar37/RWODevOpsTest</b></td>    
    <td class="tg-yw4l"><b>3 min</b></td>
    
  </tr>
  
</table>

## Introduction

This guide will explain a few core concept about CI-CD pipeline using Azure DevOps for Docker based deployments. Also, this could be more likely a generic CI-CD template which can even customize in depth by going through the relevant documentations and it has been described very well in the configuration files([azure-pipelines.yml](https://dev.azure.com/sujithar37/_git/RWODevOpsTest?path=%2Fazure-pipelines.yml&version=GBmaster) && [Dockerfile](https://dev.azure.com/sujithar37/_git/RWODevOpsTest?path=%2FDockerfile&version=GBmaster)) and how we can play with those etc.

This guide has 3 sections as follows,
- Pre-requisite - Things to learn/notice before you jump in
- Problem Statement - Of course, what is the problem?
- Solution - Okay, Here is the solution of your problem!!!

Let's get started, 

## Pre-requisite

- A General View about [Azure DevOps](https://docs.microsoft.com/en-us/azure/devops/user-guide/what-is-azure-devops?view=azure-devops) and [MS Teams](https://docs.microsoft.com/en-us/MicrosoftTeams/teams-overview)
- Integration - [Azure Pipelines with MS Teams](https://docs.microsoft.com/en-us/azure/devops/pipelines/integrations/microsoft-teams?view=azure-devops)
- Create an account with [DockerHub](https://hub.docker.com)

## Problem Statement

- Enable CI-CD pipeline in one of the [Github project](https://github.com/burybury/RWODevOpsTest) using below standards,

> CI [Continuous Integration]

1. Since it has been written in C++, use below the command to generate the build file named as 'binary.out'
```bash
g++ -std=c++11 -I/usr/include/boost/asio -I/usr/include/boost -o binary.out main.cpp connection.cpp connection_manager.cpp mime_types.cpp reply.cpp request_handler.cpp request_parser.cpp server.cpp -lboost_system -lboost_thread -lpthread 
```
2. For every commits or manual queue, the CI needs to be triggered and the respective build information should be updated in the 'readme.txt' file with the below format,
```text
  build_number = $a.$b.$c where $a is a build pipeline variable that can be set , $b is some incremental value, and $c is git commit SHA
```

> CD [Continuous Deployment]

1. Bring up a Docker image with the generated builds and finally push that into Docker Hub.


## Solution

1. Import the [Github project](https://github.com/burybury/RWODevOpsTest) into [Azure DevOps repository](https://dev.azure.com/sujithar37/_git/RWODevOpsTest) since it can provide an all-in-one solution which starts from Azure Boards to Artifacts.
2. Checkout the [azure-pipelines.yml](https://dev.azure.com/sujithar37/_git/RWODevOpsTest?path=%2Fazure-pipelines.yml&version=GBmaster) which contains the detailed instructions how the CI has been built.
3. Checkout the [Dockerfile](https://dev.azure.com/sujithar37/_git/RWODevOpsTest?path=%2FDockerfile&version=GBmaster) which contains the detailed instructions how the docker image has been built as soon as CI is done.
4. Enable the CD process through a [Release pipeline](https://dev.azure.com/sujithar37/RWODevOpsTest/_release?view=mine&definitionId=1&_a=releases) which uses the RWO_Artifacts ![CI-Artifacts](https://drive.google.com/uc?export=view&id=18bPf0H2QgnT-vWSJ5RnaAU7zkifWkYn5) and the below task picker [docker-build&push](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/build/docker?view=azure-devops#build-and-push) from market place ![Release_Pipeline-Tasks](https://drive.google.com/uc?export=view&id=1zSQTZnph7f226noolnIuGmLnyhXNFuKy)

5. Finally the generated docker image will be available at [DockerHub-sujithar37/rwobinary](https://hub.docker.com/r/sujithar37/rwobinary/tags) as part CI-CD process ![DockerHub-sujithar37](https://drive.google.com/uc?export=view&id=1tQLLdYKIzSynIUG_mWFh4w444GAXSfck)

6. The above deployment can be done either via automated or approval through [MS Teams channel](https://teams.microsoft.com/l/channel/19%3ae32c2a428aca4320b757323c6cf34cc3%40thread.skype/General?groupId=0d8837dc-98eb-4ec1-9a05-601379653caf&tenantId=92c59a28-ddec-40a2-b20a-3490f773dd5e).![MS Teams Integration](https://drive.google.com/uc?export=view&id=13l-EWhEn72Ts67pdsk1BNSmYx2MejGTU)


## Maintained by:
Sujith Abdul Rahim<br>
- [LinkedIN](https://www.linkedin.com/in/sujithar37/) 
- [GitHub](https://github.com/sujiar37/)
