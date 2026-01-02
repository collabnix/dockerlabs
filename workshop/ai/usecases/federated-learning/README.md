# Lab: Niche Uses

> **Difficulty**: Intermediate

> **Time**: Approximately 15 minutes

Federated Learning is a machine learning approach that allows multiple devices or clients to collaboratively train a model without the need to send the raw data to a central server. In Federated Learning, the model is initially trained on a central server with a small amount of data, and then it is sent to the clients for further training using their own data. The clients send only the model updates to the central server, rather than the raw data. 
This approach has several benefits, including increased privacy since the raw data never leaves the clients, reduced communication costs since only model updates are sent, and improved performance due to the use of diverse data sources. Federated Learning has become increasingly popular in recent years, particularly in industries where data privacy is of utmost importance, such as healthcare and finance.

# Prerequisites

- A Linux host.
- Docker: 18+
- Docker-Compose: 1.24+
- Network connection to Internet to pull container images from Docker Hub. If network connection to Internet is not available, consider to set up Harbor as a local registry or use offline images.

In addition to these prerequisites, you may also need to install some additional software, such as Python and the Tensorflow Federated framework.