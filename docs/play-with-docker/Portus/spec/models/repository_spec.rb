# == Schema Information
#
# Table name: repositories
#
#  id           :integer          not null, primary key
#  name         :string(255)      default(""), not null
#  namespace_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  marked       :boolean          default("0")
#
# Indexes
#
#  fulltext_index_repositories_on_name          (name)
#  index_repositories_on_name_and_namespace_id  (name,namespace_id) UNIQUE
#  index_repositories_on_namespace_id           (namespace_id)
#

require "rails_helper"

# Auxiliar method to get the URL format used in this spec file.
def get_url(repo, tag)
  "http://registry.test.lan/v2/#{repo}/manifests/#{tag}"
end

describe Repository do
  it { should belong_to(:namespace) }
  it { should have_many(:tags) }
  it { should have_many(:stars) }

  describe "starrable behaviour" do
    let(:user) { create(:user) }
    let(:repository) { create(:repository) }
    let(:star) { create(:star, user: user, repository: repository) }
    let(:other_user) { create(:user) }

    it "should identify if it is already starred by a user" do
      expect(star.repository.starred_by?(user)).to be true
      expect(star.repository.starred_by?(other_user)).to be false
    end

    it "should be starrable by a user" do
      repository.toggle_star(user)
      expect(repository.starred_by?(user)).to be true
      expect(repository.starred_by?(other_user)).to be false
    end

    it "should be unstarrable by a user" do
      repository = star.repository
      repository.toggle_star(user)
      expect(repository.starred_by?(user)).to be false
      expect(repository.starred_by?(other_user)).to be false
    end
  end

  describe "#full_name" do
    let(:registry) { create(:registry) }

    it "returns the bare name when it lives in a global namespace" do
      repository = create(:repository, namespace: registry.global_namespace)
      expect(repository.full_name).to eq repository.name
    end

    it "returns the namespaced name when it lives inside of a namespace" do
      team = create(:team)
      namespace = create(:namespace, name: "a", team: team)
      repository = create(:repository, namespace: namespace)
      expect(repository.full_name).to eq "a/#{repository.name}"
    end
  end

  describe "handle push event" do
    let(:tag_name) { "latest" }
    let(:repository_name) { "busybox" }
    let(:registry) do
      create(:registry,
             hostname:          "registry.test.lan",
             external_hostname: "external.test.lan")
    end
    let(:user) { create(:user) }

    before :each do
      VCR.turn_on!
    end

    context "adding an existing repo/tag" do
      it "adds a new activity when an already existing repo/tag already existed" do
        event = { "actor" => { "name" => user.username } }

        # First we create it, and make sure that it creates the activity.
        expect do
          Repository.add_repo(event, registry.global_namespace, repository_name, tag_name)
        end.to change(PublicActivity::Activity, :count).by(1)

        # And now it should create another activities.
        expect do
          Repository.add_repo(event, registry.global_namespace, repository_name, tag_name)
        end.to change(PublicActivity::Activity, :count).by(1)
      end

      it "updates the digest of an already existing tag" do
        event = { "actor" => { "name" => user.username }, "target" => { "digest" => "foo" } }
        Repository.add_repo(event, registry.global_namespace, repository_name, tag_name)
        expect(Repository.find_by(name: repository_name).tags.first.digest).to eq("foo")

        # Making sure that the updated_at column is set in the past.
        tag = Repository.find_by(name: repository_name).tags.first
        tag.update!(updated_at: 2.hours.ago)
        ua = tag.updated_at

        event["target"]["digest"] = "bar"
        Repository.add_repo(event, registry.global_namespace, repository_name, tag_name)
        tag = Repository.find_by(name: repository_name).tags.first
        expect(tag.digest).to eq("bar")
        expect(tag.updated_at).to_not eq(ua)
      end

      it "updates the image id of an already existing tag" do
        allow(Repository).to receive(:id_and_digest_from_event).and_return(["image_id", "foo"])
        event = { "actor" => { "name" => user.username }, "target" => { "digest" => "foo" } }
        Repository.add_repo(event, registry.global_namespace, repository_name, tag_name)
        expect(Repository.find_by(name: repository_name).tags.first.digest).to eq("foo")

        # Making sure that the updated_at column is set in the past.
        tag = Repository.find_by(name: repository_name).tags.first
        tag.update!(updated_at: 2.hours.ago)
        ua = tag.updated_at

        allow(Repository).to receive(:id_and_digest_from_event).and_return(["id", "bar"])
        Repository.add_repo(event, registry.global_namespace, repository_name, tag_name)
        tag = Repository.find_by(name: repository_name).tags.first
        expect(tag.image_id).to eq("id")
        expect(tag.digest).to eq("bar")
        expect(tag.updated_at).to_not eq(ua)
      end
    end

    context "event does not match regexp of manifest" do
      let(:event) do
        e = build(:raw_push_manifest_event).to_test_hash
        e["target"]["repository"] = repository_name
        e["target"]["url"] = "http://registry.test.lan/v2/#{repository_name}/wrong/#{tag_name}"
        e["request"]["host"] = registry.hostname
        e
      end

      it "sends event to logger" do
        VCR.use_cassette("registry/get_image_manifest_webhook", record: :none) do
          expect do
            Repository.handle_push_event(event)
          end.to change(Repository, :count).by(0)
        end
      end
    end

    context "event comes from an internally named registry" do
      before :each do
        @event = build(:raw_push_manifest_event).to_test_hash
        @event["target"]["repository"] = repository_name
        @event["target"]["url"] = get_url(repository_name, tag_name)
        @event["target"]["mediaType"] = "application/vnd.docker.distribution.manifest.v1+json"
        @event["request"]["host"] = "registry.test.lan"
        @event["actor"]["name"] = user.username
      end

      it "sends event to logger" do
        expect(Rails.logger).to receive(:info)
        expect do
          Repository.handle_push_event(@event)
        end.to change(Repository, :count).by(0)
      end

      it "finds an internal registry" do
        registry # create registry

        reg = Registry.find_by(hostname: @event["request"]["host"])
        expect(reg).not_to be_nil

        reg = Registry.find_from_event(@event)
        expect(reg).not_to be_nil
      end
    end

    context "event comes from an externally named registry" do
      before :each do
        @event = build(:raw_push_manifest_event).to_test_hash
        @event["target"]["repository"] = repository_name
        @event["target"]["url"] = get_url(repository_name, tag_name)
        @event["target"]["mediaType"] = "application/vnd.docker.distribution.manifest.v1+json"
        @event["request"]["host"] = "external.test.lan"
        @event["actor"]["name"] = user.username
      end

      it "sends event to logger" do
        expect(Rails.logger).to receive(:info)
        expect do
          Repository.handle_push_event(@event)
        end.to change(Repository, :count).by(0)
      end

      it "finds an external registry" do
        registry # create registry

        reg = Registry.find_by(hostname: @event["request"]["host"])
        expect(reg).to be_nil

        reg = Registry.find_from_event(@event)
        expect(reg).not_to be_nil
      end
    end

    context "event comes from an unknown registry" do
      before :each do
        @event = build(:raw_push_manifest_event).to_test_hash
        @event["target"]["repository"] = repository_name
        @event["target"]["url"] = get_url(repository_name, tag_name)
        @event["target"]["mediaType"] = "application/vnd.docker.distribution.manifest.v1+json"
        @event["request"]["host"] = "unknown-registry.test.lan"
        @event["actor"]["name"] = user.username
      end

      it "sends event to logger" do
        expect(Rails.logger).to receive(:info)
        expect do
          Repository.handle_push_event(@event)
        end.to change(Repository, :count).by(0)
      end

      it "doesn't find any registry" do
        registry # create registry

        reg = Registry.find_from_event(@event)
        expect(reg).to be_nil
      end
    end

    context "event comes from an unknown user" do
      before :each do
        @event = build(:raw_push_manifest_event).to_test_hash
        @event["target"]["repository"] = repository_name
        @event["target"]["url"] = get_url(repository_name, tag_name)
        @event["target"]["mediaType"] = "application/vnd.docker.distribution.manifest.v1+json"
        @event["request"]["host"] = registry.hostname
        @event["actor"]["name"] = "a_ghost"
      end

      it "sends event to logger" do
        expect do
          Repository.handle_push_event(@event)
        end.to change(Repository, :count).by(0)
      end

    end

    context "when dealing with a top level repository" do
      before :each do
        @event = build(:raw_push_manifest_event).to_test_hash
        @event["target"]["repository"] = repository_name
        @event["target"]["url"] = get_url(repository_name, "digest")
        @event["target"]["mediaType"] = "application/vnd.docker.distribution.manifest.v1+json"
        @event["target"]["digest"] = "digest"
        @event["request"]["host"] = registry.hostname
        @event["actor"]["name"] = user.username
      end

      context "when the repository is not known by Portus" do
        it "should create repository and tag objects" do
          repository = nil
          VCR.use_cassette("registry/get_image_manifest_webhook", record: :none) do
            expect do
              repository = Repository.handle_push_event(@event)
            end.to change(Namespace, :count).by(0)
          end

          expect(repository).not_to be_nil
          expect(Repository.count).to eq 1
          expect(Tag.count).to eq 1

          expect(repository.namespace).to eq(registry.global_namespace)
          expect(repository.name).to eq(repository_name)
          expect(repository.tags.count).to eq 1
          expect(repository.tags.first.name).to eq tag_name
          expect(repository.tags.find_by(name: tag_name).author).to eq(user)
        end

        it "creates the repo also for version 2 schema 2" do
          repository = nil
          @event["target"]["mediaType"] = "application/vnd.docker.distribution.manifest.v2+json"

          VCR.use_cassette("registry/get_tags_list_webhook", record: :none) do
            expect do
              repository = Repository.handle_push_event(@event)
            end.to change(Namespace, :count).by(0)
          end

          expect(repository).not_to be_nil
          expect(Repository.count).to eq 1
          expect(Tag.count).to eq 1

          expect(repository.namespace).to eq(registry.global_namespace)
          expect(repository.name).to eq(repository_name)
          expect(repository.tags.count).to eq 1
          expect(repository.tags.first.name).to eq tag_name
          expect(repository.tags.find_by(name: tag_name).author).to eq(user)
        end

        it "tracks the event" do
          repository = nil
          VCR.use_cassette("registry/get_image_manifest_webhook", record: :none) do
            expect do
              repository = Repository.handle_push_event(@event)
            end.to change(PublicActivity::Activity, :count).by(1)
          end

          activity = PublicActivity::Activity.last
          expect(activity.key).to eq("repository.push")
          expect(activity.owner).to eq(user)
          expect(activity.trackable).to eq(repository)
          expect(activity.recipient).to eq(repository.tags.last)
          expect(repository.tags.find_by(name: tag_name).author).to eq(user)
        end
      end

      context "when a new version of an already known repository" do
        before :each do
          repository = create(:repository, name:      repository_name,
                                           namespace: registry.global_namespace)
          repository.tags << Tag.new(name: "1.0.0")
        end

        it "should create a new tag" do
          repository = nil
          VCR.use_cassette("registry/get_image_manifest_webhook", record: :none) do
            expect do
              repository = Repository.handle_push_event(@event)
            end.to change(Namespace, :count).by(0)
          end

          expect(repository).not_to be_nil
          expect(Repository.count).to eq 1
          expect(Tag.count).to eq 2

          expect(repository.namespace).to eq(registry.global_namespace)
          expect(repository.name).to eq(repository_name)
          expect(repository.tags.count).to eq 2
          expect(repository.tags.map(&:name)).to include("1.0.0", tag_name)
          expect(repository.tags.find_by(name: tag_name).author).to eq(user)
        end

        it "tracks the event" do
          repository = nil
          VCR.use_cassette("registry/get_image_manifest_webhook", record: :none) do
            expect do
              repository = Repository.handle_push_event(@event)
            end.to change(PublicActivity::Activity, :count).by(1)
          end

          activity = PublicActivity::Activity.last
          expect(activity.key).to eq("repository.push")
          expect(activity.owner).to eq(user)
          expect(activity.recipient).to eq(repository.tags.find_by(name: tag_name))
          expect(activity.trackable).to eq(repository)
          expect(repository.tags.find_by(name: tag_name).author).to eq(user)
        end
      end

      context "re-tagging of a known image from one namespace to another" do
        let(:repository_namespaced_name) { "portus/busybox" }
        let(:admin) { create(:admin) }

        before :each do
          team_user = create(:team, owners: [admin])
          @ns = create(:namespace, name: "portus", team: team_user, registry: registry)
          create(:repository, name: "busybox", namespace: registry.global_namespace)
        end

        it "preserves the previous namespace" do
          event = @event
          event["target"]["repository"] = repository_namespaced_name
          event["target"]["url"] = get_url(repository_namespaced_name, tag_name)
          VCR.use_cassette("registry/get_image_manifest_another_webhook", record: :none) do
            Repository.handle_push_event(event)
          end

          repos = Repository.all.order("id ASC")
          expect(repos.count).to be(2)
          expect(repos.first.namespace.id).to be(registry.global_namespace.id)
          expect(repos.last.namespace.id).to be(@ns.id)
        end
      end
    end

    context "not global repository" do
      let(:namespace_name) { "suse" }
      let(:digest) { "digest" }

      before :each do
        name = "#{namespace_name}/#{repository_name}"

        @event = build(:raw_push_manifest_event).to_test_hash
        @event["target"]["repository"] = name
        @event["target"]["url"] = get_url(name, tag_name)
        @event["target"]["mediaType"] = "application/vnd.docker.distribution.manifest.v1+json"
        @event["target"]["digest"] = digest
        @event["request"]["host"] = registry.hostname
        @event["actor"]["name"] = user.username
      end

      context "when the namespace is not known by Portus" do
        it "does not create the namespace" do
          repository = Repository.handle_push_event(@event)
          expect(repository).to be_nil
        end
      end

      context "when the namespace is known by Portus" do
        before :each do
          @namespace = create(:namespace, name: namespace_name, registry: registry)
        end

        it "should create repository and tag objects when the repository is unknown to portus" do
          repository = nil
          VCR.use_cassette("registry/get_image_manifest_namespaced_webhook", record: :none) do
            repository = Repository.handle_push_event(@event)
          end

          expect(repository).not_to be_nil
          expect(Repository.count).to eq 1
          expect(Repository.count).to eq 1
          expect(Tag.count).to eq 1

          expect(repository.namespace.name).to eq(namespace_name)
          expect(repository.name).to eq(repository_name)
          expect(repository.tags.count).to eq 1
          expect(repository.tags.first.name).to eq tag_name
          expect(repository.tags.first.digest).to eq digest
          expect(repository.tags.find_by(name: tag_name).author).to eq(user)
        end

        it "should create a new tag when the repository is already known to portus" do
          repository = create(:repository, name: repository_name, namespace: @namespace)
          repository.tags << Tag.new(name: "1.0.0")

          VCR.use_cassette("registry/get_image_manifest_namespaced_webhook", record: :none) do
            repository = Repository.handle_push_event(@event)
          end

          expect(repository).not_to be_nil
          expect(Repository.count).to eq 1
          expect(Repository.count).to eq 1
          expect(Tag.count).to eq 2

          expect(repository.namespace.name).to eq(namespace_name)
          expect(repository.name).to eq(repository_name)
          expect(repository.tags.count).to eq 2
          expect(repository.tags.map(&:name)).to include("1.0.0", tag_name)
          expect(repository.tags.find_by(name: tag_name).author).to eq(user)
        end

        it "repo is unknown - manifest version 2, schema 2" do
          @event["target"]["mediaType"] = "application/vnd.docker.distribution.manifest.v2+json"

          repository = nil
          VCR.use_cassette("registry/get_image_manifest_namespaced_webhook_v2", record: :none) do
            expect do
              repository = Repository.handle_push_event(@event)
            end.to change(Repository, :count).by(1)
          end

          expect(repository).not_to be_nil
          expect(Repository.count).to eq 1
          expect(Repository.count).to eq 1
          expect(Tag.count).to eq 1

          expect(repository.namespace.name).to eq(namespace_name)
          expect(repository.name).to eq(repository_name)
          expect(repository.tags.count).to eq 1
          expect(repository.tags.first.name).to eq tag_name
          expect(repository.tags.first.digest).to eq digest
          expect(repository.tags.find_by(name: tag_name).author).to eq(user)
        end

        it "repo exists - manifest version 2, schema 2" do
          @event["target"]["mediaType"] = "application/vnd.docker.distribution.manifest.v2+json"
          repository = create(:repository, name: repository_name, namespace: @namespace)
          repository.tags << Tag.new(name: "1.0.0")

          VCR.use_cassette("registry/get_image_manifest_namespaced_webhook_v2", record: :none) do
            repository = Repository.handle_push_event(@event)
          end

          expect(repository).not_to be_nil
          expect(Repository.count).to eq 1
          expect(Repository.count).to eq 1
          expect(Tag.count).to eq 2

          expect(repository.namespace.name).to eq(namespace_name)
          expect(repository.name).to eq(repository_name)
          expect(repository.tags.count).to eq 2
          expect(repository.tags.map(&:name)).to include("1.0.0", tag_name)
          expect(repository.tags.find_by(name: tag_name).author).to eq(user)
        end
      end
    end
  end

  describe "create_or_update" do
    let!(:registry)    { create(:registry) }
    let!(:owner)       { create(:user) }
    let!(:portus)      { create(:user, username: "portus") }
    let!(:team)        { create(:team, owners: [owner]) }
    let!(:namespace)   { create(:namespace, team: team) }
    let!(:repo1)       { create(:repository, name: "repo1", namespace: namespace) }
    let!(:repo2)       { create(:repository, name: "repo2", namespace: namespace) }
    let!(:tag1)        { create(:tag, name: "tag1", repository: repo1, digest: "foo") }
    let!(:tag2)        { create(:tag, name: "tag2", repository: repo2) }
    let!(:tag3)        { create(:tag, name: "tag3", repository: repo2) }

    before :each do
      # Even if the returned value is dummy, we want to make sure that the
      # given arguments are set accordingly. The checked values are basically
      # hardcoded, which shouldn't be a problem since there are not a lot of
      # tests anyways.
      allow_any_instance_of(Portus::RegistryClient).to receive(:manifest) do |_, *args|
        if args.first != "busybox" && !args.first.include?("/")
          raise "Should be included inside of a namespace"
        end
        if args.last != "latest" && args.last != "0.1" && args.last != "tag1"
          raise "Using an unknown tag"
        end

        ["id", "digest", ""]
      end

      allow(Repository).to receive(:id_and_digest_from_event).and_return(["id", "digest"])
    end

    it "adds and deletes tags accordingly" do
      # Update existing tag's digest
      repo = { "name" => "#{namespace.name}/repo1", "tags" => ["tag1"] }
      repo = Repository.create_or_update!(repo)
      expect(repo.id).to eq repo1.id
      expect(repo.tags.find_by(name: "tag1").digest).to match("digest")

      # Removes the existing tag and adds two.
      repo = { "name" => "#{namespace.name}/repo1", "tags" => ["latest", "0.1"] }
      repo = Repository.create_or_update!(repo)
      expect(repo.id).to eq repo1.id
      expect(repo.tags.map(&:name).sort).to match_array(["0.1", "latest"])

      # Make sure that the portus user is set to be the author of the tags.
      authors = repo.tags.map(&:author).uniq
      expect(authors.count).to eq 1
      expect(authors.first).to be_portus

      # Just adds a new tag.
      repo = { "name" => "#{namespace.name}/repo2",
               "tags" => ["latest", tag2.name, tag3.name] }
      repo = Repository.create_or_update!(repo)
      expect(repo.id).to eq repo2.id
      ary = [tag2.name, tag3.name, "latest"].sort
      expect(repo.tags.map(&:name).sort).to match_array(ary)

      # Create repo and tags.
      repo = { "name" => "busybox", "tags" => ["latest", "0.1"] }
      repo = Repository.create_or_update!(repo)
      expect(repo.name).to eq "busybox"
      expect(repo.tags.map(&:name).sort).to match_array(["0.1", "latest"])
      expect(repo.tags.map(&:digest).uniq).to match_array(["digest"])

      # Trying to create a repo into an unknown namespace.
      repo = { "name" => "unknown/repo1", "tags" => ["latest", "0.1"] }
      expect(Repository.create_or_update!(repo)).to be_nil
    end

    it "doesn't remove tags of same name for different repo" do
      # create "latest" for repo1 and repo2
      event_one = { "name" => "#{namespace.name}/repo1", "tags" => ["latest"] }
      Repository.create_or_update!(event_one)
      event_two = { "name" => "#{namespace.name}/repo2", "tags" => ["latest"] }
      Repository.create_or_update!(event_two)

      # remove "latest" for repo2
      event_three = { "name" => "#{namespace.name}/repo2", "tags" => ["other"] }
      Repository.create_or_update!(event_three)

      expect(repo1.tags.pluck(:name)).to include("latest")
      expect(repo2.tags.pluck(:name)).not_to include("latest")
    end
  end

  describe "Groupped tags" do
    let!(:registry)   { create(:registry) }
    let!(:owner)      { create(:user) }
    let!(:portus)     { create(:user, username: "portus") }
    let!(:team)       { create(:team, owners: [owner]) }
    let!(:namespace)  { create(:namespace, team: team) }
    let!(:repo)        { create(:repository, namespace: namespace) }
    let!(:tag1)        { create(:tag, repository: repo, digest: "1234") }
    let!(:tag2)        { create(:tag, repository: repo, digest: tag1.digest) }
    let!(:tag3)        { create(:tag, repository: repo, digest: "5678", created_at: 2.hours.ago) }

    it "groups tags as expected" do
      tags = repo.groupped_tags
      expect(tags.size).to eq 2
      expect(tags.flatten.map(&:name).uniq).to eq [tag1.name, tag2.name, tag3.name]
      expect(tags.flatten.map(&:digest).uniq).to eq ["1234", "5678"]
    end
  end

  describe "handle delete event" do
    let!(:registry)   { create(:registry) }
    let!(:owner)      { create(:user) }
    let!(:portus)     { create(:user, username: "portus") }
    let!(:team)       { create(:team, owners: [owner]) }
    let!(:namespace)  { create(:namespace, team: team, registry: registry) }
    let!(:repo)       { create(:repository, namespace: namespace) }
    let!(:tag1)       { create(:tag, repository: repo, digest: "1234") }
    let!(:tag2)       { create(:tag, repository: repo, digest: tag1.digest) }
    let!(:tag3)       { create(:tag, repository: repo, digest: "5678") }

    let!(:event) do
      {
        "id"        => "6d673710-06b5-48b5-a7d9-94cbaacf776b",
        "timestamp" => "2016-04-13T15:03:39.595901492+02:00",
        "action"    => "delete",
        "target"    => {
          "digest"     => "sha256:03d564cd8008f956c844cd3e52affb49bc0b65e451087a1ac9013c0140c595df",
          "repository" => namespace.name + "/" + repo.name
        },
        "request"   => {
          "id"        => "fae66612-ef48-4157-8994-bd146fbdd951",
          "addr"      => "127.0.0.1:55452",
          "host"      => registry.hostname,
          "method"    => "DELETE",
          "useragent" => "Ruby"
        },
        "actor"     => {
          "name" => "portus"
        },
        "source"    => {
          "addr"       => "bucket:5000",
          "instanceID" => "741bc03b-6ebe-4ffc-b6b1-4b33d5fc2090"
        }
      }
    end

    it "doesn't do anything for a non-existing tag" do
      Repository.handle_delete_event(event)
      expect(Repository.count).to eq 1
      expect(Tag.count).to eq 3
    end

    it "does not allow to delete a tag from a non-existing repository" do
      # Digest exists but not the repo.
      another = event.dup
      another["target"]["digest"] = tag1.digest
      another["target"]["repository"] = "unknown"

      Repository.handle_delete_event(another)
      expect(Repository.count).to eq 1
      expect(Tag.count).to eq 3
    end

    it "deletes an existing tags, and the image when empty" do
      another = event.dup
      another["target"]["digest"] = tag1.digest

      Repository.handle_delete_event(another)
      expect(Repository.count).to eq 1
      expect(Tag.count).to eq 1 # 2 were deleted because there was a re-tag

      another["target"]["digest"] = tag3.digest

      Repository.handle_delete_event(another)
      expect(Repository.count).to eq 0
      expect(Tag.count).to eq 0
    end
  end

  describe "#delete_and_update!" do
    let(:registry)        { create(:registry, hostname: "registry.test.lan") }
    let(:user)            { create(:user) }
    let(:repository_name) { "busybox" }
    let(:tag_name)        { "latest" }

    it "deletes the repository and updates activities accordingly" do
      event = { "actor" => { "name" => user.username } }

      # First we create it, and make sure that it creates the activity.
      repo = nil
      expect do
        repo = Repository.add_repo(event, registry.global_namespace, repository_name, tag_name)
      end.to change(PublicActivity::Activity, :count).by(1)

      activity = PublicActivity::Activity.first
      expect(activity.trackable_type).to eq "Repository"
      expect(activity.trackable_id).to eq Repository.first.id
      expect(activity.key).to eq "repository.push"
      expect(activity.owner_id).to eq user.id
      expect(activity.parameters).to be_empty

      # And now delete and see what happens.
      expect do
        repo.delete_and_update!(user)
      end.to change(PublicActivity::Activity, :count).by(1)

      # The original push activity has changed, so it's still trackable.
      activity = PublicActivity::Activity.first
      expect(activity.trackable_type).to eq "Namespace"
      expect(activity.trackable_id).to eq registry.global_namespace.id
      expect(activity.key).to eq "repository.push"
      expect(activity.owner_id).to eq user.id
      expect(activity.parameters).to be_empty

      # There's now a delete activity.
      activity = PublicActivity::Activity.last
      expect(activity.trackable_type).to eq "Namespace"
      expect(activity.trackable_id).to eq registry.global_namespace.id
      expect(activity.key).to eq "namespace.delete"
      expect(activity.owner_id).to eq user.id
      expect(activity.parameters).to eq(repository_name: repository_name,
                                        namespace_id:    registry.global_namespace.id,
                                        namespace_name:  registry.global_namespace.clean_name)

      # Of course, the repo should be removed
      expect(Repository.count).to eq 0
    end
  end
end
