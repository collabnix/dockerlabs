require "rails_helper"

feature "Admin - Registries panel" do
  let!(:admin) { create(:admin) }

  before do
    login_as admin
  end

  describe "#force_registry_config!" do
    it "redirects to new_admin_registry_path if no registry has been configured" do
      visit authenticated_root_path
      expect(current_path).to eq new_admin_registry_path
    end
  end

  describe "create" do
    it "shows an alert on error, and you can force it afterwards" do
      visit new_admin_registry_path
      expect(page).to_not have_content("Skip remote checks")
      fill_in "registry_name", with: "registry"
      fill_in "registry_hostname", with: "url_not_known:1234"
      click_button "Create"

      expect(page).to have_content("Skip remote checks")
      expect(page).to have_content("something went wrong")
      expect(Registry.any?).to be_falsey

      # Use the force, Luke.

      fill_in "registry_name", with: "registry"
      fill_in "registry_hostname", with: "url_not_known:1234"
      check "force"
      click_button "Create"

      expect(current_path).to eq admin_registries_path
      expect(page).to have_content("Registry was successfully created.")
      expect(Registry.any?).to be_truthy
    end
  end

  describe "update" do
    let!(:registry) { create(:registry) }

    before :each do
      visit edit_admin_registry_path(registry.id)
    end

    it "does not show the hostname if there are repositories" do
      expect(page).to have_css("#registry_hostname")

      create(:repository)
      visit edit_admin_registry_path(registry.id)

      expect(page).to_not have_css("#registry_hostname")
    end

    it "updates as expected" do
      fill_in "registry_hostname", with: "lala"
      click_button "Update"

      expect(page).to have_content("Registry updated successfully!")
      expect(current_path).to eq admin_registries_path
      registry.reload
      expect(registry.hostname).to eq "lala"
    end
  end
end
