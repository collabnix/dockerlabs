---
title: "How to build and test AWS Cloud applications with LocalStack and Docker"
---

This repo contains the sample application for [Building and testing Cloud applications with LocalStack and Docker guide on Docker Docs](https://github.com/ajeetraina/todo-list-localstack-docker).
This simple to-do List application allows developers to upload images to S3-emulated LocalStack.

Notice: This sample repo is intended to support the guide mentioned above. As such, the application code is purposely kept simple to keep the focus on the guide's content and should not be considered production ready.

## Tech Stack

<img width="806" alt="image" src="https://github.com/user-attachments/assets/496c7685-87e9-4f87-aaa7-69e46a3c0b5a">




- Frontend: React, Material UI.
- Backend: Node.js, Express
- Database: Mongo(running locally for storing tasks)
- Object Storage: LocalStack (for emulating S3 and storing images locally for testing purposes)

## Project Structure

This project contains the following components:

- **/backend** - This directory contains the Node.js application that handles the server-side logic and interacts with the database. This directory contains configuration settings for uploading images to LocalStack (emulated AWS S3). The uploadConfig.js file is responsible for configuring the S3 client to connect to the LocalStack S3 endpoint. This allows the backend application to store and retrieve images associated with the Todo List items.
- **/frontend** - The frontend directory contains the React application that handles the user interface and interacts with the backend. 
  
## Development

1. Install awscli-local tool

```
pip install awscli-local
```

In case, it throws error related to python. Follow the below steps:

```
python3 -m venv venv
source venv/bin/activate
pip install awscli-local
```


2. Clone the repository

```
git clone https://github.com/dockersamples/todo-list-localstack-docker
```

3. Navigate into the project.

```
cd todo-list-localstack-docker
```


## Run the app natively

## Bring up LocalStack 

To run the app natively, you will need to run LocalStack and Mongo using Docker Compose while running frontend and backend locally.

```
docker compose -f compose-native.yml up -d --build
```


<img width="1307" alt="image" src="https://github.com/user-attachments/assets/d643f92c-c7e3-4ebe-a3c1-9288deb14083">


## Verify if LocalStack is up and running

<img width="762" alt="image" src="https://github.com/user-attachments/assets/ac832aeb-a9e8-4ae5-a2ca-8c538259023e">



## Add a Sample S3 Bucket

By using the AWS CLI with LocalStack, you can interact with the emulated services exactly as you would with real AWS services. This helps ensure that your application behaves the same way in a local environment as it would in a production environment on AWS.


Let’s create a new S3 bucket within the LocalStack environment:


```
awslocal s3 mb s3://mysamplebucket
```

The command `s3 mb s3://mysamplebucket` tells the AWS CLI to create a new S3 bucket (mb stands for "make bucket"). The bucket is named `mysamplebucket`
It should show the following result:

```
make_bucket: mysamplebucket
```

## Connecting to LocalStack from a non-containerised Node app

Now it’s time to connect your app to LocalStack. The index.js file, located in the backend/ directory, serves as the main entry point for the backend application.

The code interacts with LocalStack’s S3 service, which is accessed via the endpoint defined by the `S3_ENDPOINT_URL` environment variable, typically set to `http://localhost:4556` for local development.  

The `S3Client` from the AWS SDK is configured to use this LocalStack endpoint, along with test credentials (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`) that are also sourced from environment variables. This setup allows the application to perform operations on the locally simulated S3 service as if it were interacting with the real AWS S3, making the code flexible for different environments.

The code uses multer and multer-s3 to handle file uploads. When a user uploads an image through the `/upload` route, the file is stored directly in the S3 bucket simulated by LocalStack. The bucket name is retrieved from the environment variable `S3_BUCKET_NAME`. Each uploaded file is given a unique name by appending the current timestamp to the original file name. The route then returns the URL of the uploaded file within the local S3 service, making it accessible just as it would be if hosted on a real AWS S3 bucket


## Bring up Backend

```
cd backend/
npm install

```


Please note that these are placeholders that LocalStack uses to simulate AWS credentials and not the real values.
Hence, no changes are needed.


```
AWS_ACCESS_KEY_ID=test
AWS_SECRET_ACCESS_KEY=test
S3_BUCKET_NAME=mysamplebucket
S3_ENDPOINT_URL=http://localhost:4566
MONGODB_URI=mongodb://mongodb:27017/todos
AWS_REGION=us-east-1
```

Start the backend server:


```
node index.js
```

You will see the message that the backend service has successfully started at port 5000.



## Start the frontend

Open a new terminal and run the following command:

```
cd frontend/
npm run dev
```

By now, you should see the following message

```
VITE v5.4.2  ready in 110 ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: use --host to expose
  ➜  press h + enter to show help

```

## Try adding a task and uploading the image


![image](https://github.com/user-attachments/assets/55ca86c0-c83b-4f5e-83d2-0e87c97ba48a)

It shows the image is successfully uploaded.

## Check the LocalStack container logs

<img width="1337" alt="image" src="https://github.com/user-attachments/assets/e29f1a72-13a7-45d0-b55b-23a396916bfa">

## Check the Mongo container logs

```
# mongosh
Current Mongosh Log ID: 66cb1093118d7d4cc1c76a8a
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.3.0
Using MongoDB:          7.0.12
Using Mongosh:          2.3.0

For mongosh info see: https://www.mongodb.com/docs/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2024-08-25T10:58:46.918+00:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
   2024-08-25T10:58:47.668+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2024-08-25T10:58:47.668+00:00: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never' in this binary version
   2024-08-25T10:58:47.668+00:00: vm.max_map_count is too low
------

test> show dbs
admin   40.00 KiB
config  60.00 KiB
local   40.00 KiB
todos    8.00 KiB
test> use todos
switched to db todos
todos> db.todos.countDocuments()
2
todos> db.todos.countDocuments()
3
todos> 
```

## Stop the container services

```
docker compose -f compose-native.yml down
```

## Connecting to containerised LocalStack from a containerised Node app

```
docker compose -f compose.yml up -d --build
```

## Add a Sample S3 Bucket

Using the AWS CLI with LocalStack lets you interact with the emulated services exactly as you would with real AWS services. This helps ensure that your application behaves the same way in a local environment as it would in a production environment on AWS.


Let’s create a new S3 bucket within the LocalStack environment:


```
awslocal s3 mb s3://mysamplebucket
```

The command `s3 mb s3://mysamplebucket` tells the AWS CLI to create a new S3 bucket (mb stands for "make bucket"). The bucket is named `mysamplebucket`
It should show the following result:

```
make_bucket: mysamplebucket
```


## Try adding a task and uploading the image


![image](https://github.com/user-attachments/assets/55ca86c0-c83b-4f5e-83d2-0e87c97ba48a)

It shows the image is successfully uploaded.

## Check the LocalStack container logs

<img width="1337" alt="image" src="https://github.com/user-attachments/assets/e29f1a72-13a7-45d0-b55b-23a396916bfa">

## Check the Mongo container logs

```
# mongosh
Current Mongosh Log ID: 66cb1093118d7d4cc1c76a8a
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.3.0
Using MongoDB:          7.0.12
Using Mongosh:          2.3.0

For mongosh info see: https://www.mongodb.com/docs/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2024-08-25T10:58:46.918+00:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
   2024-08-25T10:58:47.668+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2024-08-25T10:58:47.668+00:00: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never' in this binary version
   2024-08-25T10:58:47.668+00:00: vm.max_map_count is too low
------

test> show dbs
admin   40.00 KiB
config  60.00 KiB
local   40.00 KiB
todos    8.00 KiB
test> use todos
switched to db todos
todos> db.todos.countDocuments()
2
todos> db.todos.countDocuments()
3
todos> 
```


