require "rails_helper"

feature "Namespaces support" do
  let!(:registry) { create(:registry) }
  let!(:user) { create(:admin) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:team) { create(:team, owners: [user], contributors: [user2], viewers: [user3]) }
  let!(:namespace) { create(:namespace, team: team, registry: registry) }

  before do
    login_as user, scope: :user
  end

  describe "Namespaces#index" do
    scenario "An user cannot create an empty namespace", js: true do
      namespaces_count = Namespace.count

      visit namespaces_path
      find("#add_namespace_btn").click
      wait_for_effect_on("#add_namespace_form")

      click_button "Create"
      wait_for_ajax
      wait_for_effect_on("#add_namespace_form")
      expect(Namespace.count).to eql namespaces_count
      expect(current_path).to eql namespaces_path
    end

    scenario "An user cannot create a namespace that already exists", js: true do
      namespaces_count = Namespace.count

      visit namespaces_path
      find("#add_namespace_btn").click
      fill_in "Namespace", with: Namespace.first.name
      fill_in "Team", with: Team.where(hidden: false).first.name
      wait_for_effect_on("#add_namespace_form")

      click_button "Create"
      wait_for_ajax
      wait_for_effect_on("#float-alert")
      expect(Namespace.count).to eql namespaces_count
      expect(current_path).to eql namespaces_path
      expect(page).to have_content("Name has already been taken")
      expect(page).to have_css("#float-alert .alert.alert-dismissible.alert-info.float-alert")
    end

    scenario "An user cannot create a namespace for a hidden team", js: true do
      namespaces_count = Namespace.count

      visit namespaces_path
      find("#add_namespace_btn").click
      fill_in "Namespace", with: Namespace.first.name
      fill_in "Team", with: Team.where(hidden: true).first.name
      wait_for_effect_on("#add_namespace_form")

      click_button "Create"
      wait_for_ajax
      wait_for_effect_on("#float-alert")
      expect(Namespace.count).to eql namespaces_count
      expect(current_path).to eql namespaces_path
      expect(page).to have_content("Selected team does not exist")
      expect(page).to have_css("#float-alert .alert.alert-dismissible.alert-info")
    end

    scenario "A namespace can be created from the index page", js: true do
      namespaces_count = Namespace.count

      visit namespaces_path
      find("#add_namespace_btn").click
      fill_in "Namespace", with: "valid-namespace"
      fill_in "Team", with: namespace.team.name
      wait_for_effect_on("#add_namespace_form")

      click_button "Create"
      wait_for_ajax
      wait_for_effect_on("#add_namespace_form")

      expect(Namespace.count).to eql namespaces_count + 1
      expect(current_path).to eql namespaces_path
      expect(page).to have_content("valid-namespace")

      wait_for_effect_on("#float-alert")
      expect(page).to have_content(/Namespace '.+' was created successfully/)

      # Check that it created a link to it and that it's accessible.
      click_link "valid-namespace"
      namespace = Namespace.find_by(name: "valid-namespace")
      wait_until { current_path == namespace_path(namespace) }
      expect(current_path).to eq namespace_path(namespace)
    end

    scenario 'The "Create new namespace" link has a toggle effect', js: true do
      visit namespaces_path
      expect(page).to have_css("#add_namespace_btn i.fa-plus-circle")
      expect(page).to_not have_css("#add_namespace_btn i.fa-minus-circle")

      find("#add_namespace_btn").click
      wait_for_effect_on("#add_namespace_form")

      expect(page).to_not have_css("#add_namespace_btn i.fa-plus-circle")
      expect(page).to have_css("#add_namespace_btn i.fa-minus-circle")

      find("#add_namespace_btn").click
      wait_for_effect_on("#add_namespace_form")

      expect(page).to have_css("#add_namespace_btn i.fa-plus-circle")
      expect(page).to_not have_css("#add_namespace_btn i.fa-minus-circle")
    end

    scenario 'The "Create new namespace" keeps icon after add new namespace', js: true do
      visit namespaces_path
      expect(page).to have_css("#add_namespace_btn i.fa-plus-circle")
      expect(page).to_not have_css("#add_namespace_btn i.fa-minus-circle")

      find("#add_namespace_btn").click
      fill_in "Namespace", with: "valid-namespace"
      fill_in "Team", with: namespace.team.name
      wait_for_effect_on("#add_namespace_form")

      expect(page).to_not have_css("#add_namespace_btn i.fa-plus-circle")
      expect(page).to have_css("#add_namespace_btn i.fa-minus-circle")

      click_button "Create"
      wait_for_ajax
      wait_for_effect_on("#add_namespace_form")

      expect(page).to have_css("#add_namespace_btn i.fa-plus-circle")
      expect(page).to_not have_css("#add_namespace_btn i.fa-minus-circle")
    end

    scenario "The namespace visibility can be changed", js: true do
      visit namespaces_path
      id = namespace.id

      expect(namespace.visibility_private?).to be true
      expect(page).to have_css("#namespace_#{id} a#private.btn-primary")

      find("#namespace_#{id} a#protected.btn").click
      wait_for_ajax

      expect(page).to have_css("#namespace_#{id} a#protected.btn-primary")
      namespace = Namespace.find(id)
      expect(namespace.visibility_protected?).to be true

      find("#namespace_#{id} a#public.btn").click
      wait_for_ajax

      expect(page).to have_css("#namespace_#{id} a#public.btn-primary")
      namespace = Namespace.find(id)
      expect(namespace.visibility_public?).to be true
    end
  end

  describe "#update" do
    it "returns an error when trying to update the team to a non-existing one", js: true do
      visit namespace_path(namespace.id)
      find("#edit_namespace").click
      wait_for_ajax

      fill_in "Team", with: "unknown"
      find("#change_description_namespace_#{namespace.id} .btn").click

      wait_for_ajax
      wait_for_effect_on("#float-alert")
      expect(page).to have_content("Team 'unknown' unknown")
    end
  end

  describe "#show" do
    it "shows the proper visual aid for each role", js: true do
      visit namespace_path(namespace.id)
      expect(page).to have_content("Push Pull Owner")

      login_as user2, scope: :user
      visit namespace_path(namespace.id)
      expect(page).to have_content("Push Pull Contr.")

      login_as user3, scope: :user
      visit namespace_path(namespace.id)
      expect(page).to have_content("Pull Viewer")
    end
  end
end
