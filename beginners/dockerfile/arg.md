### ARG build parameters

Format: `ARG <parameter name>[=<default>]`

The build parameters have the same effect as `ENV`, which is to set the environment variables. The difference is that the environment variables of the build environment set by `ARG` will not exist in the future when the container is running. But don't use `ARG` to save passwords and the like, because `docker history` can still see all the values.

The `ARG` directive in `Dockerfile` defines the parameter name and defines its default value. This default value can be overridden by the `--build-arg <parameter name>=<value>` in the build command `docker build`.

In versions prior to 1.13, the parameter name in `--build-arg` must be defined in `Dockerfile` with `ARG`. In other words, the parameter specified by `--build-arg` must be Used in `Dockerfile`. If the corresponding parameter is not used, the error will exit the build. Starting from 1.13, this strict restriction is released, no longer exits with an error, but a warning message is displayed and construction continues. This is useful when using the CI system to build different `Dockerfile`s with the same build process. Avoiding build commands must be modified based on the contents of each Dockerfile.


## Contributor - [Sangam Biradar](https://www.linkedin.com/in/sangambiradar14/)
