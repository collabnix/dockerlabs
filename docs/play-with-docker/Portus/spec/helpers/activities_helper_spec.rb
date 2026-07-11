require "rails_helper"

RSpec.describe ActivitiesHelper, type: :helper do
  let(:user) { create(:user, email: "user@example.com") }
  let(:team) { create(:team) }

  describe "#activity_owner" do
    it "returns the proper activity owner" do
      activity = team.create_activity :create, owner: user

      expect(activity_owner(activity)).to eq user.display_username
      activity.owner = nil
      expect(activity_owner(activity)).to eq "Someone"
      activity.parameters = { owner_name: "user" }
      expect(activity_owner(activity)).to eq "user"
    end
  end

  describe "#activity_team" do
    it "returns the proper activity owner" do
      activity = team.create_activity :create, owner: user
      expect(activity_team(activity)).to eq team.name

      activity.parameters = activity.parameters.merge(team: "lala")
      expect(activity_team(activity)).to eq "lala"

      namespace = create(:namespace, team: team)
      activity = namespace.create_activity :create, owner: user
      expect(activity_team(activity, true)).to eq team.name
    end
  end
end
