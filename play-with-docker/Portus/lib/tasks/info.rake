namespace :portus do
  desc "Get general info about the running instance"
  task info: :environment do
    puts "\nPortus version: #{Version.value}"
    default = File.join(Rails.root, "config", "config.yml")
    local   = ENV["PORTUS_LOCAL_CONFIG_PATH"] || File.join(Rails.root, "config", "config-local.yml")
    cfg     = Portus::Config.new(default, local)
    puts "Portus has evaluated the following configuration:\n#{cfg}"
  end
end
