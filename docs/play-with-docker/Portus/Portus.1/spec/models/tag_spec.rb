# == Schema Information
#
# Table name: tags
#
#  id            :integer          not null, primary key
#  name          :string(255)      default("latest"), not null
#  repository_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  digest        :string(255)
#  image_id      :string(255)      default("")
#  marked        :boolean          default("0")
#  username      :string(255)
#
# Indexes
#
#  index_tags_on_name_and_repository_id  (name,repository_id) UNIQUE
#  index_tags_on_repository_id           (repository_id)
#  index_tags_on_user_id                 (user_id)
#

require "rails_helper"

# Mock class that opens up the `fetch_digest` method as `fetch_digest_test` so
# it can be properly unit tested.
class TagMock < Tag
  def fetch_digest_test
    fetch_digest
  end
end

describe Tag do
  let!(:registry)   { create(:registry, hostname: "registry.test.lan") }
  let!(:user)       { create(:admin) }
  let!(:repository) { create(:repository, namespace: registry.global_namespace, name: "repo") }

  it { should belong_to(:repository) }
  it { should belong_to(:author) }

  describe "#delete_by_digest!" do
    let!(:tag)  { create(:tag, name: "tag1", repository: repository, digest: "1") }
    let!(:tag2) { create(:tag, name: "tag2", repository: repository, digest: "2") }

    it "returns false if there is no digest" do
      allow_any_instance_of(Tag).to receive(:fetch_digest).and_return(nil)
      expect(tag.delete_by_digest!(user)).to be_falsey
    end

    it "returns false if the registry client could not delete the tag" do
      allow_any_instance_of(Portus::RegistryClient).to receive(:delete) do
        raise "I AM ERROR."
      end

      # That being said, the tag should be "marked".
      expect(tag.delete_by_digest!(user)).to be_falsey
      expect(tag.reload.marked?).to be_truthy
    end

    it "deletes the tag and updates corresponding activities" do
      # Create push activities. This is important so we can test afterwards
      # that they will get updated on removal.
      repository.create_activity(:push, owner: user, recipient: tag)
      repository.create_activity(:push, owner: user, recipient: tag2)

      tag.delete_and_update!(user)

      expect(PublicActivity::Activity.count).to eq 3

      # The first activity is the first push, which should've changed.
      activity = PublicActivity::Activity.first
      expect(activity.trackable_type).to eq "Repository"
      expect(activity.trackable_id).to eq repository.id
      expect(activity.owner_id).to eq user.id
      expect(activity.key).to eq "repository.push"
      expect(activity.parameters).to eq(namespace_id:   registry.global_namespace.id,
                                        namespace_name: registry.global_namespace.clean_name,
                                        repo_name:      repository.name,
                                        tag_name:       tag.name)

      # The second activity is the other push, which is unaffected by this
      # action.
      activity = PublicActivity::Activity.all[1]
      expect(activity.trackable_type).to eq "Repository"
      expect(activity.trackable_id).to eq repository.id
      expect(activity.owner_id).to eq user.id
      expect(activity.key).to eq "repository.push"
      expect(activity.parameters).to be_empty

      # The last activity is the removal of the tag.
      activity = PublicActivity::Activity.last
      expect(activity.trackable_type).to eq "Repository"
      expect(activity.trackable_id).to eq repository.id
      expect(activity.owner_id).to eq user.id
      expect(activity.key).to eq "repository.delete"
      expect(activity.parameters).to eq(namespace_id:    registry.global_namespace.id,
                                        namespace_name:  registry.global_namespace.clean_name,
                                        repository_name: repository.name,
                                        tag_name:        tag.name)
    end

    it "calls the registry with the right parameters if digest is blank" do
      team = create(:team)
      namespace = create(:namespace, name: "a", team: team, registry: registry)
      repo = create(:repository, name: "repo", namespace: namespace)
      tag = create(:tag, name: "t", repository: repo)

      allow_any_instance_of(Portus::RegistryClient).to(
        receive(:manifest)
          .with(repo.full_name, tag.name)
          .and_return([nil, "digest", nil])
      )
      allow_any_instance_of(Portus::RegistryClient).to(
        receive(:delete)
          .with(repo.full_name, "digest", "manifests")
          .and_return(true)
      )

      tag.delete_by_digest!(user)

      expect(Tag.find_by(name: "t")).to be_nil
    end
  end

  # NOTE: lots of cases are being left out on purpose because they are already
  # tested in the previous `describe` block.
  describe "#delete_and_update!" do
    let!(:tag) { create(:tag, name: "tag1", repository: repository, digest: "1") }

    before :each do
      tag.destroy
    end

    it "does nothing if the tag has already beed removed" do
      expect(Rails.logger).to receive(:info).with(/Removed the tag.../)
      expect(Rails.logger).to receive(:info).with(/Ignoring.../)
      tag.delete_and_update!(user)
    end
  end

  describe "#fetch_digest" do
    it "returns the digest as-is if it's not empty" do
      tag = TagMock.create(name: "tag", repository: repository, digest: "1")
      expect(tag.fetch_digest_test).to eq tag.digest
    end

    it "returns the digest as given by the registry" do
      allow_any_instance_of(Portus::RegistryClient).to receive(:manifest).and_return(
        ["id", "2", ""]
      )

      tag = TagMock.create(name: "tag", repository: repository)
      expect(tag.fetch_digest_test).to eq "2"
    end

    it "returns nil if the client could not fetch the digest" do
      allow_any_instance_of(Portus::RegistryClient).to receive(:manifest) do
        raise "I AM ERROR."
      end

      tag = TagMock.create(name: "tag", repository: repository)
      expect(tag.fetch_digest_test).to be_nil
    end
  end

  describe "#owner" do
    let!(:tag) { create(:tag, name: "tag1", user_id: user.id, repository: repository, digest: "1") }

    it "returns the proper owner" do
      expect(tag.owner).to eq user.display_username
      tag.user_id = nil
      expect(tag.owner).to eq "someone"
      tag.username = "user"
      expect(tag.owner).to eq "user"
    end
  end
end
