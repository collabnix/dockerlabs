### ONBUILD Making wedding clothes for others

Format: `ONBUILD <other instructions>`.

`ONBUILD` is a special instruction, followed by other instructions, such as `RUN`, `COPY`, etc., and these instructions will not be executed when the current image is built. Only when the current image is mirrored, the next level of mirroring will be executed.

The other instructions in `Dockerfile` are prepared to customize the current image. Only `ONBUILD` is prepared to help others customize themselves.

Suppose we want to make an image of the application written by Node.js. We all know that Node.js uses `npm` for package management, and all dependencies, configuration, startup information, etc. are placed in the `package.json` file. After getting the program code, you need to do `npm install` first to get all the required dependencies. Then you can start the app with `npm start`. Therefore, in general, `Dockerfile` will be written like this:

```Dockerfile
FROM node:slim
RUN mkdir /app
WORKDIR /app
COPY ./package.json /app
RUN [ "npm", "install" ]
COPY . /app/
CMD [ "npm", "start" ]
```

Put this `Dockerfile` in the root directory of the Node.js project, and after building the image, you can use it to start the container. But what if we have a second Node.js project? Ok, then copy this `Dockerfile` to the second project. If there is a third project? Copy it again? The more copies of a file, the more difficult it is to have version control, so let's continue to look at the maintenance of such scenarios.

If the first Node.js project is in development, I find that there is a problem in this `Dockerfile`, such as typing a typo, or installing an extra package, then the developer fixes the `Dockerfile`, builds it again, and solves the problem. The first project is ok, but the second one? Although the original `Dockerfile` was copied and pasted from the first project, it will not fix their `Dockerfile` because the first project, and the `Dockerfile` of the second project will be automatically fixed.

So can we make a base image, and then use the base image for each project? In this way, the basic image is updated, and each project does not need to synchronize the changes of `Dockerfile`. After rebuilding, it inherits the update of the base image. Ok, yes, let's see the result. Then the above `Dockerfile` will become:

```Dockerfile
FROM node:slim
RUN mkdir /app
WORKDIR /app
CMD [ "npm", "start" ]
```

Here we take out the project-related build instructions and put them in the subproject. Assuming that the name of the base image is `my-node`, the own `Dockerfile` in each project becomes:

```Dockerfile
FROM my-node
```

Yes, there is only one such line. When constructing a mirror with this one-line `Dockerfile` in each project directory, the three lines of the previous base image `ONBUILD` will start executing, successfully copy the current project code into the image, and execute for this project. `npm install`, generate an application image.

## Contributor - [Sangam Biradar](https://www.linkedin.com/in/sangambiradar14/)
