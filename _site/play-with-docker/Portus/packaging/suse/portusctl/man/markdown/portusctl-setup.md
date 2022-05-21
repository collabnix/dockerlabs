PORTUSCTL 1 "portusctl User manuals" "SUSE LLC." "AUGUST 2016"
==============================================================

# NAME
portusctl setup \- Configure a Portus instance

# SYNOPSIS

**portusctl setup** [options...]

# DESCRIPTION
The **setup** command allows administrators to configure a Portus instance. Note
that this command will effectively wipe out any previous configuration. For this
reason, it's recommended to use this command only when setting up Portus for the
first time.

# OPTIONS
**--secure**
  Toggle SSL usage for Portus. It defaults to true and we really encourage the
  default behavior.

**--ssl-gen-self-signed-certs**
  Both Portus and the Docker registry need to have SSL certificates to encrypt all
  the communications. With this flag, you are telling **portusctl** to
  automatically generate self-signed certificates. This is useful when testing
  Portus, but for production cases we recommend using the **ssl-certs-dir** option.

**--ssl-certs-dir**
  Provide **portusctl** the location of your SSL certificates. These certificates
  are going to be used to encrypt the communications between the Docker registry
  and Portus. Note that under the specified directory, **portusctl** will look for
  a certificate key named *\<hostname\>-ca.key* and a certificate file named
  *\<hostname\>-ca.crt*.

**--ssl-organization**
  The organization of the SSL certificate. This only applied if you have used the

**--ssl-organization-unit**
  The organization unit of the SSL certificate. This only applied if you have used
  the **ssl-gen-self-signed-certs** option. Defaults to "SUSE Portus example".

**--ssl-email**
  The email to be used for the SSL certificate. This only applied if you have used
  the **ssl-gen-self-signed-certs** option. Defaults to "kontact-de@novell.com".

**--ssl-country**
  The country code for the SSL certificate. This only applied if you have used
  the **ssl-gen-self-signed-certs** option. Defaults to "DE".

**--ssl-city**
  The city to be used for the SSL certificate. This only applied if you have used
  the **ssl-gen-self-signed-certs** option. Defaults to "Nuernberg".

**--ssl-state**
  The state to be used for the SSL certificate. This only applied if you have used
  the **ssl-gen-self-signed-certs** option. Defaults to "Bayern".

**--db-host**
  The host to be set for the database. Defaults to "localhost".

**--db-username**
  The username that accesses the database. Defaults to "portus".

**--db-password**
  The password to access the database. Defaults to "portus".

**--db-name**
  The name of the database to be used. Defaults to "portus_production".

**--local-registry**
  Make **portusctl** aware that the Docker registry to be used is running locally.

**--ldap-enable**
  Enable LDAP mode. By passing this flag you are telling **portusctl** that you
  want to use an LDAP server for authentication purposes. All the options starting
  with **ldap-** need this flag to be set.

**--ldap-hostname**
  The hostname of the LDAP server.

**--ldap-port**
  The port on which the LDAP server is listening.

**--ldap-method**
  The encryption method that the LDAP server is using. You have three options:
  **plain** (default), **simple_tls** and **starttls**. Even if **plain** is the
  default value, we strongly recommend using **starttls** in production environments.

**--ldap-base**
  The LDAP base to be considered when fetching users. It defaults to
  "ou=users, dc=example, dc=com".

**--ldap-filter**
  A filter that can be passed to further regulate the lookup of users. By default
  this is disabled.

**--ldap-uid**
  The key being used to identify the UID of the user being searched. It defaults
  to "uid".

**--ldap-authentication-enable**
  Enable authentication mode. That is, instruct Portus that in order to fetch
  users from the LDAP server, it needs to send some credentials first. These
  credentials are passed by the options **ldap-authentication-bind-dn** and
  **ldap-authentication-password**; and they both need this option to be set in
  order for them to be set.

**--ldap-authentication-bind-dn**
  When using **ldap-authentication-enable**, use the given DN to bind into the
  LDAP server. The default is an empty string.

**--ldap-authentication-password**
  When using **ldap-authentication-enable**, use the given password. It defaults
  to an empty string.

**--ldap-guess-email-enable**
  Toggle email guessing. When signing in with LDAP for the first time, Portus
  needs an email but LDAP servers not always require an email to be set for each
  user. By enabling email guessing, you instruct Portus to be clever about it and
  use the given DN to guess the email for each user. Note that users can always
  change their emails in the future.

**--ldap-guess-email-attr**
  When in combination with **ldap-guess-email-enable**, Portus will use the given
  **attr** to fetch the email instead of guessing it from the DN.

**--email-from**
  The email to be used as the sender for emails. It defaults to "portus@\<hostname\>".

**--email-name**
  The name to be used as the sender for emails. It defaults to "Portus".

**--email-reply-to**
  The reply-to to be used when sending emails. It defaults to "no-reply@\<hostname\>".

**--email-smtp-enable**
  Use SMTP instead of sendmail (the default method of delivery). All the options
  starting with **email-smtp-** require this option to be set.

**--email-smtp-address**
  The address of the SMTP server to be used for delivering mail. It defaults to "smtp.example.com".

**--email-smtp-port**
  The port in which the SMTP server is listening to. Defaults to 587.

**--email-smtp-username**
  The username of the SMTP account to be used when sending mail.

**--email-smtp-password**
  The password of the SMTP account to be used when sending mail.

**--email-smtp-domain**
  The domain of the SMTP server. It defaults to "example.com".

**--signup-enable**
  Toggle signup enabling. That is, if set to true, then users will be able to
  signup by themselves. Otherwise, administrators are responsible for adding new
  users. By default signup is enabled.

**--gravatar-enable**
  Use the Gravatar service for displaying icons of users. It defaults to true.

**--jwt-expiration-time**
  Expiration time for the JWT token used by Portus. Set this option only if you
  *really* know what you are doing since it will affect how Portus interacts with
  your Docker registry. It defaults to 5 minutes.

**--catalog-page**
  Set a custom pagination value to be used for API calls with the registry. Only
  set this value if you *really* know what you are doing.

**--first-user-admin-enable**
  When enabled, the first user to register into Portus will become an
  administrator. It's enabled by default.

**--display-name-enable**
  When enabled, users will be able to use a nick (also known as "display
  name"). It's disabled by default.

**--delete-enable**
  This flag controls whether users should be able to remove images and tags from
  within Portus. This will only work if the version of the target Docker registry
  is at least 2.4. This option is disabled by default.

**--change-visibility-enable**
  When enabled, users will be able to change the visibility of their
  namespaces. It's enabled by default.

**--manage-namespace-enable**
  Allow users to modify namespaces if they are an owner of it. If this
  is disabled, only an admin will be able to do this. This defaults to true.

**--create-namespace-enable**
  Allow users to create namespaces. If this is disabled, only an admin will
  be able to do this. This defaults to true.

**--manage-team-enable**
  Allow users to modify teams if they are an owner of it. If this is
  disabled only an admin will be able to do this. This defaults to true.

**--create-team-enable**
  Allow users to create teams. If this is disabled only an admin will be
  able to do this. This defaults to true.

# EXAMPLES

The simplest example is:

```
$ portusctl setup
```

The command above will configure Portus by taking all the default values. Note
that this will also assume that your registry is running somewhere else. If
that's not your case, then you can inform **portusctl** about this:

```
$ portusctl setup --local-registry
```

This is important to get SSL certificates right from the very
beginning. Moreover, this command also allows administrators to deviate from
the default configuration. For example:

```
$ portusctl setup --ldap-enable --ldap-hostname="ldap.example.org"
```

The above command will instruct **portusctl** that you are running an LDAP
server in *ldap.example.org* and that you want Portus to authenticate through
this LDAP server.

# HISTORY
August 2016, created by Miquel Sabaté Solà <msabate@suse.com>
