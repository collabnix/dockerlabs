---
title: "Overview"
---


**Container-supported development** is the idea of using containers to support and enhance development without touching the main application runtime itself. 

## What it means?

The developer will run their application using a runtime installed natively on their machine (such as a JVM, Node engine, or Python interpreter). But, the external dependencies will run in containers. 


## What benefits does it provide to the developers?

Even though the developers didn’t go “all-in”, Docker still provided significant value by running dependent services out of containers, making it quick and easy to get started and ensure version consistency across the entire team.

With Docker, teams can do things that might otherwise have been impossible. They can run local instances of cloud services, run real services in their tests, and more. There is no “one right path” for teams to leverage Docker. You see teams using wrapper scripts that run docker run commands, others using IDE plugins to launch declarative Compose stacks, or programmatic interactions using Testcontainers.In many of these cases, teams can leverage off-the-shelf (or very slightly customized versions of) images from our DOI/DVP catalog.


## Choosing the container-supported approach:

- **Separation of Concerns**: Developers focus on the core application logic using their familiar runtime (JVM, Node, Python etc.), while external dependencies are isolated in containers.

- **Improved Efficiency**:

- Easier setup: Containers simplify dependency management, reducing time spent configuring environments.
Version consistency: All developers use the same container image, ensuring consistent dependencies across the team.
- Enhanced Capabilities: Docker allows running local simulations of cloud services and real services within tests, providing a more realistic development environment.

- **Flexibility in Implementation**: There's no single approach. Teams can use:

- Wrapper scripts for simple container execution.
- IDE plugins for launching development environments defined in Docker Compose files.
- Programming interactions with libraries like Testcontainers.

- **Leveraging Shared Resources**: Teams can benefit from pre-built container images from public repositories like Docker Official Images (DOI) and Docker Verified Publishers (DVP).

Overall, container-supported development offers a way to streamline the development process by managing dependencies and enhancing development environments without completely switching to a containerized application runtime.
