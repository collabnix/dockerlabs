## Mounting host directory into container

Execute the following commands:

```
mkdir test

docker system prune

docker volume prune

docker volume ls

docker run --env MESSAGE="GOOD Afternoon" --env FILENAME=afternoon_message\
 --mount type=bind,source="$(pwd)"/test,target=/data \
 sagarj/volume_test:1
 
 docker volume ls
 
 cd ./test
 
 ls
 
 cat afternoon_message
 ```
