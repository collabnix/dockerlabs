require "rails_helper"

feature "Global application" do
  let!(:registry) { create(:registry) }
  let!(:user)     { create(:admin) }

  describe "#force_update_profile!" do
    it "does nothing for accounts with a proper email" do
      login_as user, scope: :user
      visit root_path
      expect(current_path).to eq root_path
    end

    it "redirects properly for accounts without email" do
      APP_CONFIG["ldap"] = { "enabled" => true }
      incomplete = create(:user, email: "")
      login_as incomplete, scope: :user

      visit root_path
      expect(current_path).to eq edit_user_registration_path

      expect(page).to have_content("Your profile is not complete.")
      find("#logout").click
      expect(current_path).to eq new_user_session_path
    end
  end
end
