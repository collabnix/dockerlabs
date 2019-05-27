# How to Compile Docker from Source?

Building and running a forked version of Docker is not complicated once you get to know what are the pieces involved.


## What does the docker-ce package installs on my system?


As I’ve always been installing docker using apt, the first step was to get it running right from the binaries.Not knowing what to expect from the building process, I started looking at what are the binaries that the docker-ce package installs on the system.

You can check which binaries are these by looking at dpkg --listfiles <pkg_name> (it lists the files installed to your system from pkg_name):

```
# List the files that the docker-ce package brought
# us and then filter out those that are not in
# the `/usr/bin` directory.
```

```
sudo dpkg --listfiles docker-ce | \
  grep /usr/bin

/usr/bin
/usr/bin/docker
/usr/bin/docker-containerd
/usr/bin/docker-containerd-ctr
/usr/bin/docker-containerd-shim
/usr/bin/docker-init
/usr/bin/docker-proxy
/usr/bin/docker-runc
/usr/bin/dockerd
```

Aside from /usr/bin/docker, which is the Docker CLI, the others are components that are run behind the scenes by the Docker daemon (dockerd).

dockerd is the daemon that keeps running as a server, taking commands from your  docker client (usually from a unix socket) and then acting upon them, creating containers leveraging the other docker-* binaries.

## Running the docker daemon behind the scenes

To have dockerd running at all times, docker-ce (the package) sets two systemd configuration files:

```
# List the files installed by `docker-ce` and the
# filter out those without a systemd in the path.

sudo dpkg --listfiles docker-ce | \
  grep systemd

/lib/systemd
/lib/systemd/system
/lib/systemd/system/docker.service      # <<<< 
/lib/systemd/system/docker.socket       # <<<<
```

These are systemd units, files that describe resources that should be taken care by  systemd - the default init process used by most distributions (e.g., Ubuntu and Debian).

The later (docker.socket) controls the socket that dockerd uses to listen for requests made by a client.

Given that generally every .socket file must have a corresponding .service unit, the docker.socket is tied to the docker.service unit.

```
[Unit]
# By telling the unit that it's part of `docker.service`
# we're tying a relationship between them, making a restart
# on `docker.service` propagate to this unit (the same for
# a stop but not for a start).
PartOf=docker.service


# Information about the socket that systemd should supervise.
[Socket]
# The address to listen on for a stream (`SOCK_STREAM`).
# Given that it starts with a `slash`, a filesystem socket (`AF_UNIX`) 
# is created.
ListenStream=/var/run/docker.sock

# File permissions that should be used in the socket file.
SocketMode=0660
SocketUser=root
SocketGroup=docker

# This section carries information regarding installation of the unit.
# Its sole purpose is to provide `systemd` information regarding `enable`
# and `disable` commands issued by `systemctl` during installation or
# uninstallation of units.
#
# ps.: without this section, `systemctl enable` doesn't work.
[Install]
# Creates a symbolic link in the `.wants` directory of the `sockets` target,
# having the effect of making it a dependency of another unit.
#
# This is telling systemd to pull in the unit when starting sockets.target.
WantedBy=sockets.target
```

ps.: a cool effect of having the .socket unit is that you can keep the socket unit active (thus, having /var/run/docker.sock created) and the docker unit inactive (dockerd not running) at machine startup time such that only when a connection is made to the socket, docker starts.

The former (docker.service) is a service unit that not only executes the dockerd daemon, but it also keeps track of its liveness and makes sure that this is only initialized after some dependencies are met.

It looks like this (with comments added by me):

```
[Unit]
# Here we specify some of the dependencies that `dockerd` has.
# Although `After` only configures service startup order,
# We place a strict dependency on `docker.socket`.
#
# - `network-online` is a target that waits until the network is
#   considered up. After this target is met, it's supposed that
#   connections to network resources can be established.
#
# - `firewalld.service` lets us wait for any firewalld configs to
#   go on before docker starts. Under a regular ubuntu installation
#   this target generally doesn't exist.
#
# - `docker.socket` makes us start after the socket activation.
#
After=network-online.target docker.socket firewalld.service

# `Wants=` establishes a weak dependency on something.
# This means that in contrast with `Requires=`, if something goes 
# wrong with it, it can still proceed.
Wants=network-online.target

# Enforces a hard dependency on `docker.socket` unit - if it fails,
# then this service will also fail.
Requires=docker.socket


[Service]
# Makes use of what's specified in ExecStart as the main process
# of the service and then only proceeds to activate other dependencies
# (i.e., other units that specify a dependency on this service) after
# the process (dockerd) sends a notification to systemd via `sd_notify`.
#
# See moby/cmd/dockerd/daemon_linux.go to check the `notifySystem` call.
Type=notify
ExecStart=/usr/bin/dockerd -H fd://
ExecReload=/bin/kill -s HUP $MAINPID
LimitNOFILE=1048576
LimitNPROC=infinity
LimitCORE=infinity
TasksMax=infinity
TimeoutStartSec=0

# As systemd can act as a Linux containers daemon, this clearly conflicts
# with the interests of the docker daemon over the containers controlled
# by docker.
#
# Specifying `delegate=yes` we make systemd grant all the resource control
# to the main process started by `ExecStart`.
Delegate=yes
KillMode=process
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s


[Install]
WantedBy=multi-user.target
```

Having those two files and the binaries, we can get Docker running from a set of binaries.

Let’s now generate them then.

## Building right from the docker-ce repository

Although I’m not from Docker Inc, it seems like all the docker packaging for the community edition happens with what’s there in the docker/docker-ce repository.

Let’s make use of such repository then:

```
# Clone the docker-ce repository to somewhere
git clone https://github.com/docker/docker-ce
cd ./docker-ce

# Checkout to the tag you want.
# ps.: you can gather the list of tags by 
# running git tag.
git checkout v18.03.1-ce

# Having `make` installed, perform the build of 
# the static binaries.
#
# This will invoke a series of build steps that
# make use of the source code that lives under
# the `components` directory.
#
# ps.: you're required to have a running `docker`
# daemon to proceed (`dockerd` is built using docker).
#
# If you're curious, on a `t2.medium` machine without
# any previous runs of this command (i.e, zero cache),
# this takes the following `time`:
#       real	9m44.885s
#       user	0m9.320s
#       sys	0m0.634s
make static DOCKER_BUILD_PKGS=static-linux


# Check that results from the build
tree ./components/packaging/static/build/linux

./components/packaging/static/build/linux
├── docker
│   ├── docker
│   ├── docker-containerd
│   ├── docker-containerd-ctr
│   ├── docker-containerd-shim
│   ├── dockerd
│   ├── docker-init
│   ├── docker-proxy
│   └── docker-runc
└── docker-18.03.1-ce.tgz
```

That’s it! Send that .tgz to the machines you want, unpack it to the desired destination (/usr/bin if you don’t want to change the systemd scripts) and you’re done.

If all you wanted was a way to build docker from the ground and have the binaries, you can stop here.

## Modifying docker (the daemon) from the main repository

Because docker-ce is just a repository that gathers three others (docker/docker-ce-packaging, moby/moby and docker/cli), it’s better to keep our modifications under a fork of the real thing (moby/moby) and then (optionally) use a fork of docker-ce to centralize our modifications.

When cloning moby/moby you’ll notice that the process of producing binaries is fairly straightforward: having docker already running, issue make binary and you’ll have a bundles directory filled with the daemon binaries.

```
# `docker/docker` has been renamed to `moby/moby`, 
# but given that I want to keep the golang import
# paths working, cloning from `docker/docker` makes
# things easier.
git clone https://github.com/docker/docker

# Set up the git remotes to have my fork's source
# code in.
git remote set-url origin https://github.com/cirocosta/docker
git remote add upstream https://github.com/docker/docker

# Grab the code
git fetch --all

# Check out to a branch with the modifications
git checkout privileged

# Build the binaries
make binary
```

Being dockerd made up of several components (like swarmkit and libnetwork), make sure that when you update those, you also update moby/moby’s references (there’s a vendor.conf file there that vndr - the vendoring tool - uses to fetch the dependencies). Thankfully, it’s very easy to make use of a fork in vendor.conf - you specify the import path, the git reference of your modified content and then the fork.

For instance, having modified docker/swarmkit, I updated vendor.conf:

```
IMPORT PATH                GIT REF       MY FORK
github.com/docker/swarmkit 268f203dda... https://github.com/cirocosta/swarmkit
```

ps.: the same is true for other repositories, like docker/cli.

If all you need is a modified daemon (and not a client), then now you’re done - distribute the binaries and you’re good.
