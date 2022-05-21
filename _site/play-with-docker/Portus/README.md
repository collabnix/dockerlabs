# Portus

- Website: http://port.us.org/
- [Blog](http://port.us.org/blog/index.html)
- Mailing list: [Google Groups](https://groups.google.com/forum/#!forum/portus-dev)

Portus is an authorization server and a user interface for the next generation
of the Docker registry. Portus targets
[version 2](https://github.com/docker/distribution/blob/master/docs/spec/api.md)
of the Docker Registry API. The minimum required version of Registry is 2.1,
which is the first version supporting soft deletes of blobs.

| master | v2.2 | v2.3 (in development) | Code Climate |
|--------|------|-----------------------|--------------|
| [![Build Status](https://travis-ci.org/SUSE/Portus.svg?branch=master)](https://travis-ci.org/SUSE/Portus) | [![Build Status](https://travis-ci.org/SUSE/Portus.svg?branch=v2.2)](https://travis-ci.org/SUSE/Portus) | [![Build Status](https://travis-ci.org/SUSE/Portus.svg?branch=v2.3)](https://travis-ci.org/SUSE/Portus) | [![Code Climate](https://codeclimate.com/github/SUSE/Portus/badges/gpa.svg)](https://codeclimate.com/github/SUSE/Portus) [![Test Coverage](https://codeclimate.com/github/SUSE/Portus/badges/coverage.svg)](https://codeclimate.com/github/SUSE/Portus/coverage) |

## Features

### Fine-grained control of permissions

Portus supports the concept of users and teams. Users have their own personal
Docker namespace where they have both read (aka `docker pull`) and write (aka
`docker push`) access. A team is a group of users that have read and write
access to a certain namespace. You can read more about this in our
[documentation page about it](http://port.us.org/features/3_teams_namespaces_and_users.html).

Portus implements the [token based authentication system](https://github.com/docker/distribution/blob/master/docs/spec/auth/token.md)
described by the new version of the Docker registry. This can be used to have
full control over the images served by an instance of the Docker registry.

### Web interface for Docker registry

Portus provides quick access to all the images available on your private
instance of Docker registry. User's privileges are taken into account to
make sure private images (the ones requiring special rights also for
`docker pull`) are not shown to unauthorized personnel.

### Self-hosted

Portus allows you to host everything on your servers, on your own
infrastructure. You don't have to trust a third-party service, just own
everything yourself. Take a look at our
[documentation](http://port.us.org/documentation.html) to read the different
setups in which you can deploy Portus.

### And more!

Some highlights:

- [Synchronization with your private registry in order to fetch which images and tags are available](http://port.us.org/features/1_Synchronizing-the-Registry-and-Portus.html).
- [LDAP user authentication](http://port.us.org/features/2_LDAP-support.html).
- [Monitoring of all the activities performed onto your private registry and Portus itself](http://port.us.org/features/4_audit.html).
- [Search for repositories and tags inside of your private registry](http://port.us.org/features/5_search.html).
- [Star your favorite repositories](http://port.us.org/features/6_starring.html).
- [Disable users temporarily](http://port.us.org/features/7_disabling_users.html).
- [Optionally use Application Tokens for better security](http://port.us.org/features/application_tokens.html).

Take a tour by our [documentation](http://port.us.org/features.html) site to
read more about this.

## Supported versions

Docker technologies have a fast iteration pace. This is a good thing, but it
comes with some challenges. As requested by some of our users, the following
table shows which versions of Docker and Docker Distribution are supported by
each Portus version:

| Portus | Docker Engine | Docker Distribution |
|:------:|:-------------:|:-------------------:|
| master | 1.6+ | 2.0+ |
| 2.1+ | 1.6+ | 2.0+ |
| 2.0.0 & 2.0.1 | 1.6 to 1.9 | 2.0 to 2.2 |
| 2.0.2 | 1.6 to 1.9 | 2.0 to 2.4 |
| 2.0.3+ | 1.6+ | 2.0 to 2.4 |

Let's detail some of the version being specified:

- Docker Engine `1.6` is the first version supported by Docker Distribution 2.
  Therefore, this requirement is also the same for Portus.
- As of Docker `1.10`, the Manifest Version 2, Schema 2 is the one being used.
  This is only supported by Portus in the `master` branch and in `2.0.3`.
- Docker Distribution `2.3` supports both Manifest versions, but some changes
  had to be made in order to offer backwards compatibility. This is not
  supported neither for Portus `2.0.0` nor `2.0.1`.

## Overview

In this video you can get an overview of some of the features and capabilities
of Portus.

[![preview](https://cloud.githubusercontent.com/assets/22728/9274870/897410de-4299-11e5-9ebf-c6ecc1ae7733.png)](https://www.youtube.com/watch?v=hGqvYVvdf7U)

## Contributing

First of all, make sure that you have a working development environment. You
can easily do this with either Docker or Vagrant, as it's explained on the
[wiki](https://github.com/SUSE/Portus/wiki#developmentplayground-environments).
The wiki also has notable pages like
[How we test Portus](https://github.com/SUSE/Portus/wiki/How-we-test-Portus).

Also, make sure to understand our contribution guidelines, as explained in
[this](https://github.com/SUSE/Portus/blob/master/CONTRIBUTING.md) document.

Happy hacking!

## Licensing

Portus is licensed under the Apache License, Version 2.0. See
[LICENSE](https://github.com/SUSE/Portus/blob/master/LICENSE) for the full
license text.
