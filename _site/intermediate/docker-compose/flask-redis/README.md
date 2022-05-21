# Building a Flask Application with a Redis Database

All necessary files are present in the same folder.

### Using docker-compose build 
Optional - we can directly use docker-compose up command too.
When we have a Dockerfile, we can use this command to build the image.

```
$ docker-compose build
redis uses an image, skipping
Building app
Step 1/7 : FROM python:3.7.0-alpine3.8
3.7.0-alpine3.8: Pulling from library/python
4fe2ade4980c: Pull complete
7cf6a1d62200: Pull complete
b66090d9998c: Pull complete
e0dc374a57ff: Pull complete
eb580e903ff2: Pull complete
Digest: sha256:e12594db7297ebf9d9478ba60373e0181974f373016e7495926a7da81bda323b
Status: Downloaded newer image for python:3.7.0-alpine3.8
 ---> cf41883b24b8
Step 2/7 : WORKDIR /usr/src/app
 ---> Running in f9129505dc4d
Removing intermediate container f9129505dc4d
 ---> ea78c5aa4566
Step 3/7 : COPY requirements.txt ./
 ---> 7bdd785ffedc
Step 4/7 : RUN pip install --no-cache-dir -r requirements.txt
 ---> Running in 508d45689aed
Collecting flask (from -r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/9a/74/670ae9737d14114753b8c8fdf2e8bd212a05d3b361ab15b44937dfd40985/Flask-1.0.3-py2.py3-none-any.whl (92kB)
Collecting redis (from -r requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/ac/a7/cff10cc5f1180834a3ed564d148fb4329c989cbb1f2e196fc9a10fa07072/redis-3.2.1-py2.py3-none-any.whl (65kB)
Collecting Jinja2>=2.10 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/1d/e7/fd8b501e7a6dfe492a433deb7b9d833d39ca74916fa8bc63dd1a4947a671/Jinja2-2.10.1-py2.py3-none-any.whl (124kB)
Collecting itsdangerous>=0.24 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/76/ae/44b03b253d6fade317f32c24d100b3b35c2239807046a4c953c7b89fa49e/itsdangerous-1.1.0-py2.py3-none-any.whl
Collecting click>=5.1 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/fa/37/45185cb5abbc30d7257104c434fe0b07e5a195a6847506c074527aa599ec/Click-7.0-py2.py3-none-any.whl (81kB)
Collecting Werkzeug>=0.14 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/9f/57/92a497e38161ce40606c27a86759c6b92dd34fcdb33f64171ec559257c02/Werkzeug-0.15.4-py2.py3-none-any.whl (327kB)
Collecting MarkupSafe>=0.23 (from Jinja2>=2.10->flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/b9/2e/64db92e53b86efccfaea71321f597fa2e1b2bd3853d8ce658568f7a13094/MarkupSafe-1.1.1.tar.gz
Installing collected packages: MarkupSafe, Jinja2, itsdangerous, click, Werkzeug, flask, redis
  Running setup.py install for MarkupSafe: started
    Running setup.py install for MarkupSafe: finished with status 'done'
Successfully installed Jinja2-2.10.1 MarkupSafe-1.1.1 Werkzeug-0.15.4 click-7.0 flask-1.0.3 itsdangerous-1.1.0 redis-3.2.1
You are using pip version 18.1, however version 19.1.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
Removing intermediate container 508d45689aed
 ---> ec5edcd6aa3b
Step 5/7 : COPY . .
 ---> 5e503f38f22b
Step 6/7 : ENV FLASK_APP=app.py
 ---> Running in 8607f291422f
Removing intermediate container 8607f291422f
 ---> ccf7a5e19f35
Step 7/7 : CMD flask run --host=0.0.0.0
 ---> Running in 5ef4038810ee
Removing intermediate container 5ef4038810ee
 ---> 669faab7e214
Successfully built 669faab7e214
Successfully tagged flask-redis:1.0

```

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
flask-redis         1.0                 669faab7e214        20 minutes ago      88.3MB
python              3.7.0-alpine3.8     cf41883b24b8        8 months ago        78.1MB
```

### Runnning the Application

```
$ docker-compose up -d
Creating network "flask-redis_default" with the default driver
Pulling redis (redis:4.0.11-alpine)...
4.0.11-alpine: Pulling from library/redis
4fe2ade4980c: Already exists
fb758dc2e038: Pull complete
989f7b0c858b: Pull complete
d5318f13abaa: Pull complete
3521559474dd: Pull complete
add04b113886: Pull complete
Creating flask-redis_redis_1 ... done
Creating flask-redis_app_1   ... done



[node2] (local) root@192.168.0.12 /test/Docker/Docker Compose/flask-redis
$ docker-compose ps
       Name                      Command               State           Ports
-------------------------------------------------------------------------------------
flask-redis_app_1     /bin/sh -c flask run --hos ...   Up      0.0.0.0:5000->5000/tcp
flask-redis_redis_1   docker-entrypoint.sh redis ...   Up      6379/tcp

```

### Testing the Application

1) Posting Data
```
$ curl --header "Content-Type: application/json" \
> --request POST \
> --data '{"name":"Prashansa"}' localhost:5000

{
  "name": "Prashansa"
}
```

2) Retrieving data

```
$ curl localhost:5000
[
  "\\{'name':Prashansa\\}"
]
```

![Port Exposed](https://github.com/Prashansa-K/Docker/blob/master/Docker%20Compose/flask-redis/5000%20port.png)


![Webpage](https://github.com/Prashansa-K/Docker/blob/master/Docker%20Compose/flask-redis/flask.png)

### Network Connectivity between Containers

```
$ docker network ls
NETWORK ID          NAME                        DRIVER              SCOPE
344ec39bd0ca        bridge                      bridge              local
aa7019865c83        flask-redis_default         bridge              local
8cea80409ff9        host                        host                local
dfd444fd66e5        none                        null                local
3f5442234fbd        wordpress-service_default   bridge              local
```

```
$ docker network inspect flask-redis_default
[
    {
        "Name": "flask-redis_default",
        "Id": "aa7019865c83f7b29728e7819906d14c2a48929c735245e4fd726353a7576225",
        "Created": "2019-06-11T09:24:41.672287478Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.27.0.0/16",
                    "Gateway": "172.27.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": true,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "42b9c0a8a397d15711305087e5e368b85648dea63098249ac7fff202eba1cadf": {
                "Name": "flask-redis_app_1",
                "EndpointID": "4b84d57e7c279fbaa59ac3a62447825892562c824f639dc9c2fd060ec2b749d9",
                "MacAddress": "02:42:ac:1b:00:03",
                "IPv4Address": "172.27.0.3/16",
                "IPv6Address": ""
            },
            "a4802d2e919bca73f2eb6d38d0f9235b22d27437d36e97289fb829adfd30881b": {
                "Name": "flask-redis_redis_1",
                "EndpointID": "08a48ca12f7818b642162d6567ceb0fcf3999bfeebae91904bb4d7b71dc9b4f2",
                "MacAddress": "02:42:ac:1b:00:02",
                "IPv4Address": "172.27.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {
            "com.docker.compose.network": "default",
            "com.docker.compose.project": "flask-redis",
            "com.docker.compose.version": "1.23.2"
        }
    }
]
```

## Rebuilding

Changes are done in Dockerfile and docker-compose.yml
The changed files are Dockerfile(2) and docker-compose(2).yml

```
[node2] (local) root@192.168.0.12 /test/Docker/Docker Compose/flask-redis
$ docker-compose build
redis uses an image, skipping
Building app
Step 1/8 : ARG PYTHON_VERSION
Step 2/8 : FROM python:$PYTHON_VERSION
 ---> cf41883b24b8
Step 3/8 : WORKDIR /usr/src/app
 ---> Using cache
 ---> cb8c9e8509f6
Step 4/8 : COPY requirements.txt ./
 ---> Using cache
 ---> b29e602ea6fd
Step 5/8 : RUN pip install --no-cache-dir -r requirements.txt
 ---> Using cache
 ---> 3b5c7e50cd31
Step 6/8 : COPY . .
 ---> f5176215a692
Step 7/8 : ENV FLASK_APP=app.py
 ---> Running in 17735a686036
Removing intermediate container 17735a686036
 ---> e2c1150cbedc
Step 8/8 : CMD flask run --host=0.0.0.0
 ---> Running in 18ba49b26f9e
Removing intermediate container 18ba49b26f9e
 ---> 61f7cc9a4fca
Successfully built 61f7cc9a4fca
Successfully tagged flask-redis:1.0
```

```
$ docker-compose up -d
Recreating flask-redis_app_1 ...
Recreating flask-redis_app_1 ... done
```

## Checking Logs

Logs of Both Services:

```
$ docker-compose logs -f
Attaching to flask-redis_app_1, flask-redis_redis_1
app_1    |  * Serving Flask app "app.py" (lazy loading)
app_1    |  * Environment: development
app_1    |  * Debug mode: on
app_1    |  * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
app_1    |  * Restarting with stat
app_1    |  * Debugger is active!
app_1    |  * Debugger PIN: 254-301-589
redis_1  | 1:C 11 Jun 09:24:42.598 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
redis_1  | 1:C 11 Jun 09:24:42.598 # Redis version=4.0.11, bits=64, commit=00000000, modified=0, pid=1, just started
redis_1  | 1:C 11 Jun 09:24:42.598 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
redis_1  | 1:M 11 Jun 09:24:42.602 * Running mode=standalone, port=6379.
redis_1  | 1:M 11 Jun 09:24:42.602 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
redis_1  | 1:M 11 Jun 09:24:42.602 # Server initialized
redis_1  | 1:M 11 Jun 09:24:42.602 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
redis_1  | 1:M 11 Jun 09:24:42.602 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis mustbe restarted after THP is disabled.
redis_1  | 1:M 11 Jun 09:24:42.602 * Ready to accept connections

app_1    | 172.18.0.1 - - [11/Jun/2019 09:53:06] "GET / HTTP/1.1" 200 -

```

Logs of a particular service:

```
[node2] (local) root@192.168.0.12 /test/Docker/Docker Compose/flask-redis
$ docker-compose logs -f app
Attaching to flask-redis_app_1
app_1    |  * Serving Flask app "app.py" (lazy loading)
app_1    |  * Environment: development
app_1    |  * Debug mode: on
app_1    |  * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
app_1    |  * Restarting with stat
app_1    |  * Debugger is active!
app_1    |  * Debugger PIN: 254-301-589
app_1    | 172.18.0.1 - - [11/Jun/2019 09:53:06] "GET / HTTP/1.1" 200 -
```

## Pausing Services

```
[node2] (local) root@192.168.0.12 /test/Docker/Docker Compose/flask-redis
$ docker-compose pause
Pausing flask-redis_redis_1 ... done
Pausing flask-redis_app_1   ... done


[node2] (local) root@192.168.0.12 /test/Docker/Docker Compose/flask-redis
$ docker-compose ps
       Name                   Command            State            Ports
--------------------------------------------------------------------------------
flask-redis_app_1     /bin/sh -c flask run       Paused   0.0.0.0:5000->5000/tcp
                      --hos ...
flask-redis_redis_1   docker-entrypoint.sh       Paused   6379/tcp
                      redis ...

```

## Unpausing services

```
$ docker-compose unpause
Unpausing flask-redis_app_1   ... done
Unpausing flask-redis_redis_1 ... done
[node2] (local) root@192.168.0.12 /test/Docker/Docker Compose/flask-redis


$ docker-compose ps
       Name                    Command            State           Ports
--------------------------------------------------------------------------------
flask-redis_app_1     /bin/sh -c flask run        Up      0.0.0.0:5000->5000/tcp
                      --hos ...
flask-redis_redis_1   docker-entrypoint.sh        Up      6379/tcp
                      redis ...
```

## Executing commands in a running service container

```
$ docker-compose exec redis redis-cli lrange students 0 -1
1) "\\{'name':Prashansa\\}"



$ docker-compose exec app /bin/sh
/usr/src/app # ls
--data              __pycache__         requirements.txt
--request           app.py
Dockerfile          docker-compose.yml
/usr/src/app # ls -al
total 16
-rw-r--r--    1 root     root             0 Jun 11 09:00 --data
-rw-r--r--    1 root     root             0 Jun 11 09:00 --request
drwxr-xr-x    1 root     root            25 Jun 11 09:52 .
drwxr-xr-x    1 root     root            17 Jun 11 09:29 ..
-rw-r--r--    1 root     root           210 Jun 11 09:43 Dockerfile
drwxr-xr-x    2 root     root            32 Jun 11 09:52 __pycache__
-rw-r--r--    1 root     root           505 Jun 11 09:29 app.py
-rw-r--r--    1 root     root           281 Jun 11 09:42 docker-compose.yml
-rw-r--r--    1 root     root            12 Jun 11 07:51 requirements.txt
/usr/src/app # ps
PID   USER     TIME  COMMAND
    1 root      0:00 {flask} /usr/local/bin/python /usr/local/bin/flask run --h
    7 root      0:03 {flask} /usr/local/bin/python /usr/local/bin/flask run --h
   24 root      0:00 /bin/sh
   31 root      0:00 ps
/usr/src/app # exit
[node2] (local) root@192.168.0.12 /test/Docker/Docker Compose/flask-redis
```

## Running a new container of a pre-defined service

```
$ docker-compose run app /bin/sh
/usr/src/app # ls
--data              Dockerfile          docker-compose.yml
--request           app.py              requirements.txt
/usr/src/app #




$ docker-compose ps
         Name                   Command           State           Ports
--------------------------------------------------------------------------------
flask-redis_app_1        /bin/sh -c flask run     Up      0.0.0.0:5000->5000/tcp
                         --hos ...
flask-redis_app_run_b8   /bin/sh                  Up
799ec348ac
flask-redis_redis_1      docker-entrypoint.sh     Up      6379/tcp
                         redis ...
```

With run, port-mapping is not applied to avoid port-conflicts.


## Pushing to Docker Registry
 
 ```
 $ docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: prashansa1998
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded




[node2] (local) root@192.168.0.12 /test/Docker/Docker Compose/flask-redis
$ docker-compose push
Pushing app (prashansa1998/flask-redis:1.0)...
The push refers to repository [docker.io/prashansa1998/flask-redis]
fb394277e3aa: Pushed
3848f16c304b: Pushed
3b2166302a6f: Pushed
a4a40437c4ee: Pushed
3b3df229744d: Mounted from library/python
6795dbd93463: Mounted from library/python
e2986b5e7ba2: Mounted from library/python
beefb6beb20f: Mounted from library/python
df64d3292fd6: Mounted from library/redis
1.0: digest: sha256:e32a248711095725572b1f0850aad25ffbf6a459931e632cf2d57826d27d57e2 size: 2200
 ```
 
Now, we can build the same application stack on another machine by pulling it.

First, transfer compose file to the new machine. You can use SCP for this.

```
[node2] (local) root@192.168.0.12 /test/Docker/Docker Compose/flask-redis
$ scp docker-compose.yml root@192.168.0.11:/root
The authenticity of host '192.168.0.11 (192.168.0.11)' can't be established.
RSA key fingerprint is SHA256:Vhwhn289853wPTtkgw7ZBUwsJfDwSiviUQmdhFg304I.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.0.11' (RSA) to the list of known hosts.
docker-compose.yml                                                             100%  295   358.3KB/s   0.3KB/s   00:00
[node2] (local) root@192.168.0.12 /test/Docker/Docker Compose/flask-redis
```

```
$ ls
docker-compose.yml
[node3] (local) root@192.168.0.11 ~
$ docker-compose pull
Pulling app   ... done
Pulling redis ... done
```

```
[node3] (local) root@192.168.0.11 ~
$ docker-compose up -d
Creating network "root_default" with the default driver
Creating root_app_1   ... done
Creating root_redis_1 ... done
[node3] (local) root@192.168.0.11 ~
$ docker-compose ps
    Name                  Command               State           Ports
------------------------------------------------------------------------------
root_app_1     /bin/sh -c flask run --hos ...   Up      0.0.0.0:5000->5000/tcp
root_redis_1   docker-entrypoint.sh redis ...   Up      6379/tcp
```

```

[node3] (local) root@192.168.0.11 ~
$ curl --header "Content-Type: application/json" \
> --request POST \
> --data '{"name":"Prashi"}' localhost:5000
{
  "name": "Prashi"
}

```

Hence, the same application was built and accessed on another machine too.

## Contributor

[Prashansa Kulshrestha](https://github.com/Prashansa-K)


 
 
