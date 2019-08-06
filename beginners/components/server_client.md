# Docker Client VS Server

Every application/product we use follows client-server architecture either directly or indirectly. Take an example of facebook, twitter, gmail etc. all these applications are based to client-server architecture.

Let's try and understand what do we mean by a client and server.
There can be many literal interpretations of the terms client and server when it comes to it's usage, but in general all those means the same.

# Index
- [Docker Client VS Server](#docker-client-vs-server)
- [Index](#index)
- [Client](#client)
- [Server](#server)
- [Docker Server](#docker-server)
- [Docker client](#docker-client)

# Client
Client is sort of a gateway or an interface which let's you use the product. It is a layer between a user and some complex implementation which runs the product, Client takes care of providing the user with abstracted layer of interface through which user ends up using the product.

[Back to Index](#index)

# Server
Server is nothing but a compute compatible machine which runs the product and gets requests from clients, Which in turn is recepted and decoded to understand what is it client wants. Servers are responsible for running the product and perform the tasks requested by the client.

[Back to Index](#index)

Now, we understand what client and server means in computing. Let's dive into what is a Docker Client and Docker Server.

![Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/images/comp_client_server.jpg)

*Image courtesy: https://www.xenonstack.com/blog/docker-application-solutions/*

# Docker Server
Docker as we all know by does all things contatiners. It provides a container runtime, It is manages contianer storage, networks, image builds and many other services. No doubt it requries compute power to perform all these tasks.
Docker server is nothing but a compute instance (VM, Personal Computer etc.) which is responsible for runing docker daemon process which in turn manages all the services provided by docker.

# Docker client
To communicate with the docker daemon to execute a certain task like runing a contaienr, build some image are all done via docker client. Now, you'd have probably guesed it, The Docker CLI. Along with Docker CLI, Docker daemon also exposes a REST API which can be used to programmatically access services exposed by the daemon.

A subset view of docker's client and server.

![Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/images/comp_subset.png)<br>
*Image courtesy: https://docs.docker.com/engine/docker-overview/*


**Note:**

Soul purpose of this tutorial was to understand the docker client-server architecture, There are several other topics to cover like, What is Docker Registry?
These topics among some other advanced ones are explained in future tutorials, Keep following. Happy Dockerizing!

[Go to Beginners Index](https://github.com/collabnix/dockerlabs/tree/master/beginners#beginners-track)
