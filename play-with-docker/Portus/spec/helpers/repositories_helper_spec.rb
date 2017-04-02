require "rails_helper"

class CatalogJobMock < CatalogJob
  def update_registry!(catalog)
    super
  end
end

RSpec.describe RepositoriesHelper, type: :helper do
  describe "#render_push_activity" do
    let!(:registry)   { create(:registry, hostname: "registry:5000") }
    let!(:namespace)  { create(:namespace, name: "namespace", registry: registry) }
    let!(:owner)      { create(:user) }
    let!(:repo)       { create(:repository, name: "repo", namespace: registry.global_namespace) }
    let!(:repo1)      { create(:repository, name: "repo1", namespace: registry.global_namespace) }
    let!(:repo2)      { create(:repository, name: "repo2", namespace: registry.global_namespace) }
    let!(:repo3)      { create(:repository, name: "repo3", namespace: namespace) }
    let!(:tag)        { create(:tag, name: "latest", author: owner, repository: repo) }
    let!(:tag1)       { create(:tag, name: "0.1", author: owner, repository: repo) }
    let!(:tag2)       { create(:tag, name: "0.2", author: owner, repository: repo1) }
    let!(:tag3)       { create(:tag, name: "0.3", author: owner, repository: repo2) }
    let!(:tag4)       { create(:tag, name: "0.4", author: owner, repository: repo3) }

    it "creates the proper HTML for each kind of activity" do
      repo.create_activity(:push, owner: owner, recipient: tag, created_at: 1.hour.ago)
      repo.create_activity(:push, owner: owner, recipient: tag1, created_at: 2.hours.ago)
      repo1.create_activity(:push, owner: owner, recipient: tag2, created_at: 3.hours.ago)
      repo2.create_activity(:push, owner: owner, recipient: tag3, created_at: 4.hours.ago)
      repo3.create_activity(:push, owner: owner, recipient: tag4, created_at: 5.hours.ago)

      tag1.destroy
      repo1.destroy

      nameo  = owner.username
      global = registry.global_namespace.id

      expectations = [
        "<strong>#{nameo} pushed </strong><a href=\"/namespaces/#{global}\">registry:5000</a> / "\
          "<a href=\"/repositories/#{repo.id}\">repo:latest</a>",
        "<strong>#{nameo} pushed </strong><a href=\"/namespaces/#{global}\">registry:5000</a> / "\
          "<a href=\"/repositories/#{repo.id}\">repo</a>",
        "<strong>#{nameo} pushed </strong><span>a repository</span>",
        "<strong>#{nameo} pushed </strong><a href=\"/namespaces/#{global}\">registry:5000</a> / "\
          "<a href=\"/repositories/#{repo2.id}\">repo2:0.3</a>",
        "<strong>#{nameo} pushed </strong><a href=\"/namespaces/#{namespace.id}\">namespace</a> "\
          "/ <a href=\"/repositories/#{repo3.id}\">repo3:0.4</a>"
      ]

      idx = 0
      PublicActivity::Activity.all.order(created_at: :desc).each do |activity|
        html = render_push_activity(activity)
        expect(html).to eq expectations[idx]
        idx += 1
      end

      # And now the catalog job sweeps in.
      job = CatalogJobMock.new
      job.update_registry!([{ "name" => "repo", "tags" => ["0.1"] }])

      # Let's remove the other namespace, to force another case.
      namespace.destroy

      idx = 0

      na = "<strong>Someone pushed </strong><a href=\"/namespaces/#{global}\">registry:5000</a> / "\
           "<a href=\"/repositories/#{repo.id}\">repo:0.1</a>"
      expectations = expectations.unshift na

      # Changes because of the Catalog job.
      expectations[4] = "<strong>#{nameo} pushed </strong><a href=\"/namespaces/#{global}\">"\
        "registry:5000</a> / <span>repo2:0.3</span>"
      expectations[5] = "<strong>#{nameo} pushed </strong><span>namespace</span> / <span>repo"\
          "3:0.4</span>"

      # Push activities
      wh = { key: "repository.push" }
      PublicActivity::Activity.where(wh).order(created_at: :desc).each do |activity|
        html = render_push_activity(activity)
        expect(html).to eq expectations[idx]
        idx += 1
      end

      idx = 0
      expectations = [
        "<strong>Someone deleted </strong><a href=\"/namespaces/#{global}\">registry:5000</a> / "\
          "<a href=\"/repositories/#{repo.id}\">repo:latest</a>",
        "<strong>Someone deleted </strong><a href=\"/namespaces/#{global}\">registry:5000</a> / "\
          "<span>repo2:0.3</span>",
        "<strong>Someone deleted </strong><span>namespace</span> / <span>repo3:0.4</span>",
        "<strong>Someone deleted </strong><a href=\"/namespaces/#{global}\">registry:5000</a> / "\
            "<span>repo2</span>",
        "<strong>Someone deleted </strong><span>namespace</span> / <span>repo3</span>"
      ]

      # Delete Activities
      wh = "activities.key='repository.delete' OR activities.key='namespace.delete'"
      PublicActivity::Activity.where(wh).order(created_at: :desc).each do |activity|
        html = render_delete_activity(activity)
        expect(expectations).to include(html)
        idx += 1
      end
    end
  end
end
