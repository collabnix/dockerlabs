require "rails_helper"
require "rake"

def capture_stdout(&_block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end

describe "Updating namespaces from 2.0 to 2.1" do
  let!(:registry) { create(:registry) }
  let!(:admin) { create(:admin, username: "miquelsabate", ldap_name: "miquel.sabate") }

  before :each do
    load Rails.root.join("lib/tasks/migrate.rake")
    Rake::Task.define_task(:environment)
    APP_CONFIG["ldap"] = { "enabled" => true }
    ENV["PORTUS_FORCE_LDAP_NAME_UPDATE"] = "true"
  end

  after :each do
    ENV["PORTUS_FORCE_LDAP_NAME_UPDATE"] = nil
  end

  it "handles updating namespaces" do
    ns = Namespace.find_by(name: "miquelsabate")

    capture_stdout do
      Rake.application.invoke_task("migrate:update_personal_namespaces")
      Rake.application.invoke_task("migrate:update_ldap_names")
    end

    user = User.find_by(username: "miquel.sabate")
    expect(user.namespace.id).to eq ns.id
    expect(user.username).to eq user.ldap_name
  end
end
