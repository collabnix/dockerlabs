require "rails_helper"

feature "Admin - Users panel" do
  let!(:registry) { create(:registry) }
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }

  before do
    login_as admin
    visit admin_users_path
  end

  describe "remove users" do
    scenario "allows the admin to remove other users", js: true do
      original = user.username
      expect(page).to have_css("#user_#{user.id}")
      expect(page).to have_content(original)

      find("#user_#{user.id} .remove-btn").click
      wait_for_effect_on("#user_#{user.id}")
      find("#user_#{user.id} .btn-confirm-remove").click

      wait_for_effect_on("#float-alert")
      expect { User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(page).to have_content("User '#{user.username}' was removed successfully")
      expect(page).to_not have_content(original)
    end

    scenario "allows the admin to remove other users from the show page", js: true do
      visit edit_admin_user_path(user.id)

      original = user.username
      expect(page).to have_content(original)

      find(".btn-danger").click
      expect(current_path).to eq admin_users_path

      wait_for_effect_on("#float-alert")
      expect { User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(page).to have_content("User '#{user.username}' was removed successfully")
      expect(page).to_not have_content(original)
    end
  end

  describe "disable users" do
    scenario "allows the admin to disable other users", js: true do
      expect(page).to have_css("#user_#{user.id}")
      find("#user_#{user.id} .enabled-btn").click

      wait_for_effect_on("#user_#{user.id}")

      expect(page).to have_css("#user_#{user.id} .fa-toggle-off")
      wait_for_effect_on("#float-alert")
      expect(page).to have_content("User '#{user.username}' has been disabled.")
    end

    scenario "allows the admin to enable back a user", js: true do
      user.update_attributes(enabled: false)
      visit admin_users_path

      expect(page).to have_css("#user_#{user.id}")
      find("#user_#{user.id} .enabled-btn").click

      wait_for_effect_on("#user_#{user.id}")

      expect(page).to have_css("#user_#{user.id} .fa-toggle-on")
      wait_for_effect_on("#float-alert")
      expect(page).to have_content("User '#{user.username}' has been enabled.")
    end
  end

  describe "toggle admin" do
    scenario "allows the admin to toggle a regular user into becoming an admin", js: true do
      expect(page).to have_css("#user_#{user.id}")
      expect(page).to have_css("#user_#{user.id} .admin-btn .fa-toggle-off")
      find("#user_#{user.id} .admin-btn").click

      wait_for_effect_on("#float-alert")

      expect(page).to_not have_css("#user_#{user.id} .admin-btn .fa-toggle-off")
      expect(page).to have_css("#user_#{user.id} .admin-btn .fa-toggle-on")
      expect(page).to have_content("User '#{user.username}' is now an admin")
    end

    scenario "allows the admin to remove another admin", js: true do
      user.update_attributes(admin: true)
      visit admin_users_path

      expect(page).to have_css("#user_#{user.id}")
      expect(page).to have_css("#user_#{user.id} .admin-btn .fa-toggle-on")
      find("#user_#{user.id} .admin-btn").click

      wait_for_effect_on("#float-alert")

      expect(page).to_not have_css("#user_#{user.id} .admin-btn .fa-toggle-on")
      expect(page).to have_css("#user_#{user.id} .admin-btn .fa-toggle-off")
      expect(page).to have_content("User '#{user.username}' is no longer an admin")
    end
  end

  describe "Edit user" do
    scenario "allows the admin to update a user", js: true do
      visit edit_admin_user_path(user)

      fill_in "Email", with: "another@example.com"
      click_button "Update"

      wait_for_effect_on("#float-alert")
      expect(page).to have_content("another@example.com")
      expect(page).to have_content("User '#{user.username}' was updated successfully")
    end

    scenario "disallows the admin to update a user with a wrong name", js: true do
      visit edit_admin_user_path(user)

      fill_in "Email", with: admin.email
      click_button "Update"

      wait_for_effect_on("#float-alert")
      expect(page).to have_content("has already been taken")
    end
  end
end
