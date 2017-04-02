require "rails_helper"

describe TeamUserPolicy do

  subject { described_class }

  let(:admin)       { create(:admin) }
  let(:user)        { create(:user) }
  let(:owner)       { create(:user) }
  let(:viewer)      { create(:user) }
  let(:contributor) { create(:user) }
  let(:team) do
    create(:team,
           owners:       [owner],
           contributors: [contributor],
           viewers:      [viewer])
  end
  let(:team_user) { TeamUser.new(team: team) }

  permissions :owner? do

    it "denies access to a member of the team with viewer role" do
      expect(subject).to_not permit(viewer, team_user)
    end

    it "denies access to a member of the team with contributo role" do
      expect(subject).to_not permit(contributor, team_user)
    end

    it "allows access to a member of the team with owner role" do
      expect(subject).to permit(owner, team_user)
    end

    it "denies access to an owner of another group" do
      create(:team, owners: [user])
      expect(subject).to_not permit(user, team_user)
    end

    it "allows access to admin user even if he is not part of the team" do
      expect(subject).to permit(admin, team_user)
    end

  end

end
