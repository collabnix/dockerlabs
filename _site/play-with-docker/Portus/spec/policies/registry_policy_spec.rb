require "rails_helper"

describe RegistryPolicy do
  subject { described_class }

  let(:user)  { create(:user)  }
  let(:admin) { create(:admin) }

  permissions :all? do
    it "allows access to admin users" do
      expect(subject).to permit(admin, nil)
    end

    it "does not allow access to regular users" do
      expect(subject).to_not permit(user, nil)
    end
  end
end
