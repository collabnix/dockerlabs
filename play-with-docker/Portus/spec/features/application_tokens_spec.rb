require "rails_helper"

feature "Application tokens" do
  let!(:user) { create(:user) }

  before do
    login_as user, scope: :user
  end

  describe "ApplicationTokens#create" do
    scenario "As an user I can create a new token", js: true do
      expect(user.application_tokens).to be_empty

      visit edit_user_registration_path
      find("#add_application_token_btn").click
      wait_for_effect_on("#add_application_token_form")

      expect(focused_element_id).to eq "application_token_application"
      fill_in "Application", with: "awesome-application"

      click_button "Create"
      wait_for_ajax
      wait_for_effect_on("#add_application_token_form")

      expect(user.application_tokens.count).to be(1)
      expect(current_path).to eql edit_user_registration_path

      wait_for_effect_on("#float-alert")
      expect(page).to have_content("was created successfully")
      expect(page).to have_content("awesome-application")
    end

    scenario "As an user I cannot create two tokens with the same name", js: true do
      create(:application_token, application: "awesome-application", user: user)

      visit edit_user_registration_path
      find("#add_application_token_btn").click
      wait_for_effect_on("#add_application_token_form")

      expect(focused_element_id).to eq "application_token_application"
      fill_in "Application", with: "awesome-application"

      click_button "Create"
      wait_for_ajax
      wait_for_effect_on("#add_application_token_form")

      expect(user.application_tokens.count).to be(1)
      expect(current_path).to eql edit_user_registration_path

      wait_for_effect_on("#float-alert")
      expect(page).to have_content("Application has already been taken")
    end

    scenario "As an user the create new token link is disabled when I reach the limit", js: true do
      (User::APPLICATION_TOKENS_MAX - 1).times do
        create(:application_token, user: user)
      end

      visit edit_user_registration_path
      find("#add_application_token_btn").click
      wait_for_effect_on("#add_application_token_form")

      expect(focused_element_id).to eq "application_token_application"
      fill_in "Application", with: "awesome-application"

      click_button "Create"
      wait_for_ajax
      wait_for_effect_on("#add_application_token_form")

      expect(current_path).to eql edit_user_registration_path

      wait_for_effect_on("#float-alert")
      expect(page).to have_content("was created successfully")
      expect(page).to have_content("awesome-application")
      expect(disabled?("#add_application_token_btn")).to be true
    end

    scenario "As an user I cannot create tokens once I reach my limit", js: true do
      User::APPLICATION_TOKENS_MAX.times do
        create(:application_token, user: user)
      end

      visit edit_user_registration_path
      expect(disabled?("#add_application_token_btn")).to be true
    end
  end

  describe "ApplicationTokens#destroy" do
    scenario "As an user I can revoke a token", js: true do
      token = create(:application_token, user: user)

      visit edit_user_registration_path

      find("#application_token_#{token.id} a.btn").click
      # I don't know how to wait for popovers, since they're created entirely
      # with JS
      sleep 0.5
      find(".popover-content .btn-primary").click

      wait_for_ajax
      wait_for_effect_on("#float-alert")

      expect(page).to have_content("was removed successfully")
    end
  end

  describe "Toggle effect on form" do
    scenario "The toggle effect works on the Create new token link", js: true do
      visit edit_user_registration_path

      expect(page).to have_css("#add_application_token_btn i.fa-plus-circle")
      find("#add_application_token_btn").click
      wait_for_effect_on("#add_application_token_form")
      expect(page).to have_css("#add_application_token_btn i.fa-minus-circle")
      find("#add_application_token_btn").click
      wait_for_effect_on("#add_application_token_form")
      expect(page).to have_css("#add_application_token_btn i.fa-plus-circle")
    end
  end
end
