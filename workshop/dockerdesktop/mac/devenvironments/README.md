Dev Environments lets you create a configurable developer environment with all the code and tools you need to quickly get up and running. It helps in the following ways:

- Uses a container locally as a full development environment.

- Allows developers to share code (including dependencies) with your team members in one click.

- Move quickly between branches or run them side by side in VSCode.

It uses tools built into code editors that allow Docker to access code mounted into a container rather than on your local host. This isolates the tools, files and running services on your machine allowing multiple versions of them to exist side by side.

Let us understand Docker Dev Environments by quickly test driving Slack Clone project repository. The project is hosted [here](https://github.com/dockersamples/slack-clone-docker).


## Pre-requisite:

- [Install Docker Desktop](https://docs.docker.com/desktop/install/mac-install/) 

## Getting Started

You can locate Dev Environments by 
accessing the left pane of the Docker dashboard.



![Image2](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/oenqoy42jccim8xriomp.png)

Click "Get Started". Enter the full GitHub URL of your project.


![Image3](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/8dp4izp4dm1fppiccwtm.png)

As soon as you click on "Continue" button, the following operations gets executed in the background:


- It clones the repo inside a volume.
- Determine the best image for your Dev environment
- Installs Credential Helper
- Clone the repository into '/com.docker.devenvironments.code’.
- Runs .docker migration
- It detects the main language of your repository
- Brings up the container services


![Image5](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/3ntzuxbe02xgruteb642.png)


Now it allows you to open the project inside the Dev Environment container.

![Image6](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/2503hohhabxto22yi895.png)

Next it opens VS Code inside the dev environment container. Click on "Open in VS Code".


![Image7](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/xzigzkzblhq8mvfhcrup.png)


## Viewing in Docker Dashboard

![Image8](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/yhi2h9cj4x1o7o8dy7f8.png)


## Accessing the CLI


![Image9](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/wjndx8c76ofwnbmjfwr3.png)

## Running the Slack Clone app

![Image10](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/rxwokvde9xaqmsvyn7nq.png)

## Forwarding the port 3000


![Image11](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/1b1avc2aav1zh62v5p6c.png)




## Accessing the Slack UI

You can open up `https://localhost:3000` to access the Slack app.

![Image12](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/y50xgcpxg1dyp1pejlvq.png)

## References

- [Overview of Dev Environments](https://docs.docker.com/desktop/dev-environments/)
- [Distribute Your Dev Environments](https://docs.docker.com/desktop/dev-environments/share/)

## Getting Help

Have a question about Dev Environments? Search the Docker Forum Dev Environment tag for answers, or post a question in our [Docker Community Forum](https://forums.docker.com).
