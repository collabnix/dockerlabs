PORTUSCTL 1 "portusctl User manuals" "SUSE LLC." "AUGUST 2016"
==============================================================

# NAME
portusctl logs \- Fetch all the logs produced by Portus

# SYNOPSIS

**portusctl exec** \<command\> [arguments...]

# DESCRIPTION
The **exec** command allows administrators to execute any command from within
the same environment as Portus.

# EXAMPLES
The **exec** command might come in handy when you want to execute some
administrative command in the same context as Portus. For example, if you want
to take a closer look at the current state of Portus, you can perform the
following:

```
$ portusctl exec rails c
```

This will put you inside of a Ruby on Rails console with Portus' code loaded in
it. This way, you will be able to perform deeper inspections like:

```
> puts Team.find_by(name: "myteam").namespaces
```

However, if you are not that experienced with Ruby on Rails and you want to
check the database directly as Portus sees it, you can perform:

```
$ portusctl exec rails db
```

With the command above, you will be able to access a MariaDB prompt that is
connected to the database that Portus is using.

# HISTORY
August 2016, created by Miquel Sabaté Solà <msabate@suse.com>
