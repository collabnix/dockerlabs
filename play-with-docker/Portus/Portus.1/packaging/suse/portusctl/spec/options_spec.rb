require_relative "spec_helper"
require "yaml"

# Format the given key from the config to portusctl's expectations.
def format_key(key)
  key.tr("_", "-")
     .gsub("enabled", "enable")
     .gsub("user-name", "username")
     .gsub(/^registry-jwt-expiration-time-value$/, "jwt-expiration-time")
     .gsub(/^registry-catalog-page-value$/, "catalog-page")
     .gsub(/^check-ssl-usage-enable$/, "secure")
     .gsub(/^user-permission-change-visibility-enable$/, "change-visibility-enable")
     .gsub(/^user-permission-manage-namespace-enable$/, "manage-namespace-enable")
     .gsub(/^user-permission-create-namespace-enable$/, "create-namespace-enable")
     .gsub(/^user-permission-manage-team-enable$/, "manage-team-enable")
     .gsub(/^user-permission-create-team-enable$/, "create-team-enable")
end

# Get the keys as given by the config.yml file.
def get_keys(hsh, prefix = "")
  keys = []

  hsh.each do |k, v|
    if v.is_a? Hash
      subprefix = k
      subprefix = prefix + "-" + subprefix unless prefix.empty?
      keys += get_keys(v, subprefix)
    else
      key = prefix + "-" + k unless prefix.empty?
      keys << key
    end
  end

  keys
end

describe Cli do
  it "matches with the options available in the config.yml file" do
    path = File.expand_path("../../../../../config/config.yml", __FILE__)
    yml  = YAML.load(IO.read(path))

    # Get the keys from the config and from the setup command. Then get the
    # difference between the config and the intersection of the config and the
    # setup command.
    config_keys = get_keys(yml).map { |k| format_key(k) }
    config_keys.delete("machine-fqdn-value")
    setup_keys  = Cli.commands["setup"].options.keys
    diff        = config_keys - (config_keys & setup_keys)

    raw = "The following keys are available in the config but not in the setup command: "
    msg = raw + diff.join(", ") + "."
    expect(diff).to be_empty, msg
  end

  it "returns the proper name of the given flag" do
    argv = ["--flag"]
    expect { Cli.start(argv) }.to output("Unknown switches '--flag'\n").to_stderr
  end
end
