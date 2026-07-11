---
title: "Overview"
---

**Container-first development** takes the concept of containerization a step further. It involves using containers for every aspect of software development, including the application runtime itself. This means developers can ditch traditional local installations and leverage containers for everything needed to run the application.

## What it means?

In container-first development, developers work within a containerized environment. They:

- Clone the project repository.
- Run a command (often docker-compose up or docker-compose watch) to start the development environment. This command usually pulls pre-built container images containing the application runtime (e.g., Node.js, Python interpreter) and any dependencies.

That's it! The development environment is up and running entirely within containers. No need to install the application runtime or specific libraries on the developer's machine.

## Benefits for Developers:

- Extreme Portability: Developers only need a container engine and an IDE to work on the project. This ensures identical development environments regardless of the underlying operating system or pre-installed software.
- Faster Setup: No time wasted installing the application runtime or fiddling with local configurations. Developers can start coding as soon as the containerized environment is up.
- Improved Isolation: Each project runs within its own isolated container, preventing conflicts between projects or dependencies from interfering with other applications on the developer's machine.
- Simplified Collaboration: Team members can easily share and reproduce development environments using the same container images.

## Choosing Container-First:

- Container-first development is ideal for teams seeking:
- Maximum portability across development environments.
- Fast and streamlined development setup.
- Strong isolation between projects to avoid conflicts.

However, it requires a steeper learning curve for containerization technologies and might have higher resource demands.

Container-first development offers a powerful approach for building applications entirely within containerized environments. It streamlines development workflows, ensures consistent development environments, and promotes collaboration. But, it's important to weigh the benefits against the increased complexity and potential resource usage before adopting this approach for your development team.
