# == Schema Information
#
# Table name: team_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role       :integer          default("0")
#
# Indexes
#
#  index_team_users_on_team_id  (team_id)
#  index_team_users_on_user_id  (user_id)
#

require "rails_helper"

describe TeamUser do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:team)  { create(:team, owners: [user1, user2]) }

  it "does not return disabled team members" do
    id = team.id
    expect(team.team_users.count).to be 2
    user2.update_attributes(enabled: false)
    team = Team.find(id)
    expect(team.team_users.enabled.count).to be 1
  end

  it "creates an activity" do
    tu = team.team_users
    tu.first.create_activity!(:add_member, user1)
    tu.last.create_activity!(:add_member, user1, this: "activity")

    activities = PublicActivity::Activity.all

    a = activities.first
    expect(a.owner_id).to eq user1.id
    expect(a.key).to eq "team.add_member"
    expect(a.parameters[:role]).to eq "owner"

    a = activities.last
    expect(a.owner_id).to eq user1.id
    expect(a.key).to eq "team.add_member"
    expect(a.parameters[:this]).to eq "activity"
  end

  it "checks whether it's the only owner or not" do
    expect(team.team_users.first.only_owner?).to be_falsey
    team1 = create(:team, owners: [user1])
    expect(team1.team_users.first.only_owner?).to be_truthy
  end
end
