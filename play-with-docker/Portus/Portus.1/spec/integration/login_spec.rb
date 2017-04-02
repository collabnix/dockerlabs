require "integration/helper"

integration "Login" do
  let(:name)      { ldap? ? "johnldap" : "john" }
  let(:email)     { "john@example.com" }
  let(:password)  { "12341234" }

  after :each do
    `docker logout #{registry_hostname}`
  end

  it "logs in a valid user" do
    create_user(name, email, password, true)

    # Valid user.
    expect { login(name, password, email) }.not_to raise_error

    # Invalid name.
    expect { login(name + "o", password, email) }.to raise_error(LoginError)

    # Invalid password.
    expect { login(name, password + "o", email) }.to raise_error(LoginError)

    create_user("mc!", email, password, true)
    expect { login(name, password, email) }.not_to raise_error

  end

  it "allows users to push images with multiple tags" do
    create_user(name, email, password, true)
    expect { login(name, password, email) }.not_to raise_error

    # Pulling images that we should already have (so we go faster :P). Then
    # re-tag it so they can be pushed. We tag both a pusheable image and
    # another one that cannot be pushed (namespace does not exist).
    imagename   = "registry"
    pulled_tags = ["2.2.1", "2.3"]
    pulled_tags.each do |tag|
      base  = "#{imagename}:#{tag}"
      img   = "library/#{base}"

      pull(img)
      system("docker tag #{img} #{registry_hostname}/#{img}")
      system("docker tag #{img} #{registry_hostname}/#{base}")
    end

    # Pushing...
    expect(push("#{registry_hostname}/#{imagename}")).to be_truthy
    expect(push("#{registry_hostname}/library/#{imagename}", false)).to be_truthy

    # And finally let's see what's inside the DB. The registry might not be
    # ready yet, so let's call it inside of `eventually_expect`.
    repos = []
    tags = []
    eventually_expect(1) do
      repos = rails_exec("Repository.all.to_json")
      repos.size
    end
    eventually_expect(2) do
      tags = rails_exec("Tag.all.to_json")
      tags.size
    end

    expect(repos.first["name"]).to eq "registry"
    names = tags.map { |t| t["name"] }
    expect(names).to eq pulled_tags
  end

  it "handles the personal namespace properly" do
    create_user(name, email, password, true)
    expect { login(name, password, email) }.not_to raise_error

    # Push an image to the personal namespace.
    img     = "registry:2.3"
    target  = "#{registry_hostname}/#{name}/#{img}"
    pull(img)
    system("docker tag #{img} #{target}")
    expect(push(target)).to be_truthy

    # Logout and try to pull/push it. It should fail.
    logout!
    expect(spawn_cmd("docker pull #{target}")).to be_falsey
    expect(push(target, false)).to be_truthy
  end

  it "handles viewers, contributors and owners accordingly" do
    # TODO: once create_user works on LDAP, remove this guard.
    unless ldap?
      owner       = "owner"
      contributor = "contributor"
      viewer      = "viewer"

      create_user(owner, email, password, true)
      create_user(contributor, "test1@email.com", password)
      create_user(viewer, "test2@email.com", password)

      rb = <<HERE
team = Team.new(name: 'team')
owner = User.find_by(username: '#{owner}')
contributor = User.find_by(username: '#{contributor}')
viewer = User.find_by(username: '#{viewer}')
team.owners = [owner]
team.contributors = [contributor]
team.viewers = [viewer]
team.save
Namespace.create(team: team.reload, name: 'namespace', registry: Registry.get)
HERE
      docker_exec("integration_portus", "rails r \"#{rb}\"")

      expect { login(owner, password, email) }.not_to raise_error

      # Push an image to the team namespace.
      img     = "registry:2.3"
      target  = "#{registry_hostname}/namespace/#{img}"
      pull(img)
      system("docker tag #{img} #{target}")

      # Owner can push.
      expect(push(target)).to be_truthy
      logout!

      # Contributor can push.
      expect { login(contributor, password, email) }.not_to raise_error
      expect(push(target)).to be_truthy
      logout!

      # Viewer cannot push.
      expect { login(viewer, password, email) }.not_to raise_error
      expect(push(target, false)).to be_truthy
    end
  end

  it "allows anonymous users to pull from the global namespace, but not to push" do
    create_user(name, email, password, true)
    expect { login(name, password, email) }.not_to raise_error

    # Push an image to the global namespace.
    img     = "registry:2.3"
    target  = "#{registry_hostname}/#{img}"
    pull(img)
    system("docker tag #{img} #{target}")
    expect(push(target)).to be_truthy

    # Logout and try to pull/push it.
    logout!
    eventually_expect(true) { spawn_cmd("docker pull #{target}") }
    expect(push(target, false)).to be_truthy
  end
end
