require "rails_helper"

describe WebhookPolicy do
  subject { described_class }

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
  let(:namespace) do
    create(
      :namespace,
      description: "short test description.",
      registry:    @registry,
      team:        team
    )
  end
  let(:webhook) { create(:webhook, namespace: namespace) }

  before :each do
    @admin = create(:admin)
    @registry = create(:registry)
  end

  permissions :toggle_enabled? do
    it "allows admin to change it" do
      expect(subject).to permit(@admin, webhook)
    end

    it "allows owner to change it" do
      expect(subject).to permit(owner, webhook)
    end

    it "disallows contributor to change it" do
      expect(subject).to_not permit(contributor, webhook)
    end

    it "disallows user to change it" do
      expect(subject).to_not permit(user, webhook)
    end

    it "disallows viewer to change it" do
      expect(subject).to_not permit(viewer, webhook)
    end
  end

  describe "scope" do
    before :each do
      webhook
    end

    it "shows all webhooks" do
      expected = Webhook.all
      expect(Pundit.policy_scope(@admin, Webhook).to_a).to match_array(expected)
    end

    it "shows webhooks to owner" do
      expected = webhook
      expect(Pundit.policy_scope(owner, Webhook).to_a).to match_array(expected)
    end

    it "shows webhooks to contributor" do
      expected = webhook
      expect(Pundit.policy_scope(contributor, Webhook).to_a).to match_array(expected)
    end

    it "shows webhooks to viewer" do
      expected = webhook
      expect(Pundit.policy_scope(viewer, Webhook).to_a).to match_array(expected)
    end

    it "does show webhooks to user when appropiate" do
      expect(Pundit.policy_scope(user, Webhook).to_a).to be_empty
      create(:webhook, namespace: user.namespace)
      expect(Pundit.policy_scope(user, Webhook).to_a).to_not be_empty
    end
  end
end
