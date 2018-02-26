# Continuous Integration and Deployment Made Easy using Jenkins under Docker Swarm Mode

## Pre-requisite:

- Login to http://play-with-docker.com

- Create 3 Manager and 2 worker nodes Instances by a single click

## On Manager Node:

## Create Jenkins-master service

```
docker service create --name jenkins-master -p 50000:50000 -p 80:8080 jenkins
```

## Creating Secrets

```
echo "-master http://192.168.0.119 -password admin -username admin"|docker secret create jenkins-v1 -
```

## Creating Jenkins-Swarm Agent Service for Test Environment

```
docker service create --mode=global --name jenkins-swarm-agent -e LABELS=docker-test --mount "type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock" --mount "type=bind,source=/tmp/,target=/tmp/" --secret source=jenkins-v1,target=jenkins vipconsult/jenkins-swarm-agent
```

Login to one of instance running the above service and get the password using the below command:

```
cat /var/jenkins_home/secrets/initialAdminPassword
```

## Accessing Jenkins UI

Go to Jenkins > New Item > Enter an item name of your Choice. I will name it as OpenUSM.
Ensure that you select Freestyle Project and then say "Okay".

Browse through OpenUSM Project page and select Configure on the left hand side. You will see the below various options:

```
- General
- Source Code Management
- Build Triggers
- Build Environment
- Build
- Post-build Actions
```

Select Source Code Management and provide GITHUB repo as https://github.com/openusm/openusm
Leave Credentials as blank.

Go to Build and add the below entry under Shell:

```
DOCKER_IMAGE=ajeetraina/openusm1:1
docker build -t $DOCKER_IMAGE .
docker tag openusm1 ajeetraina/openusm1:1
docker push ajeetraina/openusm1:1
```

Click on Build Now on the left pane. Check the logs -

```
Started by user Ajeet Raina
Building in workspace /var/jenkins_home/workspace/opens
 > git rev-parse --is-inside-work-tree # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/openusm/openusm # timeout=10
Fetching upstream changes from https://github.com/openusm/openusm
 > git --version # timeout=10
 > git fetch --tags --progress https://github.com/openusm/openusm +refs/heads/*:refs/remotes/origin/*
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git rev-parse refs/remotes/origin/origin/master^{commit} # timeout=10
Checking out Revision 2fb9e3cec2610e9bed76b7ecf410e8cf3987ee59 (refs/remotes/origin/master)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 2fb9e3cec2610e9bed76b7ecf410e8cf3987ee59
Commit message: "Update README.md"
 > git rev-list --no-walk 2fb9e3cec2610e9bed76b7ecf410e8cf3987ee59 # timeout=10
[opens] $ /bin/sh -xe /tmp/jenkins5143843853388800197.sh
+ DOCKER_IMAGE=ajeetraina/openusm1:1
+ docker build -t ajeetraina/openusm1:1 .
/tmp/jenkins5143843853388800197.sh: 3: /tmp/jenkins5143843853388800197.sh: docker: not found
Build step 'Execute shell' marked build as failure
Finished: FAILURE
```

This error is expected as we don't have Docker plugin added yet.

Go to Manage Plugin , Search for Docker and then select all options related to Docker.
Re-run the build. You will see that it gets successfully built this time.

TBD

