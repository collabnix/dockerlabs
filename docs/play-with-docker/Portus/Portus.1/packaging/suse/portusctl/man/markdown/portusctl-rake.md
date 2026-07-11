PORTUSCTL 1 "portusctl User manuals" "SUSE LLC." "AUGUST 2016"
==============================================================

# NAME
portusctl rake \- Execute rake commands available within Portus

# SYNOPSIS

**portusctl rake** \<task\> [arguments...]

# DESCRIPTION
The **rake** command allows administrators to execute rake tasks that are
available within the Portus context. Some of these tasks have been defined by
Portus developers, and some others are plain tasks defined by Ruby on Rails or
some other gem. In order to get the full list of all the available tasks,
execute:

```
$ portusctl rake -T
```

It is not recommended to execute any rake task if you are not experienced with
Portus or you are on a production server.

# EXAMPLES

As shown in the description, "portusctl rake -T" will give you the available
tasks. Moreover, as it's been also explained in the description section, these
tasks are advanced and should be used with caution. That being said, there is at
least one task that is really useful:

```
$ portusctl rake portus:info
```

The previous task will give you detailed output of:

- The exact version of Portus that you are running.
- The configuration being used (with sensible information hidden).

This task is really useful to give developers more information when fixing an
issue that you might be having.

# HISTORY
August 2016, created by Miquel Sabaté Solà <msabate@suse.com>
