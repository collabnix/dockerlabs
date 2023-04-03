# Docker for Data Scientists

---

Docker is widely used in the software business nowadays. Docker is a DevOps technology that is widely used in the DevOps and MLOPS communities. Several developers, system administrators, and engineers, among others, have fallen in love with Docker.


We'll begin by discussing what Docker provides and why you should use it in the first place. The post is divided into sections because I'm attempting to explain things as simply as possible in order to reach as many people as possible. So, let's get started!

## What is Docker and Why Docker

When working on a team project, we frequently have to examine how each other's code is running on our system. I'm sure you've ever uttered or heard the sentence "This code is not executing in my machine" or "I don't know this is running in my computer but not in yours (another user)". Thus docker can simply address these sorts of issues.

Docker is a software platform that enables rapid development, testing, and deployment of programmes. Docker organises software into standardised units called containers, which include everything the software requires to execute, such as libraries, system tools, code, and runtime.Docker allows you to swiftly deploy and grow apps into any environment while remaining certain that your code will execute.

## what is Container?

Docker allows you to bundle and execute a programme in a container, which is a loosely separated environment. Because of the isolation and security, you may run several containers on a single host at the same time. Containers are lightweight and include everything required to run the programme, eliminating the need to rely on what is already installed on the host. You may simply share containers while working, and you can ensure that everyone with whom you share receives the same container that functions in the same way.

## Why Utilize Machine Learning Containers?

1. It is simple to run an ML model on a computer. Nevertheless, using that model at the production stage in other systems is a difficult process. Docker simplifies, accelerates, and improves the reliability of this process.

2. We can simply replicate the working environment to train and operate the model on several operating systems by using Docker.

3. With technologies such as OpenShift, a Kubernetes distribution, we can simply deploy and make your model available to clients.

4. Developers may monitor several versions of a container image, see who produced it using what, and roll back to prior versions.

5. Our Machine Learning programme will continue to function even if it is offline, being repaired, or updated.

6. Typically, our machine learning model is developed in a single programming language, such as Python, but the application will undoubtedly need to communicate with other applications written in multiple programming languages. Docker manages all of these interactions since each microservice may be built in a distinct language, allowing for scalability and the easy addition and removal of independent services.

## How Can I Install an ML Model Inside a Docker Container?

Let's look at how we may install our Machine Learning model within a Docker container. To demonstrate the procedure, I will use a basic Titanic dataset Machine Learning model.

1. Make a new directory for this assignment and put your Machine Learning code into it.

2. Create a Dockerfile.

## What exactly is a Dockerfile?

It's just a method for creating your own customised Docker image. This file offers detailed requirements for our use case. Simply A Dockerfile is a recipe for producing a Docker image. It includes certain unique terms like FROM, RUN, CMD, and so forth.

Dockerfile is a dynamic file. That implies that you may alter any stop, update, or add anything at any time by just adding & building. That was quick and efficient.




