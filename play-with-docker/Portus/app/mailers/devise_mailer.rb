class DeviseMailer < Devise::Mailer
  default from: "#{APP_CONFIG["email"]["name"]} <#{APP_CONFIG["email"]["from"]}>"
  default reply_to: APP_CONFIG["email"]["reply_to"]
end
