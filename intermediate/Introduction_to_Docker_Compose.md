# Introduction to Docker Compose

Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a Compose file to configure your application’s services. Then, using a single command, you create and start all the services from your configuration.

In other words, Docker Compose utilizes Docker containers as "services" to run the whole tech stack of an application software. So instead of handling multiple Docker containers individually, Docker Compose is that interface to manage them all.

Using Compose is basically a three-step process.

Define your app’s environment with a Dockerfile so it can be reproduced anywhere.

Define the services that make up your app in `docker-compose.yml `so they can be run together in an isolated environment.

Lastly, run`docker-compose up `and Compose will start and run your entire app.

In other words, running Docker Compose all boils down to:

Defining a `Dockerfile` aka defining the environment.<br>
Defining `docker-compose.yml` aka defining the interactions between services / containers.<br>
Running `docker-compose up` to start the application aka start the services / containers.<br>
