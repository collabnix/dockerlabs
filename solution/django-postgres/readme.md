# Demonstrating Django Postgres Example


## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Play with Docker</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    </tr>
  </table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side


## Running Hello World Example



```
$ docker run hello-world

```

![alt text](https://github.com/collabnix/dockerlabs/blob/master/beginners/images/b301_helloworld.png)



Once the basic setup is ready, please follow the below instructions.

1. Create a project folder and keep requirements.txt,docker-compose.yml,Dockerfile in a directory and run below command

sudo docker-compose run web django-admin.py startproject composeexample .

2. Now there will be below folders and files present inside project folder

 $ ls -l
  composeexample
  docker-compose.yml
  Dockerfile
  manage.py
  requirements.txt

3. Inside composeexample/settings.py, Add below line at the end of the file. please change FQDN,IP according to your system.

ALLOWED_HOSTS = ['ip172-18-0-11-bfleibmac3u0009ab2vg-8000.direct.labs.play-with-docker.com', 'localhost', '127.0.0.1', '198.211.99.20']

4. Edit the composeexample/settings.py file and Replace the DATABASES = ... with the following and save the file

        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',
        'USER': 'postgres',
        'HOST': 'db',
        'PORT': 5432,

5. run docker-compose up and 8080 port is open. pl try curl "http://0.0.0.0:8080/
