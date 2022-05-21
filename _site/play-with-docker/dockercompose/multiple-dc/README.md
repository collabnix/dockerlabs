# Support of Multiple Compose File under Docker 18.03 CE Release

Under Docker 18.03 Release, there is a support for multiple composefile when deploying.

## Why Multiple Compose File?

Using multiple Compose files enables you to customize a Compose application for different environments or different workflows.

## Understanding multiple Compose files

By default, Compose reads two files, a docker-compose.yml and an optional docker-compose.override.yml file. By convention, the docker-compose.yml contains your base configuration. The override file, as its name implies, can contain configuration overrides for existing services or entirely new services.
If a service is defined in both files, Compose merges the configurations using the rules described in Adding and overriding configuration.

To use multiple override files, or an override file with a different name, you can use the -f option to specify the list of files. Compose merges files in the order they’re specified on the command line. 

When you use multiple configuration files, you must make sure all paths in the files are relative to the base Compose file (the first Compose file specified with -f). This is required because override files need not be valid Compose files. Override files can contain small fragments of configuration. Tracking which fragment of a service is relative to which path is difficult and confusing, so to keep paths easier to understand, all paths must be defined relative to the base file.

## Example use case

In this section are two common use cases for multiple compose files: changing a Compose app for different environments, and running administrative tasks against a Compose app.

## DIFFERENT ENVIRONMENTS

A common use case for multiple files is changing a development Compose app for a production-like environment (which may be production, staging or CI). To support these differences, you can split your Compose configuration into a few different files:

Start with a base file that defines the canonical configuration for the services.

## Cloning this Repository:

```
$git clone https://github.com/ajeetraina/docker101
cd docker101/play-with-docker/dockercompose/multiple-dc
```

## Run the below command for Production Environment

```

$ docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
Starting multipledc_cache_1 ...
Starting multipledc_db_1 ... done
Starting multipledc_web_1 ... done
```

## Run the below command for Dev Environment

```

$ docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d
Starting multipledc_cache_1 ...
Starting multipledc_db_1 ... done
Starting multipledc_web_1 ... done

```
