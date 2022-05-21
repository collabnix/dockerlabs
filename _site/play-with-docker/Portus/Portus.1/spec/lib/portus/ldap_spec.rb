require "rails_helper"

class LdapMockAdapter
  attr_accessor :opts

  def initialize(o)
    @opts = o
  end

  def bind_as(_)
    true
  end
end

class LdapFailedBindAdapter < LdapMockAdapter
  def bind_as(_)
    false
  end
end

class LdapSearchAdapter
  def initialize(opts)
    @opts = opts
  end

  def search(_)
    @opts
  end
end

class LdapOriginal < Portus::LDAP
  def adapter
    super
  end
end

class LdapMock < Portus::LDAP
  attr_reader :params, :user, :last_symbol
  attr_accessor :bind_result, :session

  def initialize(params)
    @params = { user: params }
    @bind_result = true
    @last_symbol = :ok
    @session = {}
  end

  def load_configuration_test
    load_configuration
  end

  def bind_options_test
    bind_options
  end

  def find_or_create_user_test!
    find_or_create_user!
  end

  def success!(user)
    @user = user
  end

  def fail!(symbol)
    @last_symbol = symbol
  end

  def guess_email_test(response)
    @ldap = LdapSearchAdapter.new(response)
    guess_email
  end

  alias fail fail!

  protected

  def adapter
    @bind_result ? LdapMockAdapter : LdapFailedBindAdapter
  end
end

class PortusMock < Portus::LDAP
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def load_configuration_test
    load_configuration
  end
end

describe Portus::LDAP do
  let(:ldap_config) do
    {
      "enabled"  => true,
      "hostname" => "hostname",
      "port"     => 389,
      "base"     => "ou=users,dc=example,dc=com",
      "uid"      => "uid"
    }
  end

  before :each do
    allow_any_instance_of(Portus::LDAP).to receive(:authenticate!).and_call_original
  end

  it "sets self.enabled? accordingly" do
    expect(Portus::LDAP.enabled?).to be_falsey

    APP_CONFIG["ldap"] = {}
    expect(Portus::LDAP.enabled?).to be_falsey

    APP_CONFIG["ldap"] = { "enabled" => "lala" }
    expect(Portus::LDAP.enabled?).to be_falsey

    APP_CONFIG["ldap"] = { "enabled" => false }
    expect(Portus::LDAP.enabled?).to be_falsey

    APP_CONFIG["ldap"] = { "enabled" => true }
    expect(Portus::LDAP.enabled?).to be true
  end

  # Let's make code coverage happy
  it "calls the right adapter" do
    ldap = LdapOriginal.new(nil)
    expect(ldap.adapter.to_s).to eq "Net::LDAP"
  end

  it "loads the configuration properly" do
    lm = LdapMock.new(nil)
    expect(lm.load_configuration_test).to be nil

    APP_CONFIG["ldap"] = { "enabled" => true }
    expect(lm.load_configuration_test).to be nil

    # The Portus user does not authenticate through LDAP.
    APP_CONFIG["ldap"] = ldap_config
    lm = PortusMock.new(account: "portus", password: "1234")
    expect(lm.load_configuration_test).to be nil

    # Empty password always returns an empty configuration
    lm = LdapMock.new(username: "name", password: "")
    expect(lm.load_configuration_test).to be nil

    # Empty name always returns an empty configuration
    lm = LdapMock.new(username: "", password: "1234")
    expect(lm.load_configuration_test).to be nil

    # Now we are good to go
    lm = LdapMock.new(username: "name", password: "1234")
    cfg = lm.load_configuration_test

    expect(cfg).to_not be nil
    expect(cfg.opts[:host]).to eq "hostname"
    expect(cfg.opts[:port]).to eq 389
    expect(cfg.opts[:encryption]).to be nil
    expect(cfg.opts).not_to have_key(:auth)

    # Test different encryption methods.
    [["starttls", :start_tls], ["simple_tls", :simple_tls], ["lala", nil]].each do |e|
      APP_CONFIG["ldap"]["method"] = e[0]
      cfg = lm.load_configuration_test
      expect(cfg.opts[:encryption]).to eq e[1]
    end
  end

  it "loads the auth configuration properly" do
    # auth configuration disabled
    auth = { "enabled" => false }
    APP_CONFIG["ldap"] = { "enabled" => true, "authentication" => auth }

    lm = LdapMock.new(username: "name", password: "1234")
    cfg = lm.load_configuration_test
    expect(cfg.opts).not_to have_key(:auth)

    # auth configuration enabled
    auth = { "enabled" => true, "bind_dn" => "foo", "password" => "pass" }
    APP_CONFIG["ldap"] = { "enabled" => true, "authentication" => auth }

    lm = LdapMock.new(username: "name", password: "1234")
    cfg = lm.load_configuration_test
    expect(cfg.opts[:auth][:username]).to eq "foo"
    expect(cfg.opts[:auth][:password]).to eq "pass"
    expect(cfg.opts[:auth][:method]).to eq :simple
  end

  it "fetches the right bind options" do
    APP_CONFIG["ldap"] = { "enabled" => true, "base" => "", "uid" => "uid" }
    lm = LdapMock.new(username: "name", password: "1234")
    opts = lm.bind_options_test
    expect(opts.size).to eq 2
    expect(opts[:filter].to_s).to eq "(uid=name)"
    expect(opts[:password]).to eq "1234"

    APP_CONFIG["ldap"] = ldap_config
    opts = lm.bind_options_test
    expect(opts.size).to eq 3
    expect(opts[:filter].to_s).to eq "(uid=name)"
    expect(opts[:password]).to eq "1234"
    expect(opts[:base]).to eq "ou=users,dc=example,dc=com"

    APP_CONFIG["ldap"] = { "enabled" => true, "base" => "", "uid" => "foo" }
    lm = LdapMock.new(username: "name", password: "12341234")
    opts = lm.bind_options_test
    expect(opts[:filter].to_s).to eq "(foo=name)"

    APP_CONFIG["ldap"] = { "enabled" => true, "base" => "", "uid" => "foo", "filter" => "mail=g*" }
    lm = LdapMock.new(username: "name", password: "12341234")
    opts = lm.bind_options_test
    expect(opts[:filter].to_s).to eq "(&(foo=name)(mail=g*))"
  end

  describe "#find_or_create_user!" do
    before :each do
      APP_CONFIG["ldap"] = { "enabled" => true }
    end

    it "the ldap user could be located" do
      user = create(:user, username: "name")
      lm = LdapMock.new(username: "name", password: "1234")
      ret, created = lm.find_or_create_user_test!
      expect(ret.id).to eq user.id
      expect(created).to be_falsey
    end

    it "creates a new ldap user" do
      lm = LdapMock.new(username: "name", password: "12341234")
      _, created = lm.find_or_create_user_test!

      expect(User.count).to eq 1
      expect(User.find_by(username: "name")).to_not be nil
      expect(created).to be_truthy
    end

    it "creates a new ldap user even if it has weird characters" do
      # Remember that this will create a new admin, so it has its consequences
      # on the expected values in this test.
      create(:registry)

      lm = LdapMock.new(username: "name!o", password: "12341234")
      _, created = lm.find_or_create_user_test!

      expect(User.count).to eq 2
      user = User.find_by(username: "name!o")
      expect(user.username).to eq "name!o"
      expect(user.namespace.name).to eq "name_o"
      expect(created).to be_truthy
    end

    it "allows multiple users to have no email setup" do
      APP_CONFIG["ldap"]["guess_email"] = { "enabled" => false }

      lm = LdapMock.new(username: "name", password: "12341234")
      lm.find_or_create_user_test!

      lm = LdapMock.new(username: "another", password: "12341234")
      lm.find_or_create_user_test!

      expect(User.count).to eq 2
    end
  end

  describe "#authenticate!" do
    it "raises an exception if ldap is not supported" do
      lm = LdapMock.new(username: "name", password: "1234")
      lm.authenticate!
      expect(lm.last_symbol).to be :ldap_failed
    end

    it "fails if the user couldn't bind" do
      APP_CONFIG["ldap"] = { "enabled" => true, "base" => "" }
      lm = LdapMock.new(username: "name", password: "12341234")
      lm.bind_result = false
      lm.authenticate!
      expect(lm.last_symbol).to be :ldap_bind_failed
    end

    it "raises an exception if the user could not created" do
      APP_CONFIG["ldap"] = { "enabled" => true, "base" => "" }
      lm = LdapMock.new(username: "name", password: "1234")
      lm.authenticate!
      expect(lm.last_symbol).to eq "Password is too short (minimum is 8 characters)"
    end

    it "returns a success if it was successful" do
      APP_CONFIG["ldap"] = { "enabled" => true, "base" => "" }
      lm = LdapMock.new(username: "name", password: "12341234")
      lm.authenticate!
      expect(lm.last_symbol).to be :ok
      expect(lm.user.username).to eq "name"
    end
  end

  describe "#guess_email" do
    let(:empty_dc) do
      [
        {
          "dn"    => ["ou=users"],
          "email" => "user@example.com"
        }
      ]
    end

    let(:multiple_dn) do
      [
        {
          "dn"    => ["ou=users,dc=example,dc=com", "ou=accounts,dc=example,dc=com"],
          "email" => "user@example.com"
        }
      ]
    end

    let(:valid_response) do
      [
        {
          "dn"    => ["ou=users,dc=example,dc=com"],
          "email" => "user@example.com"
        }
      ]
    end

    let(:multiple_emails) do
      [
        {
          "dn"    => ["ou=users,dc=example,dc=com"],
          "email" => ["user1@example.com", "user2@example.com"]
        }
      ]
    end

    it "returns a nil email if disabled" do
      ge = { "enabled" => false, "attr" => "" }
      APP_CONFIG["ldap"] = { "enabled" => true, "base" => "", "guess_email" => ge }

      lm = LdapMock.new(username: "name", password: "12341234")
      expect(lm.guess_email_test(valid_response)).to be_nil
    end

    it "returns a nil email if no records have been found" do
      ge = { "enabled" => true, "attr" => "" }
      APP_CONFIG["ldap"] = { "enabled" => true, "base" => "", "guess_email" => ge }

      lm = LdapMock.new(username: "name", password: "12341234")
      expect(lm.guess_email_test([])).to be_nil
    end

    it "returns a nil email if more than one dn gets returned" do
      ge = { "enabled" => true, "attr" => "" }
      APP_CONFIG["ldap"] = { "enabled" => true, "base" => "", "guess_email" => ge }

      lm = LdapMock.new(username: "name", password: "12341234")
      expect(lm.guess_email_test(multiple_dn)).to be_nil
    end

    it "returns a nil email if the dc hostname could not be guessed" do
      ge = { "enabled" => true, "attr" => "" }
      APP_CONFIG["ldap"] = { "enabled" => true, "base" => "", "guess_email" => ge }

      lm = LdapMock.new(username: "name", password: "12341234")
      expect(lm.guess_email_test(empty_dc)).to be_nil
    end

    it "returns a valid email if the dc can be guessed" do
      ge = { "enabled" => true, "attr" => "" }
      APP_CONFIG["ldap"] = { "enabled" => true, "base" => "", "guess_email" => ge }

      lm = LdapMock.new(username: "name", password: "12341234")
      expect(lm.guess_email_test(valid_response)).to eq "name@example.com"
    end

    it "returns a nil email if the specified attribute does not exist" do
      ge = { "enabled" => true, "attr" => "non_existing" }
      APP_CONFIG["ldap"] = { "enabled" => true, "base" => "", "guess_email" => ge }

      lm = LdapMock.new(username: "name", password: "12341234")
      expect(lm.guess_email_test(valid_response)).to be_nil
    end

    it "returns a valid email if the given attribute exists" do
      ge = { "enabled" => true, "attr" => "email" }
      APP_CONFIG["ldap"] = { "enabled" => true, "base" => "", "guess_email" => ge }

      lm = LdapMock.new(username: "name", password: "12341234")
      expect(lm.guess_email_test(valid_response)).to eq "user@example.com"
    end

    it "returns a the first vaild email if the given attr has a list" do
      ge = { "enabled" => true, "attr" => "email" }
      APP_CONFIG["ldap"] = { "enabled" => true, "base" => "", "guess_email" => ge }

      lm = LdapMock.new(username: "name", password: "12341234")
      expect(lm.guess_email_test(multiple_emails)).to eq "user1@example.com"
    end
  end
end
