# Introduction to Dockerfile


- Docker can build images automatically by reading the instructions from a Dockerfile. 
- A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image.  
- Using docker build users can create an automated build that executes several command-line instructions in succession.

## Docker Build Command

## How to point Docker to alternative location?

Usually Dockerfile is located in the root of the context. You use the -f flag with docker build to point to a Dockerfile anywhere in your file system.

```
docker build -f /path/to/a/Dockerfile .
```

## 

You can specify a repository and tag at which to save the new image if the build succeeds:

```
$ docker build -t shykes/myapp .
```
