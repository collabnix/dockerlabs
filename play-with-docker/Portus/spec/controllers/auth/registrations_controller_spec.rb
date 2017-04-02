require "rails_helper"

describe Auth::RegistrationsController do
  let(:valid_session) { {} }

  describe "POST #create" do
    before :each do
      request.env["devise.mapping"] = Devise.mappings[:user]
      APP_CONFIG["signup"] = { "enabled" => true }
    end

    it "defaults admin to false when omitted" do
      post :create, user: {
        "username"              => "administrator",
        "email"                 => "administrator@test.com",
        "password"              => "12341234",
        "password_confirmation" => "12341234"
      }
      expect(User.find_by!(username: "administrator")).not_to be_admin
    end

    it "handles the admin column properly" do
      post :create, user: {
        "username"              => "administrator",
        "email"                 => "administrator@test.com",
        "password"              => "12341234",
        "password_confirmation" => "12341234",
        "admin"                 => true
      }
      expect(User.find_by!(username: "administrator")).to be_admin
    end

    it "omits the value of admin if there is already another admin" do
      create(:admin)
      post :create, user: {
        "username"              => "wonnabeadministrator",
        "email"                 => "wonnabeadministrator@test.com",
        "password"              => "12341234",
        "password_confirmation" => "12341234",
        "admin"                 => true
      }
      expect(User.find_by!(username: "wonnabeadministrator")).not_to be_admin
    end
  end

  describe "PUT #update" do

    let!(:user) { create(:admin) }

    before :each do
      request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    it "does not allow invalid emails" do
      email = User.find(user.id).email
      put :update, user: { "email" => "invalidone" }
      expect(User.find(user.id).email).to eq(email)
      put :update, user: { "email" => "valid@example.com" }
      expect(User.find(user.id).email).to eq("valid@example.com")
    end

    # NOTE: since the tests on passwords also have to take care that even if
    # there are other parameters (e.g. emails), they are ignored when there are
    # password parameters, these tests will always have an extra parameter.

    it "does not allow empty passwords" do
      put :update, user: {
        "email"                 => "user@example.com",
        "current_password"      => "test-password",
        "password"              => "",
        "password_confirmation" => ""
      }
      expect(User.find(user.id).valid_password?("test-password")).to be true
    end

    it "checks that the old password is ok" do
      put :update, user: {
        "email"                 => "user@example.com",
        "current_password"      => "test-passwor",
        "password"              => "new-password",
        "password_confirmation" => "new-password"
      }
      expect(User.find(user.id).valid_password?("test-password")).to be true
    end

    it "checks that the new password and its confirmation match" do
      put :update, user: {
        "email"                 => "user@example.com",
        "current_password"      => "test-password",
        "password"              => "new-password",
        "password_confirmation" => "new-passwor"
      }
      expect(User.find(user.id).valid_password?("test-password")).to be true
    end

    it "changes the password when everything is alright" do
      put :update, user: {
        "email"                 => "user@example.com",
        "current_password"      => "test-password",
        "password"              => "new-password",
        "password_confirmation" => "new-passwor"
      }
      expect(User.find(user.id).valid_password?("test-password")).to be true
    end

  end

  describe "DELETE #destroy" do
    let!(:user) { create(:admin) }

    before :each do
      request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    it "does not allow the removal of users" do
      delete :destroy, id: user.id
      expect(User.find(user.id)).to_not be nil
    end
  end

  # This describe does not try to tests *every* single possibility, since has
  # already been tested in the user_spec file.
  describe "PUT #toggle_enabled" do
    let!(:admin) { create(:admin) }
    let!(:user) { create(:user) }

    before :each do
      request.env["devise.mapping"] = Devise.mappings[:user]
    end

    it "sends a 403 if the action is not allowed" do
      sign_in admin
      put :toggle_enabled, id: admin.id
      expect(response.status).to be 403
    end

    it "sends a 200 if the action is allowed" do
      sign_in admin
      put :toggle_enabled, id: user.id, format: :erb
      expect(response.status).to be 200
    end

    it "signs out if the user disable itself" do
      sign_in user
      expect(warden.authenticated?(:user)).to be true
      put :toggle_enabled, id: user.id, format: :erb
      expect(response.status).to be 200
      expect(warden.authenticated?(:user)).to be false
    end
  end
end
