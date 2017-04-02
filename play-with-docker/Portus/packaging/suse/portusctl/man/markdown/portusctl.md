PORTUSCTL 1 "portusctl User manuals" "SUSE LLC." "AUGUST 2016"
==============================================================

# NAME
portusctl \- A tool to administrate your Portus instance

# SYNOPSIS

**portusctl** command [command options] [arguments...]

# DESCRIPTION
**portusctl** is a tool that helps administrators perform operation on the
installed Portus instance. For this, administrators will be able to execute
various commands, **configure** the Portus instance, fetch the **logs** produced
by Portus, etc.

# COMMANDS
**setup**
  Configure your Portus instance. It accepts a wide variety of flags that can be
  used to instruct the values to be set for each configurable value and more.
  See **portusctl-setup(1)** for full documentation on the **setup** command.

**make_admin**
  If called without arguments, it will simply list the usernames that are
  available. Otherwise, if you pass a valid username, then the selected user
  will become an administrator.
  See **portusctl-make-admin(1)** for more information on this command.

**rake**
  Run any of the rake tasks defined within Portus.
  See **portusctl-rake(1)** to understand how to list the available rake tasks
  and invoke them.

**exec**
  Run an arbitrary command within the context of Portus. More precisely, it will
  run the command by wrapping it with a *bundler exec* call pinned to the
  context of Portus.
  See **portusctl-exec(1)** for more information on this command.

**logs**
  Collect all the logs produced by Portus to further debug an incident.
  See **portusctl-logs(1)** for more information on the **logs** command.

# EXAMPLES
The most common task to be run with **portusctl** is the **setup** command. So,
people installing Portus through the given RPM usually perform the following
commands:

```
$ zypper in portus
$ portusctl setup --local-registry --db-name=portus_test
```

In the previous example, the administrator instructs **portusctl** that the host
machine is running the registry to be targeted, and the DB to be picked is
*portus\_test*. For the rest of the values, **portusctl** will assume the
default value. Take a look at the **portusctl-setup(1)** man page for further
information on this setup.

Another common scenario is reporting a bug. For this, in order to help
developers to discover what's going on, one can perform the following actions:

```
$ portusctl rake portus:info
$ portusctl logs
```

The first command executes the *portus:info* rake task defined within
Portus. This task will generate detailed output about the current version of
Portus, the configuration being used (with sensible data shadowed with stars)
and so on. The second command will give you a tarball in */tmp* containing all
the logs that have been produced by Portus. With all this information on your
hands, you will be able to report the issue you are experiencing.

As an advanced example, you can use the **exec** command to further inspect your
Portus installation. For example, with the following command you will be able to
access a Ruby environment with Portus loaded in it:

```
$ portusctl exec rails c
```

By executing the previous command, you will enter a different console that only
accepts Ruby code (in which all Portus' code is available!). With this, and some
knowledge of the Ruby programming language, you will be able to perform tasks
such as:

```
> puts User.all
> puts Team.find_by(name: "myteam").namespaces
```

With the previous two commands, you will be able to list all the users on the
system and all the namespaces of the *myteam* team. Needless to say, only do
this if you *really* know what you are doing! We only recommend this in
development/staging/test environments, or to experienced Ruby on Rails
developers that are just performing *read* statements for further inspecting
an issue.

# HISTORY
August 2016, created by Miquel Sabaté Solà <msabate@suse.com>
