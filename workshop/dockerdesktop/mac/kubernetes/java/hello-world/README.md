# Running Hello World Java App on Kubernetes using Docker Desktop


## Pre-requisite

- Docker Desktop 

## Getting Started

## Clone the repository


```
git clone https://github.com/collabnix/dockerlabs
cd dockerlabs/workshop/dockerdesktop/mac/kubernetes/java/hello-world
```


## Building the Docker Image

```
docker build -t ajeetraina/helloworldjava .
[+] Building 2.8s (10/10) FINISHED                                                                                                                 
 => [internal] load build definition from Dockerfile                                                                                          0.0s
 => => transferring dockerfile: 148B                                                                                                          0.0s
 => [internal] load .dockerignore                                                                                                             0.0s
 => => transferring context: 2B                                                                                                               0.0s
 => [internal] load metadata for docker.io/library/openjdk:8                                                                                  2.2s
 => [auth] library/openjdk:pull token for registry-1.docker.io                                                                                0.0s
 => [1/4] FROM docker.io/library/openjdk:8@sha256:86e863cc57215cfb181bd319736d0baf625fe8f150577f9eb58bd937f5452cb8                            0.0s
 => => resolve docker.io/library/openjdk:8@sha256:86e863cc57215cfb181bd319736d0baf625fe8f150577f9eb58bd937f5452cb8                            0.0s
 => [internal] load build context                                                                                                             0.0s
 => => transferring context: 1.14kB                                                                                                           0.0s
 => CACHED [2/4] WORKDIR /app                                                                                                                 0.0s
 => [3/4] COPY . /app/                                                                                                                        0.0s
 => [4/4] RUN javac helloworld.java                                                                                                           0.5s
 => exporting to image                                                                                                                        0.1s
 => => exporting layers                                                                                                                       0.0s
 => => exporting manifest sha256:48e5c4356537a71fcf49157f0fedc7e74e5a2ca650c7138bc56e76598679acdb                                             0.0s
 => => exporting config sha256:a74405a3f3cdc9f2468464091a5fb8561aa0b1fa89f476b3fb77e4fdda79540d                                               0.0s
 => => naming to docker.io/ajeetraina/helloworldjava:latest                                                                                   0.0s
 => => unpacking to docker.io/ajeetraina/helloworldjava:latest                                                                                0.0s

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
```

## Pushing the Docker Image to Docker Hub

```
docker push ajeetraina/helloworldjava:latest
```


## Creating a Kubernetes deployment 

Now it's time to create a Kubernetes deployment for the application using the kubectl command


```
kubectl create deployment hello-kubernetes --image=ajeetraina/helloworldjava:latest
deployment.apps/hello-kubernetes created
```

The container runs and gets exited immediately

<img width="1261" alt="image" src="https://user-images.githubusercontent.com/313480/210351979-58064514-9dce-4975-84ce-1766bb59b5d9.png">



