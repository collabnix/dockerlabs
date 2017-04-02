# == Schema Information
#
# Table name: webhook_deliveries
#
#  id              :integer          not null, primary key
#  webhook_id      :integer
#  uuid            :string(255)
#  status          :integer
#  request_header  :text(65535)
#  request_body    :text(65535)
#  response_header :text(65535)
#  response_body   :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_webhook_deliveries_on_webhook_id           (webhook_id)
#  index_webhook_deliveries_on_webhook_id_and_uuid  (webhook_id,uuid) UNIQUE
#

require "rails_helper"

RSpec.describe WebhookDelivery, type: :model do
  subject { create(:webhook_delivery, webhook: create(:webhook)) }

  it { should belong_to(:webhook) }
  it { should validate_uniqueness_of(:uuid).scoped_to(:webhook_id) }

  describe "success?" do
    let!(:registry)    { create(:registry) }
    let!(:owner)       { create(:user) }
    let!(:team)        { create(:team, owners: [owner]) }
    let!(:namespace)   { create(:namespace, team: team) }
    let!(:webhook)     { create(:webhook, namespace: namespace) }
    let!(:webhook_delivery) { create(:webhook_delivery, webhook: webhook) }

    it "returns true for HTTP code 200" do
      webhook_delivery.status = 200
      expect(webhook_delivery.success?).to be true
    end

    it "returns false for HTTP codes other than 200" do
      webhook_delivery.status = 418
      expect(webhook_delivery.success?).to be false
    end
  end

  describe "retrigger" do
    let!(:registry)    { create(:registry) }
    let!(:owner)       { create(:user) }
    let!(:team)        { create(:team, owners: [owner]) }
    let!(:namespace)   { create(:namespace, team: team) }
    let!(:webhook_noauth) { create(:webhook, namespace: namespace) }
    let!(:webhook_auth) do
      create(:webhook, namespace: namespace, username: "username", password: "password")
    end
    let!(:webhook_header) do
      create(:webhook_header, webhook: webhook_noauth, name: "foo", value: "bar")
    end

    before :each do
      stub_request(:POST, "username:password@www.example.com")
        .to_return(
          status:  200,
          body:    %({"hello": "world"}),
          headers: { "lorem" => "ipsum" }
        )
      stub_request(:POST, "www.example.com").to_return(
        status:  200,
        body:    %({"hello": "world"}),
        headers: { "Lorem" => "ipsum" }
      )
    end

    it "should resend HTTP requests" do
      create :webhook_delivery, webhook: webhook_auth
      create :webhook_delivery, webhook: webhook_noauth
      WebhookDelivery.find_each do |delivery|
        delivery.retrigger
        expect(delivery.status).to eq 200
        expect(delivery.response_body).to eq %({"hello": "world"})
        expect(delivery.response_header).to eq "Lorem: ipsum"
      end
    end
  end
end
