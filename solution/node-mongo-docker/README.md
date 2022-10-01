# Creating a REST API using Node.JS, MongoDB and Docker


## Building from Scratch

### Create a directory

```
 mkdir node-mongo-docker
```

### Initialize 

```
 cd node-mongo-docker
 npm init -y
```
 
```
 Wrote to /../../node-mongo-docker/package.json:

{
  "name": "mongo-docker",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/dockersamples/node-mongo-docker.git"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "bugs": {
    "url": "https://github.com/dockersamples/node-mongo-docker/issues"
  },
  "homepage": "https://github.com/dockersamples/node-mongo-docker#readme"
}
```





```
 npm install ronin-server ronin-mocks

added 117 packages, and audited 118 packages in 6s

7 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
```


## Creating server.js

Now, let’s add some code to handle our REST requests. We’ll use a mock server so we can focus on Dockerizing the application.

Open this working directory in your IDE and add the following code into the server.js file.


```
const ronin = require('ronin-server')
const mocks = require('ronin-mocks')

const server = ronin.server()

server.use('/', mocks.server(server.Router(), false, true))
server.start()
```


## Testing the application


Let’s start our application and make sure it’s running properly. Open your terminal and navigate to your working directory you created.

```
 node server.js
```

Let's open the new terminal and test it

```
curl --request POST \
  --url http://localhost:8000/test \
  --header 'content-type: application/json' \
  --data '{"msg": "testing" }'
```

## Results:

```
{"code":"success","payload":[{"msg":"testing","id":"fdf077e5-9606-471d-a5ab-e6ec11e7f3e4","createDate":"2022-09-07T09:38:49.818Z"}]}%
```

## Bring up the containers


```
 docker compose up -d
```


