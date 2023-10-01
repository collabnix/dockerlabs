# Running a command inside running Container

## Tested Infrastructure

| **Platform**         | **Number of Instance** | **Reading Time** |
| -------------------- | ---------------------- | ---------------- |
| **Play with Docker** | **1**                  | **5 min**        |

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com/)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side

## Create Ubuntu Container

```
docker run -dit ubuntu
```

## Opening up the bash shell

```
docker exec -t <container-id> bash
```
