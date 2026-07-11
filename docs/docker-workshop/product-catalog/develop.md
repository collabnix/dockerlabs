---
title: "psql -U postgres"
---

:::tip[Run the interactive Labspace]
This topic is also part of a self-contained, click-to-run **Labspace** -
[github.com/ajeetraina/labspace-developer-productivity](https://github.com/ajeetraina/labspace-developer-productivity) -
that walks the full inner-loop developer workflow, from running Postgres
containers through building, testing, and securing the Product Catalog
service, all the way to local AI with Docker Model Runner and the MCP Gateway:

```bash
git clone https://github.com/ajeetraina/labspace-developer-productivity
cd labspace-developer-productivity
CONTENT_PATH=$PWD docker compose up --watch
```
:::

### Clone the repo

```
git clone https://github.com/dockersamples/catalog-service-node
```


## Initial Setup

```
cd demo/sdlc-e2e
./setup.sh
```

> The setup.sh script performs several important setup tasks to prepare the development environment for the Docker workshop. Let me explain what it does in detail:
> The script performs the following tasks:

> - Creates a demo branch:

> It determines the repository root using git rev-parse --show-toplevel
> It creates a new git branch with a unique name combining "demo", the current date, and your username (e.g., demo-20250304-ajeet)
> This ensures each participant has their own isolated branch to work with


> - Cleans the environment:

> Runs git clean -f to remove untracked files
> Deletes any existing branches named 'temp' or with the same demo branch name
> Creates a temporary branch, deletes the main branch locally, then recreates it
> This ensures everyone starts with a clean state


> - Updates to latest code:

> Pulls the latest changes from the remote repository


> - Applies the demo patch:

> Applies the demo.patch file using git apply --whitespace=fix
> This patch includes specific modifications to the codebase for the workshop
> In particular, it removes the upc: product.upc, line from src/services/ProductService.js (line 52)
> It also modifies the Dockerfile to use an older Node.js version and changes some package versions


> - Creates a commit:

> Commits the changes with the message "Demo prep"


> -  Installs dependencies:

> Runs npm install to install all required Node.js dependencies


> -  Downloads container images:

> Runs docker compose pull to download all the required Docker images in advance
> This saves time during the workshop


> -  Prepares for Docker Build Cloud:

> Removes postgres:17.2 container image (if it exists)
> Creates and configures a cloud buildx builder for Docker Build Cloud
> This enables faster builds using Docker's cloud-based build infrastructure


> - Configures Docker Scout:

> Sets up Docker Scout with the dockerdevrel organization
> This enables security scanning capabilities for the workshop


> In summary, the setup.sh script prepares a consistent, clean environment with all necessary dependencies, tools, and configurations so that workshop participants can immediately start working on the exercises without spending time on setup. It also makes deliberate modifications to the codebase (like removing the UPC field from Kafka messages) that will be "fixed" during the workshop exercises.


### Run the Compose

```
docker compose up -d
```

## Setting up the Demo


Bring up the API service 


```
npm install
npm run dev
```


### Accessing the Web Client

- Open the web client (http://localhost:5173) and create a few products.

### Accessing the database visualizer 

- Open [http://localhost:5050](http://localhost:5050) and validate the products exist in the database. 
"Good! We see the UPCs are persisted in the database"

- Use "postgres" as password to enter into the visualizer.

- Use the following Postgres CLI to check if the products are added or not.

```

psql (17.1 (Debian 17.1-1.pgdg120+1))
Type "help" for help
postgres=# \c catalog
You are now connected to database "catalog" as user "postgres".
catalog=# SELECT * FROM products;
  1 | New Product | 100000000001 | 100.00 | f
  2 | New Product | 100000000002 | 100.00 | f
  3 | New Product | 100000000003 | 100.00 | f
```



### Access the Kafka Visualizer

Before we access visualizer, let's apply the patch:



Open the Kafka visualizer [http://localhost:8080](http://localhost:8080) and look at the published messages. 
"Ah! We see the messages don't have the UPC"

<img width="1213" alt="image" src="https://github.com/user-attachments/assets/a3e3ff3d-f08c-4168-bfb2-e59800be4d58" />



## Let's fix it...


### Configuring 

In VS Code, open the `src/services/ProductService.js` file and add the following to the publishEvent on line ~52:

```
upc: product.upc,
```

Save the file and create a new product using the web UI. 


<img width="1191" alt="image" src="https://github.com/user-attachments/assets/32c5ba6c-60c1-403b-9962-50c501a5e996" />

Validate the message has the expected contents.

