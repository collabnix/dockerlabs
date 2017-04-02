PORTUSCTL 1 "portusctl User manuals" "SUSE LLC." "AUGUST 2016"
==============================================================

# NAME
portusctl make_admin \- Grant a user administrator privileges

# SYNOPSIS

**portusctl make_admin** [arguments...]

# DESCRIPTION
The **make_admin** command allows administrators to grant administrator
privileges to a user. That being said, you can perform this command without
specifying any user name. If you do that, then you will get a list of users in
the system. If you pass a user name, it will grant administrator privileges to
this selected user. Note that **make_admin** is *equivalent* of doing:

```
$ portusctl rake make_admin[username]
```

We are providing this command for the convenience of avoiding rake-specific
syntax to users that are not experience with either Ruby or Ruby on Rails.

# HISTORY
August 2016, created by Miquel Sabaté Solà <msabate@suse.com>
