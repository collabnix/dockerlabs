require "rails_helper"

feature "Logout feature" do
  let!(:registry) { create(:registry) }
  let!(:user) { create(:user) }

  before do
    login user
  end

  scenario "Redirects to login screen" do
    click_link("logout")
    expect(current_url).to eq new_user_session_url
    expect(page).to_not have_content("Signed out")
  end

  scenario "After login guest redirects to login page when he attempts to access dashboard again" do
    click_link("logout")
    visit root_url
    expect(page).to have_content("Login")
    expect(current_url).to eq root_url
  end
end
