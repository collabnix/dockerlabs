# Working with Docker Images

## Tested Infrastructure

| **Platform**         | **Number of Instance** | **Reading Time** |
| -------------------- | ---------------------- | ---------------- |
| **Play with Docker** | **1**                  | **5 min**        |

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com/)

## Listing the Docker Images

![](image/hello-world/docker_images.png)

## Show all images (default hides intermediate images)

![](image/working_wth_docker_img/doc_images_all.png)

# List images by name and tag

The docker images command takes an optional [REPOSITORY[:TAG]] argument that restricts the list to images that match the argument. If you specify REPOSITORY but no TAG, the docker images command lists all images in the given repository.

To demo this, let us pull all various versions of alpine OS

![](image/working_wth_docker_img/alpine.png)

## List the full length image IDs

![](image/working_wth_docker_img/no-trunc.png)

# Listing out images with filter

![](image/working_wth_docker_img/filter.png)

## Explanation

The [REPOSITORY[:TAG]] value must be an “exact match”.
