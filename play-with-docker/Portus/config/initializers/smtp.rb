# If SMTP was set, then use it as the delivery method and configure it with the
# given config.

if defined?(APP_CONFIG) && APP_CONFIG["email"]["smtp"]["enabled"]
  Portus::Application.config.action_mailer.delivery_method = :smtp
  smtp = APP_CONFIG["email"]["smtp"]
  smtp_settings = {
    address:              smtp["address"],
    port:                 smtp["port"],
    domain:               smtp["domain"],
    enable_starttls_auto: false
  }
  if smtp["user_name"].blank?
    Rails.logger.info "No smtp username supplied, not using smtp authentication"
  else
    auth_settings = {
      user_name:            smtp["user_name"],
      password:             smtp["password"],
      authentication:       :login,
      enable_starttls_auto: true
    }
    smtp_settings = smtp_settings.merge(auth_settings)
  end
  ActionMailer::Base.smtp_settings = smtp_settings
else
  # If SMTP is not enabled, then go for sendmail.
  Portus::Application.config.action_mailer.delivery_method = :sendmail
end
