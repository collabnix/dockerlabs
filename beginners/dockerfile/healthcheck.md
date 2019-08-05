# HEALTHCHECK Health Check

format:

`HEALTHCHECK [options] CMD <command>`: set the command to check the health of the container
HEALTHCHECK NONE: If the base image has a health check command, use this line to mask its health check command.
The HEALTHCHECK directive tells Docker how to determine if the state of the container is normal. This is a new directive introduced by Docker 1.12.

Before the HEALTHCHECK directive, the Docker engine can only determine if the container is in a state of abnormality by whether the main process in the container exits. In many cases, this is fine, but if the program enters a deadlock state, or an infinite loop state, the application process does not exit, but the container is no longer able to provide services. Prior to 1.12, Docker did not detect this state of the container and would not reschedule it, causing some containers to be unable to serve, but still accepting user requests.

Since 1.12, Docker has provided the HEALTHCHECK instruction, which specifies a line of commands to determine whether the service state of the container's main process is still normal, thus comparing the actual state of the actual reaction container.

When a HEALTHCHECK instruction is specified in an image, the container is started with it, the initial state will be starting, and will become healthy after the HEALTHCHECK instruction is checked successfully. If it fails for a certain number of times, it will become unhealthy.

HEALTHCHECK supports the following options:

`--interval=<interval>`: interval between two health checks, the default is 30 seconds;
`--timeout=<time length>`: The health check command runs the timeout period. If this time is exceeded, the health check is regarded as a failure. The default is 30 seconds.
`--retries=<number>`: When the specified number of consecutive failures, the container status is treated as unhealthy, the default is 3 times.
Like CMD, ENTRYPOINT, HEALTHCHECK can only appear once. If more than one is written, only the last one will take effect.

The commands following the HEALTHCHECK [options] CMD, in the same format as ENTRYPOINT, are divided into shell format, and exec format. The return value of the command determines the success or failure of the health check: 0: success; 1: failure; 2: reservation, do not use this value.

Suppose we have a mirror that is the simplest Web service. We want to add a health check to determine if its Web service is working. We can use curl to help determine the HEALTHCHECK of its Dockerfile:
```
FROM nginx
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
HEALTHCHECK --interval=5s --timeout=3s \
  CMD curl -fs http://localhost/ || exit 1
  ```
Here we set a check every 5 seconds (here the interval is very short for the test, it should be relatively long), if the health check command does not respond for more than 3 seconds, it is considered a failure, and use curl -fs http://localhost/ || exit 1 As a health check command.

Use docker build to build this image:
```
$ docker build -t myweb:v1 .
After building it, we start a container:
```
```
$ docker run -d --name web -p 80:80 myweb:v1
```
After running the image, you can see the initial state as (health: starting) through docker container ls:
```
$ docker container ls
```
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
03e28eb00bd0 myweb:v1 "nginx -g 'daemon off" 3 seconds ago Up 2 seconds (health: starting) 80/tcp, 443/tcp web
After waiting a few seconds, docker container ls again, you will see the health status change (healthy):
```
$ docker container ls
```
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
03e28eb00bd0 myweb:v1 "nginx -g 'daemon off" 18 seconds ago Up 16 seconds (healthy) 80/tcp, 443/tcp web
If the health check fails continuously for more than the number of retries, the status changes to (unhealthy).

To help with troubleshooting, the output of the health check command (including `stdout` and `stderr`) is stored in a healthy state and can be viewed with docker inspect.
```
$ docker inspect --format '{{json .State.Health}}' web | python -m json.tool
{
    "FailingStreak": 0,
    "Log": [
        {
            "End": "2019-07-4T14:35:37.940957051Z",
            "ExitCode": 0,
            "Output": "<!DOCTYPE html>\n<html>\n<head>\n<title>Welcome to nginx!</title>\n<style>\n body {\n width: 35em;\n Margin: 0 auto;\n font-family: Tahoma, Verdana, Arial, sans-serif;\n }\n</style>\n</head>\n<body>\n<h1>Welcome to nginx! </h1>\n<p>If you see this page, the nginx web server is successfully installed and\nworking. Further configuration is required.</p>\n\n<p>For online documentation and support please refer to \n<a href=\"http://nginx.org/\">nginx.org</a>.<br/>\nCommercial support is available at\n<a href=\"http://nginx .com/\">nginx.com</a>.</p>\n\n<p><em>Thank you for using nginx.</em></p>\n</body>\n </html>\n",
            "Start": "2019-07-4T14:35:37.940957051Z"
        }
    ],
    "Status": "healthy"
}
```

## Contributor - [Sangam Biradar](https://www.linkedin.com/in/sangambiradar14/)
