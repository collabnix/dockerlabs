
# Demonstrating Docker-Ready Solution for Django & PostgreSQL


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


## Setup

Follow the below instructions.

1. Cloning the Repository

```
git clone https://github.com/collabnix/dockerlabs
cd dockerlabs/solution/django-postgres/

```

## Running Docker container

```
docker-compose run web django-admin.py startproject composeexample .
```

Once you run the above command, you might see containers coming up and running. Soon you will see port:8080 getting displayed on the top of PWD screen. Once clicked it might throw an error 

```
"DisallowedHost at /
Invalid HTTP_HOST header: 'ip172-19-0-28-bfn8rk49cs9g00f9usn0-8000.direct.labs.play-with-docker.com'. You may need to add 'ip172-19-0-28-bfn8rk49cs9g00f9usn0-8000.direct.labs.play-with-docker.com' to ALLOWED_HOSTS."
```
 
To fix this issue, follow the below steps:

2. Now there will be below folders and files present inside project folder

 
 ```
 ls
  composeexample
  docker-compose.yml
  Dockerfile
  manage.py
  requirements.txt
```

## Configuring the settings

Inside composeexample/settings.py, Add below line at the end of the file. please change FQDN,IP according to your system.

```
ALLOWED_HOSTS = ['ip172-18-0-11-bfleibmac3u0009ab2vg-8000.direct.labs.play-with-docker.com', 'localhost', '127.0.0.1', '198.211.99.20']
```

Edit the composeexample/settings.py file and Replace the DATABASES = ... with the following and save the file

 ```
 'ENGINE': 'django.db.backends.postgresql',
 'NAME': 'postgres',
 'USER': 'postgres',
  'HOST': 'db',
  PORT': 5432,
```

## Brining up the Application Stack

Now it's time to bring up Application Stack flawlessly. 

```
curl "http://0.0.0.0:8080/
```

## Contributor

[Balasundaram Natarajan](mailto:balasundarammaster@gmail.com)
