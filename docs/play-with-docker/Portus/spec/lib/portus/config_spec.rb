# Returns a Portus::Config configured with the two given config files.
def get_config(default, local)
  default = File.join(Rails.root, "spec", "fixtures", default)
  local   = File.join(Rails.root, "spec", "fixtures", local)
  Portus::Config.new(default, local)
end

class ConfigMock < Portus::Config
  def initialize
  end

  def strict_merge_with_env(cfg, local, prefix = "portus")
    super(cfg, local, prefix)
  end
end

describe Portus::Config do
  after :each do
    ["PORTUS_LDAP_COUNT", "PORTUS_ANOTHER_ENABLED", "PORTUS_LDAP_STRING"].each do |key|
      ENV[key] = nil
    end
  end

  it "returns an empty config if neither the global nor the local were found" do
    cfg = get_config("", "").fetch

    expect(cfg.enabled?("gravatar")).to be_falsey
    expect(cfg.enabled?("ldap")).to be_falsey
  end

  it "only uses the global if the local config was not found" do
    cfg = get_config("config.yml", "").fetch

    expect(cfg.enabled?("gravatar")).to be_truthy
    expect(cfg.enabled?("ldap")).to be_falsey
  end

  it "merges both config files and work as expected" do
    cfg = get_config("config.yml", "local.yml").fetch

    expect(cfg.enabled?("gravatar")).to be_truthy
    expect(cfg.enabled?("ldap")).to be_truthy
    expect(cfg["ldap"]["hostname"]).to eq "ldap.example.com"
    expect(cfg["ldap"]["port"]).to eq 389
    expect(cfg["ldap"]["base"]).to eq "ou=users,dc=example,dc=com"
    expect(cfg["unknown"]).to be nil
  end

  it "raises an error when the local file is badly formatted" do
    bad = get_config("config.yml", "bad.yml")
    expect { bad.fetch }.to raise_error(StandardError, "Wrong format for the config-local file!")
  end

  it "merges hashes in a strict manner while evaluating env variables first" do
    default = {
      "gravatar" => { "enabled" => true },
      "another"  => { "enabled" => true },
      "ldap"     => {
        "enabled" => false,
        "count"   => 0,
        "string"  => ""
      }
    }
    local = {
      "ldap" => {
        "enabled" => true,
        "count"   => 1
      }
    }
    ENV["PORTUS_LDAP_COUNT"] = "2"
    ENV["PORTUS_ANOTHER_ENABLED"] = "false"
    ENV["PORTUS_LDAP_STRING"] = "string"

    cfg = ConfigMock.new.strict_merge_with_env(default, local)
    expect(cfg["gravatar"]["enabled"]).to be true # default
    expect(cfg["another"]["enabled"]).to be false # env
    expect(cfg["ldap"]["enabled"]).to be true     # local
    expect(cfg["ldap"]["count"]).to eq 2          # env
    expect(cfg["ldap"]["string"]).to eq "string"  # env
  end

  it "returns the proper config while hiding passwords" do
    cfg     = get_config("config.yml", "local.yml")
    fetched = cfg.fetch
    evaled  = YAML.load(cfg.to_s)

    expect(fetched).to_not eq(evaled)
    fetched["ldap"]["authentication"]["password"] = "****"
    expect(fetched).to eq(evaled)
  end

  it "works for nested options" do
    cfg = get_config("config.yml", "").fetch
    expect(cfg.enabled?("email.smtp")).to be true
  end
end
