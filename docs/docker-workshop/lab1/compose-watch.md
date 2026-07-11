---
title: "Compose Watch"
---


Compose File Watch is a feature introduced in Docker Compose version 2.22.0. It allows for automatic updates and previews of your running Compose services as you edit and save your code. This can enable a hands-off development workflow once Compose is running, as services automatically update themselves when you save your work.

```
services:
  web:
    build: .
    command: npm start
    develop:
      watch:   
        - actions: sync
          path: ./web
          target: /src/web
          ignore: 
            - node_modules/
        - action: rebuild
          path: package.json
```


The `watch` attribute in the Compose file defines a list of rules that control these automatic service updates based on local file changes. Each rule requires a path pattern and an action to take when a modification is detected. The action can be set to rebuild, sync, or sync+restart.

Here's a brief explanation of these actions:

- **rebuild**: Compose rebuilds the service image based on the build section and recreates the service with the updated image.
- **sync**: Compose keeps the existing service container(s) running, but synchronizes source files with container content according to the target attribute.
- **sync+restart**: Compose synchronizes source files with container content according to the target attribute, and then restarts the container.

You can also define a list of patterns for paths to be ignored using the ignore attribute. Any updated file that matches a pattern, or belongs to a folder that matches a pattern, won't trigger services to be re-created.
To use Compose Watch, you need to add the watch instructions to your compose.yaml file and then run your application with the docker compose watch command.

![file watch actions](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab1/images/file-watch-actions.png)

## Getting Started


## Clone the repository

```
git clone https://github.com/dockersamples/getting-started-todo-app/
cd getting-started-todo-app
```

## Switch to compose-watch branch

```
git checkout compose-watch
```


## Bringing up the app

```
docker compose watch
```

## Make some changes

Open a new terminal and modify the following package under frontend/package.json from 

```
"optionalDependencies": {
    "fsevents": "^2.1.2"
```

to

```
"optionalDependencies": {
    "fsevents": "^2.1.3"
```

You will find that the frontend service gets rebuild automatcially for you

```
[+] Running 6/6
 ✔ Network getting-started-todo-app_express-mongo     Created                                                          0.1s 
 ✔ Network getting-started-todo-app_react-express     Created                                                          0.0s 
 ✔ Container mongo                                    Started                                                          1.1s 
 ✔ Container getting-started-todo-app-mongoexpress-1  Started                                                          1.1s 
 ✔ Container backend                                  Started                                                          1.3s 
 ✔ Container frontend                                 Started                                                          1.8s 
Watch enabled
Rebuilding service "frontend" after changes were detected...
[+] Building 52.5s (12/12) FINISHED                                                             docker-container:my-builder
 => [frontend internal] load build definition from Dockerfile                                                          0.0s
 => => transferring dockerfile: 532B                                                                                   0.0s
 => [frontend internal] load metadata for docker.io/library/node:lts-buster                                            1.1s
 => [frontend internal] load .dockerignore                                                                             0.0s
 => => transferring context: 67B                                                                                       0.0s
 => [frontend 1/6] FROM docker.io/library/node:lts-buster@sha256:479103df06b40b90f189461b6f824a62906683e26a32c77d7c3e  0.0s
 => => resolve docker.io/library/node:lts-buster@sha256:479103df06b40b90f189461b6f824a62906683e26a32c77d7c3e2d855a0e3  0.0s
 => [frontend internal] load build context                                                                             0.0s
 => => transferring context: 1.94kB                                                                                    0.0s
 => CACHED [frontend 2/6] WORKDIR /usr/src/app                                                                         0.0s
 => [frontend 3/6] COPY package.json /usr/src/app                                                                      0.0s
 => [frontend 4/6] COPY package-lock.json /usr/src/app                                                                 0.0s
 => [frontend 5/6] RUN npm ci                                                                                         24.4s
 => [frontend 6/6] COPY . /usr/src/app                                                                                 0.3s 
 => [frontend] exporting to docker image format                                                                       26.5s 
 => => exporting layers                                                                                                8.4s 
 => => exporting manifest sha256:c3639997f048e5adea7487bafdafaf4ea3f946e071fd273aefb262b72f2c87a8                      0.0s 
 => => exporting config sha256:1eb3a22fdb9d89316c9bdb1eb1d9f138e0f9545e95af4d812c9db8499309b491                        0.0s
 => => sending tarball                                                                                                18.1s
 => [frontend] importing to docker                                                                                    10.0s
 => => loading layer 7544a5e696a4 567B / 567B                                                                         10.0s
 => => loading layer 6e1b4449163b 32.77kB / 128.96kB                                                                   9.9s
 => => loading layer 874fffdf421f 115.87MB / 121.34MB                                                                  9.9s
 => => loading layer b8d4de9612f2 27.14kB / 27.14kB                                                                    0.0s
service "frontend" successfully built
```








