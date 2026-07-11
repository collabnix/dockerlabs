# This file is used by Rack-based servers to start the application.

require ::File.expand_path("../config/environment", __FILE__)
map Rails.application.config.relative_url_root || "/" do
  run Rails.application
end
