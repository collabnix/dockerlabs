<img width="899" alt="image" src="https://user-images.githubusercontent.com/313480/212123774-3b1127f4-fbb5-4445-aad5-13c38065f1aa.png">


<img width="899" alt="image" src="https://user-images.githubusercontent.com/313480/212123881-08dd6028-80a8-45d0-98cd-7893910c3fce.png">

<img width="876" alt="image" src="https://user-images.githubusercontent.com/313480/212124318-a9290e24-ddbc-416a-9ad4-73b912f92afa.png">


<img width="893" alt="image" src="https://user-images.githubusercontent.com/313480/212123961-8a984900-9710-4ed3-a9a7-1c821a975beb.png">


<img width="871" alt="image" src="https://user-images.githubusercontent.com/313480/212124039-1498f0bd-29d0-4b1e-b9a0-22a77f35c92a.png">





Dev Environments lets you create a configurable developer environment with all the code and tools you need to quickly get up and running. It helps in the following ways:

- Uses a container locally as a full development environment.

- Allows developers to share code (including dependencies) with your team members in one click.

- Move quickly between branches or run them side by side in VSCode.

It uses tools built into code editors that allow Docker to access code mounted into a container rather than on your local host. This isolates the tools, files and running services on your machine allowing multiple versions of them to exist side by side.

Let us understand Docker Dev Environments by quickly test driving Slack Clone project repository. The project is hosted [here](https://github.com/dockersamples/slack-clone-docker).


## Pre-requisite:

- [Install Docker Desktop](https://docs.docker.com/desktop/install/mac-install/) 

## Getting Started


- [Using Dashboard UI](https://github.com/collabnix/dockerlabs/blob/master/workshop/dockerdesktop/mac/devenvironments/README.md#using-dashboard-ui)
- [Using CLI](https://github.com/collabnix/dockerlabs/edit/master/workshop/dockerdesktop/mac/devenvironments/README.md#using-cli)


## Using Dashboard UI

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


## Using CLI

## Test driving Docker Dev Environment CLI

Ensure that you have the latest version of Docker Desktop 4.13.0+ up and running on your laptop.

```
% docker dev

Usage:  docker dev [OPTIONS] COMMAND

Docker Dev Environments CLI interface

Options:
  -s, --socket string   Sets the path to the unix socket or pipe to be
                        targeted. Can also be set through the environment
                        variable DOCKER_DEV_ENVS_SOCKET_PATH
  -v, --version         Display version of the dev plugin

Management Commands:
  service     Service management on a dev environment

Commands:
  check       Check Dev Environments
  create      Create a new dev environment
  list        Lists all Dev Environments
  logs        Traces logs from a dev environment
  open        Open Dev Environment with the IDE
  rm          Removes a dev environment
  start       Starts a dev environment
  stop        Stops a dev environment
  version     Show the Docker Dev version information

Run 'docker dev COMMAND --help' for more information on a command.
unknown docker command: dev []

```

## Viewing the Docker Dev version information

```
docker dev version
Version:    v0.0.3
Git commit: 2fdb7c4
```




## Checking the Dev Environments


```
docker dev check
GIT         VSCODE        REMOTE_CONTAINERS
true        true          true
```

## Listing the existing Dev Environments

```
docker dev list 
NAME        STATUS
```

## Creating a New Dev Environment

```
docker dev create --help

Usage:  docker dev create [OPTIONS] REPOSITORY_URL

Create a new dev environment

Aliases:
  create, new

Options:
  -d, --detach   Detach creates a Dev Env without attaching to it's logs
  -o, --open     Open IDE after a successful creation
```

## Cloning the Awesome-compose Repository

With over 18,700 stars and 2,900 forks, awesome-compose is a popular Docker repository that contains a curated list of Docker Compose samples. It helps developers learn about Docker Compose by providing a starting point for integrating different services using a Compose file and managing their deployment with Docker Compose. This project is hosted over Docker GitHub organization, Inc and publicly open for the community to contribute and submit their compose file.

Let us pick up a sample [Python/Flask app using a Redis database](https://github.com/docker/awesome-compose/tree/master/flask-redis).

```

docker dev create https://github.com/docker/awesome-compose/tree/master/flask-redis
```

Results:

```
awesome-compose-beautiful_moser
Preparing to clone inside a volume
Installing credential helpers... 
done
Cloning into '/com.docker.devenvironments.code'...
Running .docker migration
Migration: no config.json detected
Migration: project is already configured for dev envs
building compose stack
2022/10/23 16:21:09 INFO: [core] [Channel #1] Channel created
2022/10/23 16:21:09 INFO: [core] [Channel #1] original dial target is: "unix:///run/buildkit/buildkitd.sock"
2022/10/23 16:21:09 INFO: [core] [Channel #1] parsed dial target is: {Scheme:unix Authority: Endpoint:run/buildkit/buildkitd.sock URL:{Scheme:unix Opaque: User: Host: Path:/run/buildkit/buildkitd.sock RawPath: OmitHost:false ForceQuery:false RawQuery: Fragment: RawFragment:}}
2022/10/23 16:21:09 INFO: [core] [Channel #1] Channel authority set to "localhost"
2022/10/23 16:21:09 INFO: [core] [Channel #1] Resolver state updated: {
  "Addresses": [
    {
      "Addr": "/run/buildkit/buildkitd.sock",
      "ServerName": "",
      "Attributes": {},
      "BalancerAttributes": null,
      "Type": 0,
      "Metadata": null
    }
  ],
  "ServiceConfig": null,
  "Attributes": null
} (resolver returned new addresses)
2022/10/23 16:21:09 INFO: [core] [Channel #1] Channel switches to new LB policy "pick_first"
2022/10/23 16:21:09 INFO: [core] [Channel #1 SubChannel #2] Subchannel created
2022/10/23 16:21:09 INFO: [core] [Channel #1 SubChannel #2] Subchannel Connectivity change to CONNECTING
2022/10/23 16:21:09 INFO: [core] [Channel #1 SubChannel #2] Subchannel picks a new address "/run/buildkit/buildkitd.sock" to connect
2022/10/23 16:21:09 INFO: [core] pickfirstBalancer: UpdateSubConnState: 0x14000722880, {CONNECTING <nil>}
2022/10/23 16:21:09 INFO: [core] blockingPicker: the picked transport is not ready, loop back to repick
2022/10/23 16:21:09 INFO: [core] [Channel #1] Channel Connectivity change to CONNECTING
2022/10/23 16:21:09 INFO: [core] [Channel #1 SubChannel #2] Subchannel Connectivity change to READY
2022/10/23 16:21:09 INFO: [core] pickfirstBalancer: UpdateSubConnState: 0x14000722880, {READY <nil>}
2022/10/23 16:21:09 INFO: [core] [Channel #1] Channel Connectivity change to READY
2022/10/23 16:21:09 INFO: [core] [Server #4] Server created
2022/10/23 16:21:09 INFO: [core] [Server #5] Server created
#1 [internal] load .dockerignore

```

Wait for few seconds and check the status of the Dev Environment.

## Verifying the Dev Environment status

```
docker dev ls
NAME                                   STATUS
awesome-compose-beautiful_moser        running
```

Wait for few seconds and you will see that the application is accessible via http://localhost:8000


![Image7](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/opfm0l21tsszguen8fsf.png)

You can verify Dev Environment under Docker Dashboard too.


![Image9](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/k85lyiid5srhyguxyg2z.png)



## References

- [Overview of Dev Environments](https://docs.docker.com/desktop/dev-environments/)
- [Distribute Your Dev Environments](https://docs.docker.com/desktop/dev-environments/share/)

## Getting Help

Have a question about Dev Environments? Search the Docker Forum Dev Environment tag for answers, or post a question in our [Docker Community Forum](https://forums.docker.com).
