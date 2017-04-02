require "integration/helper"
require "portus/registry_client"

def push_test_images
  name = ldap? ? "johnldap" : "john"
  email = "john@example.com"
  password = "12341234"
  create_user(name, email, password, true)
  expect { login(name, password, email) }.not_to raise_error

  # Pulling images that we should already have (so we go faster :P). Then
  # re-tag it so they can be pushed. The re-tag has another name, to avoid
  # clashes with other tests.
  name        = "registry"
  retag       = "registre"
  pulled_tags = ["2.3.1", "2.4.0", "latest"]
  pulled_tags.each do |tag|
    base  = "#{name}:#{tag}"
    tgt   = "#{retag}:#{tag}"
    img   = "library/#{base}"
    pull(img)
    system("docker tag #{img} #{registry_hostname}/#{tgt}")
  end

  expect(push("#{registry_hostname}/#{retag}")).to be_truthy

  # Wait until the registry has everything we need.
  eventually_expect(3) do
    tags = rails_exec("Tag.where(repository: Repository.find_by(name: '#{retag}')).to_json")
    tags.size
  end
end

integration "Client" do
  it "tells that a registry is reachable" do
    client = Portus::RegistryClient.new(registry_hostname)
    expect(client.reachable?).to be_truthy
  end

  it "fetches the catalog of pushed repositories" do
    push_test_images

    client = Portus::RegistryClient.new(registry_hostname)
    cat = client.catalog
    expected = { "registre" => ["2.3.1", "2.4.0", "latest"] }

    cat.each do |r|
      key = expected[r["name"]]
      next if key.nil?
      expect(key).to eq r["tags"]
    end

    tags = client.tags("registre")
    expect(tags).to eq(expected["registre"])
  end

  it "fetches the manifest of the given repo/tag" do
    push_test_images

    client = Portus::RegistryClient.new(registry_hostname)
    manifest = client.manifest("registre", "2.3.1")

    expect(manifest[0]).to_not be_empty
    expect(manifest[1]).to_not be_empty
    expect(manifest[2]["schemaVersion"]).to eq 2
  end

  it "supports deleting manifests" do
    push_test_images

    client = Portus::RegistryClient.new(registry_hostname)

    # Provided digest did not match uploaded content
    expect do
      client.delete("registry", "itsdangeroustogoalonetakethis", "manifests")
    end.to raise_error(RuntimeError)

    _, dig, = client.manifest("registre", "2.3.1")

    # Not found
    expect do
      client.delete("registry", dig, "manifests")
    end.to raise_error(Portus::HttpHelpers::NotFoundError)

    client.delete("registre", dig, "manifests")
    eventually_expect(2) { rails_exec("Tag.all.to_json").size }
  end
end
