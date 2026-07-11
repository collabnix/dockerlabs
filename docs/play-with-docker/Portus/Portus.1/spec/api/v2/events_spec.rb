require "rails_helper"

describe "/v2/token" do
  describe "create" do
    let(:data) { { "events" => [] } }

    it "handles the notification and accepts it" do
      expect(Portus::RegistryNotification).to receive(:process!)
      post v2_webhooks_events_url, data.to_json, format: :json
      expect(response).to be_success
    end
  end
end
