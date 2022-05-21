require "rails_helper"

feature "Login feature" do
  let!(:registry) { create(:registry) }
  let!(:user) { create(:user) }

  before do
    visit new_user_session_path
  end

  scenario "It does not show any flash when accessing for the first time" do
    visit root_path
    expect(page).to_not have_content("You need to sign in or sign up before continuing.")
  end

  scenario "It does show a warning for the admin creation in LDAP support" do
    User.delete_all
    APP_CONFIG["first_user_admin"] = { "enabled" => false }
    APP_CONFIG["ldap"] = { "enabled" => true }
    visit new_user_session_path

    expect(page).to_not have_content("The first user to be created will have admin permissions !")
    expect(page).to_not have_content("Create a new account")
    expect(page).to_not have_content("I forgot my password")

    APP_CONFIG["first_user_admin"] = { "enabled" => true }
    visit new_user_session_path

    expect(page).to have_content("The first user to be created will have admin permissions !")

    create(:admin)

    visit new_user_session_path
    expect(page).to_not have_content("The first user to be created will have admin permissions !")
  end

  scenario "Skips validation of minimum password length when authenticating via LDAP" do
    APP_CONFIG["ldap"] = { "enabled" => true }

    # Skipping validation for LDAP users is configured when the user model is first interpreted
    # Use a clean room to guard against side effects
    module CleanRoom
      # rubocop:disable Lint/Eval
      eval File.read(File.join(Rails.root, "app", "models", "user.rb"))
      # rubocop:enable Lint/Eval
    end

    ldap_user = CleanRoom::User.first
    ldap_user.password = "short"
    expect(ldap_user.save).to eql(true)

    fill_in "user_username", with: ldap_user.username
    fill_in "user_password", with: ldap_user.password
    click_button "Login"

    expect(page).to have_content("Recent activities")
    expect(page).to have_content("Repositories")
  end

  scenario "Existing user is able using his login and password to login into Portus" do
    expect(page).to_not have_content("Invalid username or password")

    # We don't use Capybara's `login_as` method on purpose, because we are
    # testing the UI for logging in.
    fill_in "user_username", with: user.username
    fill_in "user_password", with: user.password
    find("#login-btn").click

    expect(page).to have_content("Recent activities")
    expect(page).to have_content("Repositories")
    expect(page).to_not have_content("Signed in")
  end

  scenario "Wrong password results in an error message" do
    fill_in "user_username", with: "foo"
    fill_in "user_password", with: "bar"
    find("#login-btn").click

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content("Invalid username or password")
  end

  scenario "When guest tries to access dashboard - he is redirected to the login page" do
    visit root_path
    expect(page).to have_content("Login")
    expect(current_path).to eq root_path
  end

  scenario "Successful login when trying to access a page redirects back the guest" do
    visit namespaces_path
    expect(page).to have_content("You need to sign in or sign up before continuing.")
    fill_in "user_username", with: user.username
    fill_in "user_password", with: user.password
    find("button.classbutton").click
    expect(current_path).to eq namespaces_path
    expect(page).to have_content("Namespaces you have access to")
  end

  scenario "A disabled user cannot login" do
    user.update_attributes(enabled: false)
    fill_in "user_username", with: user.username
    fill_in "user_password", with: user.password
    find("#login-btn").click

    expect(page).to have_content(user.inactive_message)
    expect(page).to have_content("Login")
    expect(current_path).to eq new_user_session_path
  end

  scenario "Sign up is disabled" do
    APP_CONFIG["signup"] = { "enabled" => true }

    visit root_path
    expect(current_path).to eq root_path
    expect(page).to have_content("Create a new account")

    APP_CONFIG["signup"] = { "enabled" => false }

    visit root_path
    expect(current_path).to eq root_path
    expect(page).to have_content("I forgot my password")
    expect(page).to_not have_content("Create a new account")
  end

  describe "User is lockable" do
    before :each do
      @attempts  = Devise.maximum_attempts
      @unlock_in = Devise.unlock_in
    end

    after :each do
      Devise.maximum_attempts = @attempts
      Devise.unlock_in        = @unlock_in
    end

    scenario "locks the user when too many attempts have been made" do
      # Let's be fast and lock on the first attempt.
      Devise.maximum_attempts = 1

      # Lock the account.
      fill_in "user_username", with: user.username
      fill_in "user_password", with: "#{user.password}1"
      find("#new_user button").click

      expect(page).to have_content("Your account is locked.")
      user.reload
      expect(user.access_locked?).to be_truthy

      # The account is locked, regardless that we provide the proper password
      # now.
      fill_in "user_username", with: user.username
      fill_in "user_password", with: user.password
      find("#new_user button").click

      expect(page).to have_content("Your account is locked.")
      user.reload
      expect(user.access_locked?).to be_truthy

      # Unlock the account, the locking time has expired.
      Devise.unlock_in = 1.second
      sleep 1
      fill_in "user_username", with: user.username
      fill_in "user_password", with: user.password
      find("#new_user button").click
    end
  end
end
