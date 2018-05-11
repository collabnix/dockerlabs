
## Creating a Dockerfile which set up a simple webpage.

First, we will build a Docker Image shown below:

```
master==> git clone https://github.com/ajeetraina/docker101/tree/master/105-website
master==> cd 105-website
```

```
master==>docker build -t ajeetraina/nginx-demo-105 .
```

```
master==>docker images
REPOSITORY                        TAG                 IMAGE ID            CREATED             SIZE
ajeetraina/nginx_105_demo         latest              c6c187264fad        7 seconds ago       182 MB
Running the Container:
```
```
master==>docker run -d -P --name myweb ajeetraina/nginx-demo-105
d30904aa94a4615045a2962c3fd15f02bcd82c1b7371f927f77923d60f014645
```

## Verifying if Container is running or not:

```
master==>docker ps
CONTAINER ID        IMAGE                       COMMAND             CREATED             STATUS              PORTS                           
                NAMES
d30904aa94a4        ajeetraina/nginx-demo-105   "./wrapper.sh"      3 seconds ago       Up 2 seconds        0.0.0.0:32782->80/tcp, 0.0.0.0:3
2781->443/tcp   myweb
```

Did you encounter this error while cloning and building the Docker Image:

```
docker: Error response from daemon: oci runtime error: container_linux.go:247: starting container process caused "exec: \"./wrapper.sh\": pe
rmission denied".
This is due to permission issue. The wrapper.sh script possibly doesn't have executable permission. Run chmod +x wrapper.sh and re-build the Docker Image.
```

## Displaying Container Ports:

```
master==>docker port d3090
80/tcp -> 0.0.0.0:32782
443/tcp -> 0.0.0.0:32781
```
You can open http://localhost:32769 in your browser.

If you want to run Nginx in your desired port, here is the way:

```
master==>docker run -d -p   8888:80 ajeetraina/nginx-demo-105
beb4fa77b033fb46e9f772110cfcd65e9656af0212931e674a1f2bd34422d478
master==>docker ps
CONTAINER ID        IMAGE                       COMMAND             CREATED             STATUS              PORTS                           
NAMES
beb4fa77b033        ajeetraina/nginx-demo-105   "./wrapper.sh"      7 seconds ago       Up 5 seconds        443/tcp, 0.0.0.0:8888->80/tcp   
gifted_almeida
```
