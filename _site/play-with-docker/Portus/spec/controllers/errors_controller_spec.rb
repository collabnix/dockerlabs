require "rails_helper"

describe ErrorsController do
  describe "the fixes params is set" do
    context "development" do
      before :all do
        secrets = Rails.application.secrets
        @secret_key_base = secrets.secret_key_base
        @secret_machine_fqdn = APP_CONFIG["machine_fqdn"]["value"]
        @secret_encryption_private_key_path = secrets.encryption_private_key_path
        @secret_portus_password = secrets.portus_password
      end

      before :each do
        secrets = Rails.application.secrets
        secrets.secret_key_base = @secret_key_base
        secrets.machine_fqdn = @secret_machine_fqdn
        secrets.encryption_private_key_path = @secret_encryption_private_key_path
        secrets.portus_password = @secret_portus_password
      end

      after :all do
        secrets = Rails.application.secrets
        secrets.secret_key_base = @secret_key_base
        secrets.machine_fqdn = @secret_machine_fqdn
        secrets.encryption_private_key_path = @secret_encryption_private_key_path
        secrets.portus_password = @secret_portus_password
      end

      it "sets @fix[:secret_key_base] as true" do
        Rails.application.secrets.secret_key_base = ""
        get :show, id: 1, fixes: true
        expect(assigns(:fix)[:secret_key_base]).to be true
      end

      it "sets @fix[:secret_machine_fqdn] as true" do
        APP_CONFIG["machine_fqdn"] = { "value" => "" }
        get :show, id: 1, fixes: true
        expect(assigns(:fix)[:secret_machine_fqdn]).to be true
      end

      it "sets @fix[:secret_encryption_private_key_path] as true" do
        Rails.application.secrets.encryption_private_key_path = nil
        get :show, id: 1, fixes: true
        expect(assigns(:fix)[:secret_encryption_private_key_path]).to be true
      end

      it "sets @fix[:secret_portus_password] as true" do
        Rails.application.secrets.portus_password = nil
        get :show, id: 1, fixes: true
        expect(assigns(:fix)[:secret_portus_password]).to be true
      end
    end

    context "production" do
      after :all do
        Rails.env = ActiveSupport::StringInquirer.new("test")
      end

      before :each do
        Rails.env = ActiveSupport::StringInquirer.new("production")
      end

      it "sets @fix[:ssl] as true when check_ssl_usage is enabled" do
        APP_CONFIG["check_ssl_usage"] = { "enabled" => true }
        get :show, id: 1, fixes: true
        expect(assigns(:fix)[:ssl]).to be true
      end

      it "sets @fix[:ssl] as false when check_ssl_usage is disabled" do
        APP_CONFIG["check_ssl_usage"] = { "enabled" => false }
        get :show, id: 1, fixes: true
        expect(assigns(:fix)[:ssl]).to be false
      end
    end
  end

  describe "regular errors" do
    it "shows a 500 if no status has been given" do
      get :show, id: 1
      expect(response.status).to eq 500
    end

    it "shows the proper code when given" do
      %w(401 404 422 500).each do |code|
        get :show, status: code
        expect(response.status).to eq code.to_i
      end
    end
  end
end
