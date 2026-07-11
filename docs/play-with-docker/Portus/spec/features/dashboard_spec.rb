require "rails_helper"

feature "Dashboard page" do
  let!(:registry) { create(:registry) }
  let!(:user) { create(:admin, display_name: "docker-gangsta") }
  let!(:team) { create(:team, owners: [user]) }
  let!(:namespace) { create(:namespace, team: team) }
  let!(:repository) { create(:repository, namespace: namespace) }
  let!(:starred_repo) { create(:repository, namespace: namespace) }
  let!(:star) { create(:star, user: user, repository: starred_repo) }
  let!(:personal_namespace) { user.namespace }
  let!(:personal_repository) { create(:repository, namespace: personal_namespace) }

  let!(:another_user) { create(:admin) }
  let!(:another_team) { create(:team, owners: [another_user]) }
  let!(:another_team2) { create(:team, owners: [another_user]) }
  let!(:public_namespace) do
    create(:namespace,
           team:       another_team,
           visibility: Namespace.visibilities[:visibility_public])
  end
  let!(:public_repository) { create(:repository, namespace: public_namespace) }
  let!(:protected_namespace) do
    create(:namespace,
           team:       another_team2,
           visibility: Namespace.visibilities[:visibility_protected])
  end
  let!(:protected_repository) { create(:repository, namespace: protected_namespace) }

  before do
    login_as user, scope: :user
  end

  describe "Repositories sidebar" do
    scenario "Show all the repositories user has access to" do
      visit authenticated_root_path
      expect(page).to have_content("#{personal_namespace.name}/#{personal_repository.name}")
      expect(page).to have_content("#{namespace.name}/#{repository.name}")
      expect(page).to have_content("#{namespace.name}/#{starred_repo.name}")
      expect(page).to have_content("#{public_namespace.name}/#{public_repository.name}")
      expect(page).to have_content("#{protected_namespace.name}/#{protected_repository.name}")
    end

    scenario "Show personal repositories", js: true do
      visit authenticated_root_path
      click_link("Personal")
      wait_for_effect_on(".tab-content")

      expect(page).to have_content("#{personal_namespace.name}/#{personal_repository.name}")
      expect(page).not_to have_content("#{namespace.name}/#{starred_repo.name}")
      expect(page).not_to have_content("#{namespace.name}/#{repository.name}")
      expect(page).not_to have_content("#{public_namespace.name}/#{public_repository.name}")
      expect(page).not_to have_content("#{protected_namespace.name}/#{protected_repository.name}")
    end

    scenario "Show personal repositories", js: true do
      visit authenticated_root_path
      click_link("Starred")
      wait_for_effect_on(".tab-content")

      expect(page).to have_content("#{namespace.name}/#{starred_repo.name}")
      expect(page).not_to have_content("#{personal_namespace.name}/#{personal_repository.name}")
      expect(page).not_to have_content("#{namespace.name}/#{repository.name}")
      expect(page).not_to have_content("#{public_namespace.name}/#{public_repository.name}")
      expect(page).not_to have_content("#{protected_namespace.name}/#{protected_repository.name}")
    end
  end

  describe "Display name" do
    scenario "Shows the display name of the user when needed" do
      visit authenticated_root_path
      expect(page).not_to have_content("docker-gangsta")
      APP_CONFIG["display_name"] = { "enabled" => true }
      visit authenticated_root_path
      expect(page).to have_content("docker-gangsta")
    end
  end
end
