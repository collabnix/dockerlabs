# If you're on staging/production, then you must be using SSL. Moreover, if
# you're on development mode and you have set PORTUS_USE_SSL, then SSL will also
# be required. Otherwise, we will fallback to regular HTTP.
protocol = if !Rails.env.development? || !ENV["PORTUS_USE_SSL"].nil?
  "https://"
else
  "http://"
end

host = APP_CONFIG["machine_fqdn"]["value"]
ActionMailer::Base.default_url_options[:host]     = host
ActionMailer::Base.default_url_options[:protocol] = protocol

Rails.logger.tagged("Mailer config") do
  Rails.logger.info "Host:     #{host}"
  Rails.logger.info "Protocol: #{protocol}"
end
