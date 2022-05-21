require "rails_helper"

feature "Teams support" do
  let!(:registry) { create(:registry) }
  let!(:user) { create(:admin) }
  let!(:team) { create(:team, owners: [user]) }

  before do
    login_as user, scope: :user
  end

  describe "teams#index" do
    scenario "A user cannot create an empty team", js: true do
      teams_count = Team.count

      visit teams_path
      find("#add_team_btn").click
      wait_for_effect_on("#add_team_form")

      click_button "Add"
      wait_for_ajax
      wait_for_effect_on("#add_team_form")
      expect(Team.count).to eql teams_count
      expect(current_path).to eql teams_path
    end

    scenario "A team cannot be created if the name has already been picked", js: true do
      teams_count = Team.count

      visit teams_path
      find("#add_team_btn").click
      fill_in "Name", with: Team.first.name
      wait_for_effect_on("#add_team_form")

      click_button "Add"
      wait_for_ajax
      wait_for_effect_on("#float-alert")
      expect(Team.count).to eql teams_count
      expect(current_path).to eql teams_path
      expect(page).to have_content("Name has already been taken")
      expect(page).to have_css("#float-alert .alert.alert-dismissible.alert-info")
    end

    scenario "A team can be created from the index page", js: true do
      teams_count = Team.count

      visit teams_path
      find("#add_team_btn").click
      fill_in "Name", with: "valid-team"
      wait_for_effect_on("#add_team_form")

      click_button "Add"
      wait_for_ajax
      wait_for_effect_on("#add_team_form")
      expect(Team.count).to eql teams_count + 1
      expect(current_path).to eql teams_path
      expect(page).to have_content("valid-team")

      wait_for_effect_on("#float-alert")
      expect(page).to have_content("Team 'valid-team' was created successfully")
    end

    scenario 'The "Create new team" link has a toggle effect', js: true do
      visit teams_path
      expect(page).to have_css("#add_team_btn i.fa-plus-circle")
      expect(page).to_not have_css("#add_team_btn i.fa-minus-circle")

      find("#add_team_btn").click
      wait_for_effect_on("#add_team_form")

      expect(page).to_not have_css("#add_team_btn i.fa-plus-circle")
      expect(page).to have_css("#add_team_btn i.fa-minus-circle")

      find("#add_team_btn").click
      wait_for_effect_on("#add_team_form")

      expect(page).to have_css("#add_team_btn i.fa-plus-circle")
      expect(page).to_not have_css("#add_team_btn i.fa-minus-circle")
    end

    scenario "The name of each team is a link" do
      visit teams_path
      expect(page).to have_content(team.name)
      find("#teams a").click
      expect(current_path).to eq team_path(team)
    end

    scenario "Disabled users do not count" do
      user = create(:user)
      team.viewers = [user]
      team.save!
      visit teams_path

      expect(page).to have_css("td:nth-child(4)", text: "2")

      user.enabled = false
      user.save!
      visit teams_path

      expect(page).to have_css("td:nth-child(4)", text: "1")
      expect(page).to_not have_css("td:nth-child(4)", text: "2")
    end
  end

  describe "teams#update" do
    scenario "Team name can be updated", js: true do
      visit team_path(team)

      click_button "Edit team"
      expect(find("form.edit_team")).to be_visible

      new_team_name = "New #{team}"
      fill_in "team[name]", with: new_team_name
      click_button "Save"
      wait_for_ajax
      wait_for_effect_on("#float-alert")

      expect(page).to have_content("Team '#{new_team_name}' was updated successfully")
      expect(find(".team_name").text).to eq(new_team_name)
    end
  end

  describe "teams#show" do
    let!(:another) { create(:user) }
    let!(:another_admin) { create(:admin) }

    before :each do
      visit team_path(team)
    end

    scenario "A namespace can be created from the team page", js: true do
      # The form appears after clicking the "Add namespace" link.
      expect(find("#add_namespace_form", visible: false)).to_not be_visible
      find("#add_namespace_btn").click
      wait_for_effect_on("#add_namespace_form")
      expect(find("#add_namespace_form")).to be_visible
      expect(focused_element_id).to eq "namespace_namespace"

      # Fill the form and wait for the AJAX response.
      fill_in "Namespace", with: "new-namespace"
      click_button "Add"
      wait_for_ajax

      # See the response.
      namespace = Namespace.find_by(name: "new-namespace")
      expect(page).to have_css("#namespace_#{namespace.id}")
      wait_for_effect_on("#add_namespace_form")
      expect(find("#add_namespace_form", visible: false)).to_not be_visible
    end

    scenario "An user can be added as a team member", js: true do
      find("#add_team_user_btn").click
      wait_for_effect_on("#add_team_user_form")
      find("#team_user_role").select "Contributor"
      find("#team_user_user").set another.username
      find("#add_team_user_form .btn").click

      wait_for_ajax
      wait_for_effect_on("#float-alert")

      expect(page).to have_content(/User '.+' was added to the team/)
      expect(page).to have_content("Contributor")
    end

    scenario "An admin can only be added as a team owner", js: true do
      find("#add_team_user_btn").click
      wait_for_effect_on("#add_team_user_form")
      find("#team_user_role").select "Contributor"
      find("#team_user_user").set another_admin.username
      find("#add_team_user_form .btn").click

      wait_for_ajax
      wait_for_effect_on("#float-alert")

      expect(page).to have_content(
        /User '.+' was added to the team \(promoted to owner because it is a Portus admin\)\./
      )
      expect(page).to have_content("Owner")
    end

    scenario "New team members have to exist on the system", js: true do
      find("#add_team_user_btn").click
      wait_for_effect_on("#add_team_user_form")
      find("#team_user_role").select "Contributor"
      find("#team_user_user").set "grumpy"
      find("#add_team_user_form .btn").click

      wait_for_ajax
      wait_for_effect_on("#float-alert")

      expect(page).to have_content("User cannot be found")
    end

    scenario "A team member can be kicked out from a team", js: true do
      tu = TeamUser.create!(team: team, user: another, role: TeamUser.roles["viewer"])
      visit team_path(team)

      find("#team_user_#{tu.id} a.btn").click
      # I don't know how to wait for popovers, since they're created entirely
      # with JS
      sleep 0.5
      find(".popover-content .btn-primary").click

      wait_for_ajax
      wait_for_effect_on("#float-alert")

      expect(page).to have_content(/User '.+' was removed from the team/)
    end

    scenario "The only member of a team cannot be removed", js: true do
      find("#team_users a.btn").click
      # I don't know how to wait for popovers, since they're created entirely
      # with JS
      sleep 0.5
      find(".popover-content .btn-primary").click

      wait_for_ajax
      wait_for_effect_on("#float-alert")

      expect(page).to have_content("Cannot remove the only owner of the team")
    end
  end
end
