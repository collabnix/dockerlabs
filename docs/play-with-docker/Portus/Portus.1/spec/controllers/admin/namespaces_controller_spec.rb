require "rails_helper"

RSpec.describe Admin::NamespacesController, type: :controller do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  context "as admin user" do
    before :each do
      create(:registry)
      sign_in admin
    end

    describe "GET #index" do
      let!(:portus) { create(:admin, username: "portus") }

      context "pagination" do
        it "paginates namespaces" do
          get :index
          expect(assigns(:namespaces)).to respond_to(:total_pages)
        end

        it "paginates correctly in multiple pages" do
          t = create(:team, name: "randomteam")
          r = Registry.get
          33.times { |_| create(:namespace, team: t, registry: r) }

          get :index
          ns = assigns(:namespaces)

          get :index, page: 2
          ns += assigns(:namespaces)

          # The global namespace and the one for the portus user.
          ns = Namespace.all - ns
          expect(ns.count).to eq 2
        end
      end

      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "does not contain the portus namespace" do
        get :index
        namespaces = assigns(:namespaces)
        expect(namespaces.count).to eq 2

        # Global & portus namespaces.
        expect(Namespace.all.count).to eq 4
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
