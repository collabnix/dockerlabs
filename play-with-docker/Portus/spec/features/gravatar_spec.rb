require "rails_helper"

feature "Gravatar support" do
  let!(:registry) { create(:registry) }
  let!(:user) { create(:user) }

  before do
    login user
  end

  scenario "If gravatar support is on, there should be an image" do
    APP_CONFIG["gravatar"] = { "enabled" => true }
    visit root_url
    expect(page).to have_selector(".user-header img")
  end

  scenario "If gravatar suppor is disabled, there should be an icon" do
    APP_CONFIG["gravatar"] = { "enabled" => false }
    visit root_url
    expect(page).to have_selector(".user-header .user-picture")
  end
end
