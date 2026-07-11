# Portus as an RPM

## How the RPM is produced

We use [OBS](https://build.opensuse.org/) for producing the RPMs of Portus. More
specifically, we have a subproject inside of
[Virtualization:containers](https://build.opensuse.org/project/show/Virtualization:containers) for
each Portus version (e.g. this is the one for the
[master](https://build.opensuse.org/project/show/Virtualization:containers:Portus)). Each
subproject contains the related Portus version with its dependencies (build and
runtime dependencies).

The `portus` package contains the `spec` file and some patches. The `spec` file
is produced with the `make_spec.rb` script like this:

```bash
$ ./make_spec.rb portus
```

This generated file is then used in OBS. That being said, in the `master` branch
we allow Travis CI to do this. On a successful Travis CI build, the
`package_and_push_to_obs.sh` script will be run. This script will:

- Call `make_spec.rb` and push the generated `spec` file.
- Push the patches inside of the `patches` directory.

## Ruby and Javascript dependencies

Ruby is handled with the traditional `bundler` way. We have a `Gemfile.lock`
which determines the versions to be used, and in OBS we have already packaged
the different gems with their respective versions. If the `Gemfile.lock` and the
gems from OBS are in sync, then the build will succeed, as all Ruby requirements
are met. Note that Ruby dependencies will be available during runtime execution.

Javascript is a bit different, since the way to require the dependencies are
with the `package.json` file. That being said, we
use [yarn](https://github.com/yarnpkg/yarn), and this tool allows us to have a
`yarn.lock` file similar to the `Gemfile.lock` one. That being said, Javascript
packaging is a big mess, and we haven't packaged all the requirements in OBS. To
circumvent this, we produce the `node_modules` directory locally, and then push
it into the OBS repository as a tarball. Doing this locally is guaranteed to
produce a reproducible `node_modules` directory thanks to yarn.

These Javascript dependencies will only be available during build time. This is
because we use webpack:

- When building the RPM, we will produce the desired assets with webpack, and so
  everything will be bundled as files inside of the `public` directory.
- On a successful build, the `node_modules` directory will be excluded from the
  final RPM, so we will end up with the bundled assets, but without the heavy
  `node_modules` directory.

That being said, we intent to improve how we generate the `node_modules`
directory (e.g. in the `package_and_push_to_obs.sh` script).

## portusctl

We have developed `portusctl` as a helper application for managing your Portus
instance. You can read more about this in [portusctl/README.md](./portusctl/README.md).
