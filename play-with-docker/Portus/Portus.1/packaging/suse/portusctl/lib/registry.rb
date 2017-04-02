module Portusctl
  # Contains all the needed methods for configuring the registry. You should
  # only need to use the `registry` method.
  module Registry
    # Creates registry's configuration
    def registry
      if @options["local-registry"]
        return unless registry_local?

        # Add the certificated used by Portus to sign the JWT tokens
        ssldir = "/etc/registry/ssl.crt"
        FileUtils.mkdir_p(ssldir)
        FileUtils.ln_sf(
          "/etc/apache2/ssl.crt/#{HOSTNAME}-ca.crt",
          File.join(ssldir, "portus.crt")
        )

        TemplateWriter.process(
          "registry.yml.erb",
          "/etc/registry/config.yml",
          binding
        )
      else
        TemplateWriter.render("registry.yml.erb", binding)
      end
    end

    protected

    REGISTRY_RPM         = "docker-distribution-registry".freeze
    ZYPPER_NOT_INSTALLED = 104 # ZYPPER_EXIT_INF_CAP_NOT_FOUND

    # Checks whether the Docker Distribution package is already installed in the
    # system. If it is, it will simply return true. Otherwise, it will ask the user
    # whether or not to install the package first and then proceed. If the user
    # doesn't want that, or some zypper command failed, then it returns false. All
    # the decisions to be made by the user can be coerced with the environment
    # variable "PORTUSCTL_FORCE".
    def registry_local?
      if Runner.safe_exec("zypper", ["se", "-ix", REGISTRY_RPM])
        return true if ENV["PORTUSCTL_FORCE"]

        puts "Warning: portusctl will overwrite the existing configuration."
        puts "Do you want to proceed ? (Y/n)"
        return user_confirm?
      end

      return registry_safe_install! if installed_error?
      false
    end

    # Tries to install the RPM of Docker Distribution. It will forcefully do so if
    # the "PORTUSCTL_FORCE" environment variable has been set.
    def registry_safe_install!
      return install_registry_rpm! if ENV["PORTUSCTL_FORCE"]

      puts "You are using the `--local-registry` flag but the `docker-disitribution-registry` "\
           "package is not installed in the system."
      puts "Installing this package after this will overwrite the contents of the " \
           "`/etc/registry/config.yml` file written by portusctl."
      puts "Would you like portusctl to automatically install this package ? (Y/n)"

      return install_registry_rpm! if user_confirm?

      puts "Aborting: the registry will not be configured."
      false
    end

    # Installs the RPM of Docker Distribution.
    def install_registry_rpm!
      Runner.safe_exec("zypper", ["-q", "-n", "--no-gpg-checks", "in", REGISTRY_RPM])
    end

    # Returns true if the last system() call returned a ZYPPER_NOT_INSTALLED
    # error.
    def installed_error?
      $CHILD_STATUS == ZYPPER_NOT_INSTALLED
    end

    # Returns true if the user wrote either "y", "yes" (including uppercase
    # variations) or nothing.
    def user_confirm?
      opt = $stdin.gets.chomp.downcase
      opt == "" || opt == "y" || opt == "yes"
    end
  end
end
