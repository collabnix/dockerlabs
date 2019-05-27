# Everything You want to know about Docker Daemon

## What is docker Daemon?

- The Docker daemon is a service that runs on your host operating system. 
- It currently only runs on Linux because it depends on a number of Linux kernel features, but there are a few ways to run Docker on MacOS and Windows too.

## Start the daemon using operating system utilities

On a typical installation the Docker daemon is started by a system utility, not manually by a user. 
This makes it easier to automatically start Docker when the machine reboots.

## Configure Docker to start on boot

Most current Linux distributions (RHEL, CentOS, Fedora, Ubuntu 16.04 and higher) use systemd to manage which services start when the system boots. Ubuntu 14.10 and below use upstart.

systemd

```
$ sudo systemctl enable docker
```

## To disable this behavior, use disable instead.

```
$ sudo systemctl disable docker
```

## Start the daemon manually

If you don’t want to use a system utility to manage the Docker daemon, or just want to test things out, you can manually run it using the dockerd command. 
You may need to use sudo, depending on your operating system configuration.

When you start Docker this way, it runs in the foreground and sends its logs directly to your terminal.

```
$ dockerd

INFO[0000] +job init_networkdriver()
INFO[0000] +job serveapi(unix:///var/run/docker.sock)
INFO[0000] Listening for HTTP on unix (/var/run/docker.sock)
```

To stop Docker when you have started it manually, issue a Ctrl+C in your terminal.

## Configure the Docker daemon

There are two ways to configure the Docker daemon:

- Use a JSON configuration file. This is the preferred option, since it keeps all configurations in a single place.
- Use flags when starting dockerd.

You can use both of these options together as long as you don’t specify the same option both as a flag and in the JSON file. If that happens, the Docker daemon won’t start and prints an error message.

To configure the Docker daemon using a JSON file, create a file at /etc/docker/daemon.json on Linux systems, or C:\ProgramData\docker\config\daemon.json on Windows. On MacOS go to the whale in the taskbar > Preferences > Daemon > Advanced.

Here’s what the configuration file looks like:

```
{
  "debug": true,
  "tls": true,
  "tlscert": "/var/docker/server.pem",
  "tlskey": "/var/docker/serverkey.pem",
  "hosts": ["tcp://192.168.59.3:2376"]
}
```

With this configuration the Docker daemon runs in debug mode, uses TLS, and listens for traffic routed to 192.168.59.3 on port 2376. You can learn what configuration options are available in the dockerd reference docs

You can also start the Docker daemon manually and configure it using flags. This can be useful for troubleshooting problems.

Here’s an example of how to manually start the Docker daemon, using the same configurations as above:

```
dockerd --debug \
  --tls=true \
  --tlscert=/var/docker/server.pem \
  --tlskey=/var/docker/serverkey.pem \
  --host tcp://192.168.59.3:2376
```

You can learn what configuration options are available in the dockerd reference docs, or by running:

```
dockerd --help
```

