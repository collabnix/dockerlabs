require "rails_helper"

feature "Repositories support" do
  let!(:registry) { create(:registry) }
  let!(:user) { create(:admin) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:team) { create(:team, owners: [user], contributors: [user2], viewers: [user3]) }
  let!(:namespace) { create(:namespace, team: team) }
  let!(:repository) { create(:repository, namespace: namespace) }
  let!(:starred_repo) { create(:repository, namespace: namespace) }
  let!(:star) { create(:star, user: user, repository: starred_repo) }

  before do
    login_as user, scope: :user
  end

  describe "repository#show" do
    scenario "Visual aid for each role is shown properly" do
      visit repository_path(repository)
      expect(page).to have_content("Push Pull Owner")

      login_as user2, scope: :user
      visit repository_path(repository)
      expect(page).to have_content("Push Pull Contr.")

      login_as user3, scope: :user
      visit repository_path(repository)
      expect(page).to have_content("Pull Viewer")
    end

    scenario "The delete feature is available only for allowed users" do
      APP_CONFIG["delete"] = { "enabled" => true }

      visit repository_path(repository)
      expect(page).to have_content("Delete image")

      login_as user2, scope: :user
      visit repository_path(repository)
      expect(page).to_not have_content("Delete image")
    end

    scenario "A user can star a repository", js: true do
      visit repository_path(repository)
      expect(find("#toggle_star")).to be_visible
      find("#toggle_star").click
      wait_for_ajax
      expect(current_path).to eq repository_path(repository)

      # See the response.
      repo = Repository.find(repository.id)
      expect(find("#star-counter")).to have_content("1")
      expect(repo.stars.count).to be 1
    end

    scenario "A user can unstar a repository", js: true do
      visit repository_path(starred_repo)
      expect(find("#toggle_star")).to be_visible
      find("#toggle_star").click
      wait_for_ajax
      expect(current_path).to eq repository_path(starred_repo)

      # See the response.
      repo = Repository.find(repository.id)
      expect(find("#star-counter")).to have_content("0")
      expect(repo.stars.count).to be 0
    end

    scenario "Groupped tags are handled properly" do
      ["", "", "same", "same", "another", "yet-another"].each_with_index do |digest, idx|
        create(:tag, name: "tag#{idx}", author: user, repository: repository, digest: digest,
               image_id: "Image", created_at: idx.hours.ago)
      end

      expectations = [["tag0"], ["tag1"], ["tag2", "tag3"], ["tag4"], ["tag5"]]

      visit repository_path(repository)

      page.all(".tags tr").each_with_index do |row, idx|
        expect(row.text.include?("Image")).to be_truthy

        # Skip the header.
        next if idx == 0

        expectations[idx - 1].each { |tag| expect(row.text.include?(tag)).to be_truthy }
      end
    end

    scenario "it works if both the digest and the image_id are blank" do
      create(:tag, author: user, repository: repository, digest: nil, image_id: nil)
      create(:tag, author: user, repository: repository, digest: "nonblank", image_id: nil)

      visit repository_path(repository)
    end
  end
end
