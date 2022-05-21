require "rails_helper"

RSpec.describe Admin::TeamsController, type: :controller do

  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  context "as admin user" do
    before :each do
      create(:registry)
      sign_in admin
    end

    describe "GET #index" do
      it "paginates teams" do
        get :index
        expect(assigns(:teams)).to respond_to(:total_pages)
      end

      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  context "not logged into portus" do
    describe "GET #index" do
      it "redirects to login page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "as normal user" do
    before :each do
      sign_in user
    end

    describe "GET #index" do
      it "blocks access" do
        get :index
        expect(response.status).to eq(401)
      end
    end
  end

end
