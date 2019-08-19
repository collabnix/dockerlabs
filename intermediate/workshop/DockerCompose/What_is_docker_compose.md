# What is docker compose?
Docker Compose, is a tool for deploy and manage multi-container applications on Docker node operating in single-engine mode. For example, suppose you have an wordpress application with Mysql as a database service. In this case by docker-compose, you can write a docker-compose.yml which will bring up both the containers as a single service.<br>

By default, docker-compose expects the name of the Compose file as <b>dockercompose.yml</b> or <b>docker-compose.yaml</b>. If the compose file have different name we can specify it with <b>-f</b> flag.
