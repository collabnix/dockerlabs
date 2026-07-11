module Portus
  # Performs some checks on runtime to validate that some settings from Portus
  # are properly set.
  module Checks
    # Check whether certain requirements are met, like ssl configuration
    # for production or having setup secrets.
    # If they are not met, render a page with status 500
    def check_requirements
      return unless fixes.value?(true)
      redirect_to "/500?fixes=true"
    end

    # Returns a hash with all the options that the administrator must fix in
    # order to get Portus to work. If this hash is empty, then it means that
    # everything worked as expected
    #
    # This method caches the results because the returned value will be the same
    # after the first request has happened.
    def fixes
      # Return early if we already know the value
      checks = Rails.cache.fetch("portus-checks")
      return checks unless checks.nil?

      secrets   = Rails.application.secrets
      check_ssl = Rails.env.production? && !request.ssl? && APP_CONFIG.enabled?("check_ssl_usage")

      {}.tap do |fix|
        fix[:ssl]                                = check_ssl
        fix[:secret_key_base]                    = secrets.secret_key_base.blank?
        fix[:secret_machine_fqdn]                = APP_CONFIG["machine_fqdn"]["value"].blank?
        fix[:secret_encryption_private_key_path] = secrets.encryption_private_key_path.nil?
        fix[:secret_portus_password]             = secrets.portus_password.nil?
        Rails.cache.write("portus-checks", fix)
      end
    end
  end
end
