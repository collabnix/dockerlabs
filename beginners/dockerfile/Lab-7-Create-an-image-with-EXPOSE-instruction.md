# Lab #7: Create a Docker image with EXPOSE instruction

## Pre-requisite:

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


## Assignment:

- Create an image with expose instruction
- Create hello.py 
- Create dockerfile 
- Build dockerfile 
-  Run application 




## Creating directory 

``` 
mkdir pythonexposeapp 
cd pythonexposeapp

```

## Creating hello.py 

``` vi hello.py ```

```
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "welcome to Dockerlabs!! successfully done !!"

if __name__ == "__main__":
    app.run() 

```
## Creating Dockerfile
```
vi Dockerfile

```
```
FROM python:3.5

# Update and install dependencies
RUN apt-get update
RUN pip install Flask

# Add code
ADD . /opt/webapp/

# Set the working directory
WORKDIR /opt/webapp

# Set environment variables
ENV FLASK_APP=hello.py

# Expose the application's port
EXPOSE 5000

# Run the application
CMD ["flask", "run", "--host=0.0.0.0"]


```

## Building Dockerfile 

```
 docker build -t pythonapp:v1 .
```

## Running Docker image 

```
sangam$ docker run -p 5000:5000 pythonapp:v1
 * Serving Flask app "hello.py"
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
172.17.0.1 - - [17/Aug/2019 12:21:20] "GET / HTTP/1.1" 200 -
172.17.0.1 - - [17/Aug/2019 12:21:20] "GET /favicon.ico HTTP/1.1" 404 -

```

By now, the application should be accessible `http://0.0.0.0:5000/`

# Contibutor

[Sangam Biradar](https://github.com/sangam14)

Next >> [VOLUME_instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/Lab%2310:VOLUME_instruction.html)
