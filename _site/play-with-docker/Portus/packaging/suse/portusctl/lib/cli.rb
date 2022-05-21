# Class implementing the cli interface of portusctl
class Cli < Thor
  check_unknown_options!

  desc "setup", "Configure Portus"
  option "secure", desc: "Toggle SSL usage for Portus", type: :boolean, default: true

  # SSL certificate options
  option "ssl-gen-self-signed-certs",
    desc:    "Generate self-signed certificates",
    type:    :boolean,
    default: false
  option "ssl-certs-dir",
    desc:      "Location of own certificates",
    default:   "",
    long_desc: <<-LONGDESC
Looks for the following required certificate files in the specified folder:
   * `<custom dir>/<hostname>-ca.key`: the certificate key
   * `<custom dir>/<hostname>-ca.crt`: the certificate file
  LONGDESC
  option "ssl-organization",
    desc:    "SSL certificate: organization",
    default: "SUSE Linux GmbH" # gensslcert -o
  option "ssl-organization-unit",
    desc:    "SSL certificate: organizational unit",
    default: "SUSE Portus example" # gensslcert -u
  option "ssl-email",
    desc:    "SSL certificate: email address of webmaster",
    default: "kontact-de@novell.com" # gensslcert -e
  option "ssl-country",
    desc:    "SSL certificate: country (two letters)",
    default: "DE" # gensslcert -c
  option "ssl-city",
    desc:    "SSL certificate: city",
    default: "Nuernberg" # gensslcert -l
  option "ssl-state",
    desc:    "SSL certificate: state",
    default: "Bayern" # gensslcert -s

  # DB options
  option "db-host", desc: "Database: host", default: "localhost"
  option "db-username", desc: "Database: username", default: "portus"
  option "db-password", desc: "Database: password", default: "portus"
  option "db-name", desc: "Database: name", default: "portus_production"

  # Registry
  option "local-registry", desc: "Configure Docker registry running locally",
    type: :boolean, default: false

  # LDAP
  option "ldap-enable", desc: "LDAP: enable", type: :boolean, default: false
  option "ldap-hostname", desc: "LDAP: server hostname"
  option "ldap-port", desc: "LDAP: server port", default: "389"
  option "ldap-method",
    desc:    "LDAP: encryption method (recommended: starttls)",
    default: "plain"
  option "ldap-base", desc: "LDAP: base", default: "ou=users, dc=example, dc=com"
  option "ldap-filter", desc: "LDAP: filter users"
  option "ldap-uid", desc: "LDAP: uid", default: "uid"
  option "ldap-authentication-enable",
    desc:    "LDAP: enable LDAP credentials for user lookup",
    type:    :boolean,
    default: false
  option "ldap-authentication-bind-dn", desc: "LDAP: bind DN for authentication"
  option "ldap-authentication-password", desc: "LDAP: password for authentication"
  option "ldap-guess-email-enable",
    desc:    "LDAP: guess email address",
    type:    :boolean,
    default: false
  option "ldap-guess-email-attr",
    desc: "LDAP: attribute to use when guessing email address"

  # MAILER
  option "email-from",
    desc:    "MAIL: sender address",
    default: "portus@#{HOSTNAME}"
  option "email-name", desc: "MAIL: sender name", default: "Portus"
  option "email-reply-to",
    desc:    "MAIL: reply to address",
    default: "no-reply@#{HOSTNAME}"
  option "email-smtp-enable",
    desc:    "MAIL: use SMTP as the delivery method",
    type:    :boolean,
    default: false
  option "email-smtp-address",
    desc:    "MAIL: the address to the SMTP server",
    default: "smtp.example.com"
  option "email-smtp-port", desc: "MAIL: SMTP server port", default: "587"
  option "email-smtp-username",
    desc:    "MAIL: the user name to be used for logging in the SMTP server",
    default: "username@example.com"
  option "email-smtp-password",
    desc:    "MAIL: the password to be used for logging in the SMTP server",
    default: "password"
  option "email-smtp-domain",
    desc:    "MAIL: the domain of the SMTP server",
    default: "example.com"

  # SIGNUP
  option "signup-enable",
    desc:    "Enable user signup",
    type:    :boolean,
    default: true

  # GRAVATAR
  option "gravatar-enable",
    desc:    "Enable Gravatar usage",
    type:    :boolean,
    default: true

  # JWT EXPIRATION TIME
  option "jwt-expiration-time",
    desc:    "Expiration time for the JWT token used by Portus",
    default: 5

  # Catalog pagination
  option "catalog-page",
    desc:    "Pagination value for API calls to the registry",
    default: 100

  # FIRST USER
  option "first-user-admin-enable",
    desc:    "Make the first registered user an admin",
    type:    :boolean,
    default: true

  # Display name
  option "display-name-enable",
    desc:    "Enable users to set a display name",
    type:    :boolean,
    default: false

  option "delete-enable",
    desc:    "Enable delete support. Only do this if your registry is 2.4 or higher",
    type:    :boolean,
    default: false

  option "change-visibility-enable",
    desc:    "Allow users to change the visibility of their namespaces",
    type:    :boolean,
    default: true

  option "manage-namespace-enable",
    desc:    "Allow users to modify their namespaces",
    type:    :boolean,
    default: true

  option "create-namespace-enable",
    desc:    "Allow users to modify new namespaces",
    type:    :boolean,
    default: true

  option "manage-team-enable",
    desc:    "Allow users to modify their teams",
    type:    :boolean,
    default: true

  option "create-team-enable",
    desc:    "Allow users to create new teams",
    type:    :boolean,
    default: true

  def setup
    ensure_root
    check_setup_flags options

    configure = Configurator.new(options)
    configure.apache
    configure.ssl
    configure.database_config
    registry_config = configure.registry
    configure.secrets
    configure.config_local
    configure.create_database
    configure.services

    return if options["local-registry"]

    puts "Ensure the registry running on another host is configured properly"
    puts "This is a working configuration file you might want to use:"
    puts registry_config
  end

  desc "make_admin USERNAME", "Give 'admin' role to a user"
  def make_admin(username)
    if username.nil? || username.empty?
      # This will print the list of usernames
      Runner.bundler_exec("rake", "portus:make_admin", {})
    else
      # Rake tasks look weird when they accept parameters
      Runner.bundler_exec("rake", "portus:make_admin[#{username}]", {})
    end
  end

  desc "rake ARGS...", "Run a rake task against Portus"
  def rake(*args)
    if args.empty?
      warn "You mush provide at least an argument"
      exit 1
    end

    Runner.bundler_exec("rake", args, {})
  end

  desc "exec ARGS...", "Run a arbitrary command via bundler exec"
  def exec(*args)
    if args.empty?
      warn "You mush provide at least an argument"
      exit 1
    end
    exec_args = []
    exec_args = args[1, args.size] if args.size > 1

    Runner.bundler_exec(args[0], exec_args, {})
  end

  desc "logs", "Collect all the logs used for debugging purposes"
  def logs(*args)
    warn "Extra arguments ignored..." unless args.empty?
    ensure_root

    Runner.produce_versions_file!
    Runner.produce_crono_log_file!
    Runner.exec("cp", ["/var/log/apache2/error_log", File.join(PORTUS_ROOT, "log/production.log")])
    Runner.tar_files("log/production.log", "log/crono.log", "log/versions.log")
  end
end
