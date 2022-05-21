require "rails_helper"

describe Auth::SessionsController do
  describe "POST #create" do
    before :each do
      request.env["devise.mapping"] = Devise.mappings[:user]
      APP_CONFIG["signup"] = { "enabled" => true }
      APP_CONFIG["ldap"] = { "enabled" => true }
    end

    it "sets the session hash on LDAP when it's the first time" do
      create(:registry)

      # Warden magic
      user = build(:user)
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)

      # So we test the special case of login that is really a signup.
      session[:first_login] = true
      post :create, session: {
        "username" => "user",
        "email"    => "user@test.com"
      }

      expect(flash["notice"]).to eq(
        "Welcome! Your personal namespace is '#{user.username}'."
      )
    end
  end
end
