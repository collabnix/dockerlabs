require "rails_helper"

RSpec.describe TeamsHelper, type: :helper do

  let(:admin)       { create(:admin) }
  let(:owner)       { create(:user) }
  let(:viewer)      { create(:user) }
  let(:contributor) { create(:user) }
  let(:team) do
    create(:team,
           owners:       [owner],
           contributors: [contributor],
           viewers:      [viewer])
  end

  describe "can_manage_team?" do
    it "returns true if current user is an owner of the team" do
      sign_in owner
      expect(helper.can_manage_team?(team)).to be true
    end

    it "returns false if current user is a viewer of the team" do
      sign_in viewer
      expect(helper.can_manage_team?(team)).to be false
    end

    it "returns false if current user is a contributor of the team" do
      sign_in contributor
      expect(helper.can_manage_team?(team)).to be false
    end

    it "returns false if current user is an admin even if he is not related with the team" do
      sign_in admin
      expect(helper.can_manage_team?(team)).to be true
    end
  end

  describe "role within team" do
    it "returns the role of the current user inside of the team" do
      sign_in viewer
      expect(helper.role_within_team(team)).to eq "Viewer"
    end

    it "returns - for users that are not part of the team" do
      sign_in create(:admin)
      expect(helper.role_within_team(team)).to eq "-"
    end
  end

  describe "team_scope_icon" do
    it "renders with the proper icon for a team with one member" do
      personal_team = create(:team, owners: [owner])
      expect(helper.team_scope_icon(personal_team)).to eq(
        '<i class="fa fa-user fa-lg" title="Personal"></i>'
      )
    end

    it "renders with the proper icon for a team with multiple members" do
      expect(helper.team_scope_icon(team)).to eq(
        '<i class="fa fa-users fa-lg" title="Team"></i>'
      )
    end

    it "renders with the proper icon when a team member has been disabled" do
      guy = create(:user, enabled: false)
      uni_team = create(:team, owners: [owner], viewers: [guy])
      expect(helper.team_scope_icon(uni_team)).to eq(
        '<i class="fa fa-user fa-lg" title="Personal"></i>'
      )
    end
  end

  describe "team_user_role_icon" do
    before(:each) do
      team
    end

    it "renders with the proper icon for owner" do
      expect(helper.team_user_role_icon(owner.team_users.first)).to eq(
        '<i class="fa fa-male fa-lg" title="Owner"></i>'
      )
    end

    it "renders with the proper icon for contributor" do
      expect(helper.team_user_role_icon(contributor.team_users.first)).to eq(
        '<i class="fa fa-exchange fa-lg" title="Contributor"></i>'
      )
    end

    it "renders with the proper icon for viewer" do
      expect(helper.team_user_role_icon(viewer.team_users.first)).to eq(
        '<i class="fa fa-eye fa-lg" title="Viewer"></i>'
      )
    end
  end

  describe "role_icon_class" do
    before(:each) do
      team
    end

    it "returns the proper icon class for owner" do
      expect(helper.role_icon_class(owner.team_users.first.role)).to eq(
        "fa-male"
      )
    end

    it "returns the proper icon class for contributor" do
      expect(helper.role_icon_class(contributor.team_users.first.role)).to eq(
        "fa-exchange"
      )
    end

    it "returns the proper icon class for viewer" do
      expect(helper.role_icon_class(viewer.team_users.first.role)).to eq(
        "fa-eye"
      )
    end
  end
end
