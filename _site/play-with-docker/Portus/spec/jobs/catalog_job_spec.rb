require "rails_helper"

# Just opens up protected methods so they can be used in the test suite.
class CatalogJobMock < CatalogJob
  def update_registry!(catalog)
    super
  end
end

describe CatalogJob do
  describe "Empty database" do
    it "updates the registry" do
      registry  = create(:registry)
      namespace = create(:namespace, registry: registry)

      job = CatalogJobMock.new
      job.update_registry!([
                             { "name" => "busybox",                  "tags" => ["latest", "0.1"] },
                             { "name" => "alpine",                   "tags" => ["latest"]        },
                             { "name" => "#{namespace.name}/alpine", "tags" => ["latest"]        }
                           ])

      # Global repos.
      ns = Namespace.where(global: true)
      repos = Repository.where(namespace: ns)
      expect(repos.map(&:name).sort).to match_array(["alpine", "busybox"])
      tags = Repository.find_by(name: "busybox").tags
      expect(tags.map(&:name)).to match_array(["0.1", "latest"])
      tags = Repository.find_by(name: "alpine", namespace: ns).tags
      expect(tags.map(&:name)).to match_array(["latest"])

      # Local repos.
      repos = Repository.where(namespace: namespace)
      expect(repos.map(&:name).sort).to match_array(["alpine"])
      tags = repos.first.tags
      expect(tags.map(&:name)).to match_array(["latest"])
    end

    it "does nothing if there is no registry" do
      job = CatalogJobMock.new
      expect { job.perform }.to_not raise_error
    end

    it "raises an exception when there has been a problem in /v2/_catalog" do
      VCR.turn_on!

      create(:registry, "hostname" => "registry.test.lan")

      VCR.use_cassette("registry/get_missing_catalog_endpoint", record: :none) do
        job = CatalogJobMock.new
        expect(Rails.logger).to receive(:warn).with(/page not found/)
        job.perform
      end
    end

    it "performs the job as expected" do
      VCR.turn_on!

      registry = create(:registry, "hostname" => "registry.test.lan")

      VCR.use_cassette("registry/get_registry_catalog", record: :none) do
        job = CatalogJobMock.new
        job.perform
      end

      repos = Repository.all
      expect(repos.count).to be 1
      repo = repos[0]
      expect(repo.name).to eq "busybox"
      expect(repo.namespace.id).to eq registry.namespaces.first.id
      tags = repo.tags
      expect(tags.map(&:name)).to match_array(["latest"])
    end

    it "handles registries even if there some namespaces missing" do
      VCR.turn_on!

      registry = create(:registry, "hostname" => "registry.test.lan")

      VCR.use_cassette("registry/get_registry_catalog_namespace_missing", record: :none) do
        job = CatalogJobMock.new
        job.perform
      end

      repos = Repository.all
      expect(repos.count).to be 1
      repo = repos[0]
      expect(repo.name).to eq "busybox"
      expect(repo.namespace.id).to eq registry.namespaces.first.id
      tags = repo.tags
      expect(tags.map(&:name)).to match_array(["latest"])
    end

  end

  describe "Database already filled with repos" do
    let!(:registry)    { create(:registry) }
    let!(:owner)       { create(:user) }
    let!(:namespace)   { create(:namespace, registry: registry) }
    let!(:repo1)       { create(:repository, name: "repo1", namespace: namespace) }
    let!(:repo2)       { create(:repository, name: "repo2", namespace: namespace) }
    let!(:tag1)        { create(:tag, name: "tag1", repository: repo1) }
    let!(:tag2)        { create(:tag, name: "tag2", repository: repo2) }
    let!(:tag3)        { create(:tag, name: "tag3", repository: repo2) }

    it "updates the registry" do
      job = CatalogJobMock.new
      job.update_registry!([
                             { "name" => "busybox",                  "tags" => ["latest", "0.1"] },
                             { "name" => "#{namespace.name}/repo1",  "tags" => ["latest"]         },
                             { "name" => "#{namespace.name}/repo2",  "tags" => ["latest", "tag2"] },
                             { "name" => "#{namespace.name}/alpine", "tags" => ["latest"]         }
                           ])

      # Global repos
      ns = Namespace.where(global: true)
      repos = Repository.where(namespace: ns)
      expect(repos.map(&:name).sort).to match_array(["busybox"])
      tags = repos.first.tags
      expect(tags.map(&:name).sort).to match_array(["0.1", "latest"])

      # User namespaces.
      repos = Repository.where(namespace: namespace)
      expect(repos.map(&:name).sort).to match_array(["alpine", "repo1", "repo2"])
      tags = Repository.find_by(name: "alpine").tags
      expect(tags.map(&:name)).to match_array(["latest"])
      tags = Repository.find_by(name: "repo1").tags
      expect(tags.map(&:name)).to match_array(["latest"])
      tags = Repository.find_by(name: "repo2").tags
      expect(tags.map(&:name)).to match_array(["latest", "tag2"])
    end
  end

  describe "uploading repository whose tags is nil" do
    it "skip this repository" do
      job = CatalogJobMock.new
      job.update_registry!([{ "name" => "busybox", "tags" => nil }])

      # Global repos
      ns = Namespace.where(global: true)
      repos = Repository.where(namespace: ns)
      expect(repos.length).to eq 0
    end
  end

  describe "Activities are updated accordingly" do
    let!(:registry)   { create(:registry) }
    let!(:owner)      { create(:user) }
    let!(:repo)       { create(:repository, name: "repo", namespace: registry.global_namespace) }
    let!(:tag)        { create(:tag, name: "latest", author: owner, repository: repo) }

    it "removes activities from dangling tags" do
      repo.create_activity(:push, owner: owner, recipient: tag)
      expect(PublicActivity::Activity.count).to eq 1
      expect(PublicActivity::Activity.first.parameters[:tag_name]).to be_nil

      job = CatalogJobMock.new
      job.update_registry!([{ "name" => "repo", "tags" => ["0.1"] }])

      # Three activities: the original one, one more push for 0.1 and then the
      # delete for latest.
      expect(PublicActivity::Activity.count).to eq 3
      expect(PublicActivity::Activity.first.parameters[:tag_name]).to eq "latest"
      expect(PublicActivity::Activity.all[1].recipient.name).to eq "0.1"
      expect(PublicActivity::Activity.last.key).to eq "repository.delete"
    end
  end
end
