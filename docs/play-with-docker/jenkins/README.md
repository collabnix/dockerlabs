# Demonstrating Jenkins Pipeline for Docker on Play with Docker Platform

## Pre-requisite:

- Login to http://play-with-docker.com
- Spun up 1 instance 

## Step-1: Running Jenkins Container

Before you run container, ensure that the proper permission been granted:

```
chmod 666 /var/run/docker.sock
```

```
docker run --rm -p 8080:8080  -v /var/run/docker.sock:/var/run/docker.sock ajeetraina/jenkins
```

## Step-2: Copy the Jenkins password and paste it over Jenkins UI.

## Step-3: Select default Plugin and add your user details

## Step-4: We will use https://github.com/ajeetraina/hellonode as our base GIT repository

Open up new project > Under build trigger, add GIT as SCM and then ensure that Jenkinsfile get reflected

## Step-5: Click "Build Now"

```
Started by user Ajeet Raina
Obtained Jenkinsfile from git https://github.com/ajeetraina/hellonode
Running in Durability level: MAX_SURVIVABILITY
[Pipeline] node
Running on Jenkins in /var/jenkins_home/workspace/docker-ipiee
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Clone repository)
[Pipeline] checkout
 > git rev-parse --is-inside-work-tree # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/ajeetraina/hellonode # timeout=10
Fetching upstream changes from https://github.com/ajeetraina/hellonode
 > git --version # timeout=10
 > git fetch --tags --progress https://github.com/ajeetraina/hellonode +refs/heads/*:refs/remotes/origin/*
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git rev-parse refs/remotes/origin/origin/master^{commit} # timeout=10
Checking out Revision ce0b2505262fb9662e7b93ac684256fe74a8d980 (refs/remotes/origin/master)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f ce0b2505262fb9662e7b93ac684256fe74a8d980
Commit message: "Update main.js"
 > git rev-list --no-walk 3ced943bb4c07f6ba552e602cee700f24a7a5df8 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Build image)
[Pipeline] sh
[docker-ipiee] Running shell script
+ docker build -t ajeetraina/hellonode .
Sending build context to Docker daemon  101.9kB

Step 1/4 : FROM node:7-onbuild
# Executing 5 build triggers
 ---> Using cache
 ---> Using cache
 ---> Using cache
 ---> Using cache
 ---> 2989eb7642b6
Step 2/4 : LABEL maintainer "ajeetraina@gmail.com"
 ---> Running in 2a0a0f4a7b91
Removing intermediate container 2a0a0f4a7b91
 ---> d4432b6791eb
Step 3/4 : HEALTHCHECK --interval=5s             --timeout=5s             CMD curl -f http://127.0.0.1:8000 || exit 1
 ---> Running in b1691997d62b
Removing intermediate container b1691997d62b
 ---> 899c666f4264
Step 4/4 : EXPOSE 8000
 ---> Running in 8883792c1a2a
Removing intermediate container 8883792c1a2a
 ---> 8f8b77304d07
Successfully built 8f8b77304d07
Successfully tagged ajeetraina/hellonode:latest
[Pipeline] dockerFingerprintFrom
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Test image)
[Pipeline] sh
[docker-ipiee] Running shell script
+ docker inspect -f . ajeetraina/hellonode
.
[Pipeline] withDockerContainer
Jenkins seems to be running inside container a22bebf8734c8257b90f3412ff380a8ef87a98c60ee474d65a63a05cf11aed41
$ docker run -t -d -u 1000:1000 -w /var/jenkins_home/workspace/docker-ipiee --volumes-from a22bebf8734c8257b90f3412ff380a8ef87a98c60ee474d65a63a05cf11aed41 -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** ajeetraina/hellonode cat
$ docker top bb63aeb61aa9c61799f396592042eec6a7f998b755ec52e26b94ccf15ebe65b5 -eo pid,comm
[Pipeline] {
[Pipeline] sh
[docker-ipiee] Running shell script
+ echo Tests passed
Tests passed
[Pipeline] }
$ docker stop --time=1 bb63aeb61aa9c61799f396592042eec6a7f998b755ec52e26b94ccf15ebe65b5
$ docker rm -f bb63aeb61aa9c61799f396592042eec6a7f998b755ec52e26b94ccf15ebe65b5
[Pipeline] // withDockerContainer
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Push image)
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withDockerRegistry
Wrote authentication to /var/jenkins_home/.dockercfg
[Pipeline] {
[Pipeline] sh
[docker-ipiee] Running shell script
+ docker tag ajeetraina/hellonode registry.hub.docker.com/ajeetraina/hellonode:3
[Pipeline] sh
[docker-ipiee] Running shell script
+ docker push registry.hub.docker.com/ajeetraina/hellonode:3
The push refers to repository [registry.hub.docker.com/ajeetraina/hellonode]
ac65cfdd9d31: Preparing
b6b6da929f83: Preparing
6805b7697710: Preparing
2895be281ac1: Preparing
ab90d83fa34a: Preparing
8ee318e54723: Preparing
e6695624484e: Preparing
da59b99bbd3b: Preparing
5616a6292c16: Preparing
f3ed6cb59ab0: Preparing
654f45ecb7e3: Preparing
2c40c66f7667: Preparing
8ee318e54723: Waiting
e6695624484e: Waiting
da59b99bbd3b: Waiting
5616a6292c16: Waiting
f3ed6cb59ab0: Waiting
654f45ecb7e3: Waiting
2c40c66f7667: Waiting
b6b6da929f83: Layer already exists
6805b7697710: Layer already exists
e6695624484e: Layer already exists
2895be281ac1: Layer already exists
ab90d83fa34a: Layer already exists
f3ed6cb59ab0: Layer already exists
da59b99bbd3b: Layer already exists
654f45ecb7e3: Layer already exists
2c40c66f7667: Layer already exists
5616a6292c16: Layer already exists
8ee318e54723: Layer already exists
ac65cfdd9d31: Pushed
3: digest: sha256:98381387f0ad00bf493e33808213778fd2cc35d8fd945276c9dc347ef4fd5be0 size: 2840
[Pipeline] sh
[docker-ipiee] Running shell script
+ docker tag ajeetraina/hellonode registry.hub.docker.com/ajeetraina/hellonode:latest
[Pipeline] sh
[docker-ipiee] Running shell script
+ docker push registry.hub.docker.com/ajeetraina/hellonode:latest
The push refers to repository [registry.hub.docker.com/ajeetraina/hellonode]
ac65cfdd9d31: Preparing
b6b6da929f83: Preparing
6805b7697710: Preparing
2895be281ac1: Preparing
ab90d83fa34a: Preparing
8ee318e54723: Preparing
e6695624484e: Preparing
da59b99bbd3b: Preparing
5616a6292c16: Preparing
f3ed6cb59ab0: Preparing
654f45ecb7e3: Preparing
2c40c66f7667: Preparing
e6695624484e: Waiting
654f45ecb7e3: Waiting
da59b99bbd3b: Waiting
2c40c66f7667: Waiting
5616a6292c16: Waiting
f3ed6cb59ab0: Waiting
8ee318e54723: Waiting
b6b6da929f83: Layer already exists
6805b7697710: Layer already exists
ab90d83fa34a: Layer already exists
2895be281ac1: Layer already exists
ac65cfdd9d31: Layer already exists
e6695624484e: Layer already exists
8ee318e54723: Layer already exists
da59b99bbd3b: Layer already exists
5616a6292c16: Layer already exists
f3ed6cb59ab0: Layer already exists
654f45ecb7e3: Layer already exists
2c40c66f7667: Layer already exists
latest: digest: sha256:98381387f0ad00bf493e33808213778fd2cc35d8fd945276c9dc347ef4fd5be0 size: 2840
[Pipeline] }
[Pipeline] // withDockerRegistry
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```




