require "rails_helper"

feature "Update password feature" do
  let!(:user) { create(:admin) }

  before do
    login_as user, scope: :user
    visit edit_user_registration_path
  end

  # Changing the email

  scenario "It enables the button if the user pressed a key", js: true do
    # Change the contents and see that it gets enabled.
    expect(disabled?("#edit_user .btn")).to be true
    fill_in "Email", with: "another@example.com"
    expect(disabled?("#edit_user .btn")).to be false

    # Click the button, the contents should be updated.
    click_button("Update")
    expect(current_path).to eq edit_user_registration_path
    expect(disabled?("#edit_user .btn")).to be true
    expect(find("#user_email").value).to eq "another@example.com"
  end

  scenario "It disables the button if the input becomes empty", js: true do
    expect(disabled?("#edit_user .btn")).to be true
    fill_in "Email", with: ""
    expect(disabled?("#edit_user .btn")).to be true
  end

  # Changing the password

  scenario "It enables/disables the submit button properly", js: true do
    # By default it's disabled.
    expect(disabled?("#edit_user.password .btn")).to be true

    # Now we fill the current and the new password.
    fill_in "user_current_password", with: user.password
    fill_in "user_password", with: "12341234"
    expect(disabled?("#edit_user.password .btn")).to be true

    # We write the confirmation but it differs from the one we just wrote.
    fill_in "user_password_confirmation", with: "1234"
    expect(disabled?("#edit_user.password .btn")).to be true

    # Now we write the proper copnfirmation
    fill_in "user_password_confirmation", with: "12341234"
    expect(disabled?("#edit_user.password .btn")).to be false

    # Click the button and see that everything is as expected.
    click_button "Change"
    expect(current_path).to eq edit_user_registration_path
    expect(User.first.valid_password?("12341234")).to be true
  end

  # Disabling user

  scenario "It disables the current user", js: true do
    create(:admin)
    visit edit_user_registration_path

    click_button "Disable"
    wait_until { current_path == root_path }
    expect(current_path).to eq root_path
    expect(page).to have_content("Login")
  end

  scenario 'The "disable" pannel does not exists if it\'s the only admin' do
    expect(page).to_not have_css("#disable-form")
  end
end
