
#  Create an image with EXPOSE instruction

# create directory `mkdir pythonexposeapp`

# `vi hello.py` 

```from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "welcome to Dockerlabs!! successfully done !!"

if __name__ == "__main__":
    app.run()```

```
# create dockerfile 
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

# build dockerfile 

```
 docker build -t pythonapp .
```

# 

```
sangam$ docker run -p 5000:5000 pythonapp
 * Serving Flask app "hello.py"
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
172.17.0.1 - - [17/Aug/2019 12:21:20] "GET / HTTP/1.1" 200 -
172.17.0.1 - - [17/Aug/2019 12:21:20] "GET /favicon.ico HTTP/1.1" 404 -

```

Application is runing in browser `http://0.0.0.0:5000/`

