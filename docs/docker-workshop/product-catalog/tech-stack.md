---
title: "Tech Stack"
---

## Application architecture

This sample app provides an API that utilizes the following setup:

- Data is stored in a PostgreSQL database
- Product images are stored in a AWS S3 bucket
- Inventory data comes from an external inventory service
- Updates to products are published to a Kafka cluster

<img width="1226" alt="architecture" src="https://github.com/user-attachments/assets/09509d15-4095-44f3-a478-189c733b9e20" />



During development, containers provide the following services:

- PostgreSQL and Kafka runs directly in a container
- LocalStack is used to run S3 locally
- WireMock is used to mock the external inventory service
- pgAdmin and kafbat are added to visualize the PostgreSQL database and Kafka cluster

<img width="906" alt="dev-environment-architecture" src="https://github.com/user-attachments/assets/e8e5790a-8e21-4331-9566-4db4861d7a65" />

