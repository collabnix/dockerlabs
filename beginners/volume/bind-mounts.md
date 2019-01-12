## Mounting host directory into container

Execute the following commands:


## Creating "test" directory
```
mkdir test
```


## Cleaning the system
```
docker system prune
```

## Cleaning the Volumes

```
docker volume prune
```

## Listing out the Volumes


```
docker volume ls
```


## Mounting host directory into container


```
docker run --env MESSAGE="GOOD Afternoon" --env FILENAME=afternoon_message\
 --mount type=bind,source="$(pwd)"/test,target=/data \
 sagarj/volume_test:1
```

## Verifying the Docker Volume

```
docker volume ls
```

# Verifying the File placed in container sitting on Host console

```
cd ./test
```

```
ls
```

```
cat afternoon_message
 ```
