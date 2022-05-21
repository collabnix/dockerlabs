require "rails_helper"

RSpec.describe NamespacesHelper, type: :helper do
  let(:registry)    { create(:registry) }
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
  let(:namespace) { create(:namespace, team: team) }

  describe "can_manage_namespace?" do
    it "returns true if current user is an owner of the namespace" do
      sign_in owner
      expect(helper.can_manage_namespace?(namespace)).to be true
    end

    it "returns false if current user is a viewer of the namespace" do
      sign_in viewer
      expect(helper.can_manage_namespace?(namespace)).to be false
    end

    it "returns false if current user is a contributor of the namespace" do
      sign_in contributor
      expect(helper.can_manage_namespace?(namespace)).to be false
    end

    it "returns true if current user is an admin even when he is not related with the namespace" do
      sign_in admin
      expect(helper.can_manage_namespace?(namespace)).to be true
    end
  end
end
