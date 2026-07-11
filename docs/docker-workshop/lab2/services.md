---
title: "mongosh"
---

## 1. Clone the repository:

```sh
git clone https://github.com/dockersamples/getting-started-todo-app
cd getting-started-todo-app
```

## 2. Switch to container-first branch

```
git checkout container-first-aws-mongo
```


## 3. Add the Environment Variables

Copy .env.sample to .env file and Ensure that you have the right environmental variable added as shown:

```
MONGODB_URI=mongodb://mongodb:27017/todo-app
JWT_SECRET=603b31XXXXXXX90d3b8cb62f0a585fd70a5ee0b4d
AWS_ACCESS_KEY_ID=AKIAXXXXXDDDX
AWS_SECRET_ACCESS_KEY=hSYXtvXXXXXXXO/k39FGt3u078pYWsh
AWS_REGION=us-east-1
S3_BUCKET_NAME=localbuckett
```

You can leverage [this link](https://www.javainuse.com/jwtgenerator) to generate JWT token.


## 4. Bring up the services:

```
docker compose watch
```

## 5. Access the app

Open [http://localhost:3000](http://localhost:3000) to access the todo-list app.
Try adding a task and uploading the image.


## Verify Mongo

You can verify if task gets added by selecting the container and clicking on "Exec" option on the Docker dashboard.
Now you should be able to run the following command to verify the tasks.

```

Current Mongosh Log ID: 66879e864955d6e7b2f3f54d
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.2.10
Using MongoDB:          7.0.12
Using Mongosh:          2.2.10

For mongosh info see: https://docs.mongodb.com/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2024-07-05T07:18:03.008+00:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
   2024-07-05T07:18:03.737+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2024-07-05T07:18:03.738+00:00: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never' in this binary version
   2024-07-05T07:18:03.738+00:00: vm.max_map_count is too low
------

test> show dbs
admin     40.00 KiB
config    12.00 KiB
local     40.00 KiB
todo-app  68.00 KiB
test> use todo-app
switched to db todo-app
todo-app> show collections
todos
users
todo-app> db.todos.showDocuments()
TypeError: db.todos.showDocuments is not a function
todo-app> db.todos.countDocuments()
1
todo-app> db.todos.countDocuments()
2
todo-app> db.todos.countDocuments()
3
todo-app>
```

## Verify the images added to AWS S3

Open AWS Dashboard > S3 service to see the list of images uploaded.

![image](https://github.com/dockersamples/getting-started-todo-app/assets/313480/ffb64c22-f358-41ef-a7a6-2c1055d43753)



