default    = File.join(Rails.root, "config", "config.yml")
local      = ENV["PORTUS_LOCAL_CONFIG_PATH"] || File.join(Rails.root, "config", "config-local.yml")
cfg        = Portus::Config.new(default, local)
APP_CONFIG = cfg.fetch
