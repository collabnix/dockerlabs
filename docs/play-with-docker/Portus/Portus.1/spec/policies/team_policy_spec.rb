require "spec_helper"

describe TeamPolicy do

  subject { described_class }

  let(:member) { create(:user) }
  let(:team) { create(:team, owners: [member]) }

  before :each do
    @admin = create(:admin)
    create(:registry)
  end

  permissions :member? do

    it "denies access to a user who is not part of the team" do
      expect(subject).to_not permit(create(:user), team)
    end

    it "allows access to a member of the team" do
      expect(subject).to permit(member, team)
    end

    it "allows access to an admin even if he is not part of the team" do
      expect(subject).to permit(@admin, team)
    end

  end

  describe "scope" do
    it "returns only teams having the user as a memeber" do
      # Another team not related with 'owner'
      create(:team, owners: [create(:user)])

      expected_list = [team]
      expect(Pundit.policy_scope(member, Team).to_a).to match_array(expected_list)
    end

    it "never shows the team associated with personal repository" do
      user = create(:user)
      expect(user.teams).not_to be_empty
      expect(Pundit.policy_scope(user, Team).to_a).to be_empty
    end
  end

end
