require "rails_helper"
require "pp"

feature "Admin - Dashboard" do
  let!(:registry) { create(:registry) }
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }

  before do
    login_as admin
    visit admin_dashboard_index_path
  end

  scenario "The dashboard does not count the Portus user" do
    create_portus_user!
    visit admin_dashboard_index_path

    # 3 users: admin, user and the one created by the registry.
    expect(find(".users span").text).to eq "3"
  end

  scenario "Warn the admin that the portus user does not exist" do
    expect(page).to have_content("The Portus user does not exist!")

    create_portus_user!
    visit admin_dashboard_index_path

    expect(page).to_not have_content("The Portus user does not exist!")
  end
end
