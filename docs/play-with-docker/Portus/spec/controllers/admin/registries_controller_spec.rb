require "rails_helper"

RSpec.describe Admin::RegistriesController, type: :controller do
  let(:admin) { create(:admin) }

  before :each do
    sign_in admin
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "returns a 404 if there's already a registry in place" do
      create(:registry)
      expect { get :new }.to raise_error(ActionController::RoutingError)
    end
  end

  describe "POST #create" do
    context "not using the Force" do
      it "redirects when there's something wrong with the reachability of the registry" do
        expect do
          post :create, registry: attributes_for(:registry)
        end.to change(Registry, :count).by(0)
        expect(response).to have_http_status(:redirect)
      end
    end

    context "no registry" do
      it "creates a new registry" do
        expect do
          post :create, registry: attributes_for(:registry), force: true
        end.to change(Registry, :count).by(1)
      end

      it "assigns the freshly created registry to all the existing namespaces" do
        3.times { create(:team) }

        post :create, registry: attributes_for(:registry), force: true
        registry = Registry.last

        Namespace.all.each { |n| expect(n.registry).to eq(registry) }
      end
    end

    context "one registry already exists" do
      it "does not create a new registry" do
        create(:registry)

        expect do
          post :create, registry: attributes_for(:registry), force: true
        end.to raise_error(ActionController::RoutingError)
      end
    end

    context "wrong params" do
      it "redirects to the new page" do
        expect do
          post :create, registry: { name: "foo" }, force: true
        end.to change(Registry, :count).by(0)
      end
    end
  end

  describe "GET #edit" do
    let!(:registry) { create(:registry) }

    it "returns 200 on success" do
      get :edit, id: registry.id
      expect(response).to have_http_status(:success)
    end

    it "returns 404 if the registry does not exist" do
      expect do
        get :edit, id: registry.id + 1
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "PUT #update" do
    let!(:registry) { create(:registry) }

    it "does nothing if the registry was not found" do
      expect do
        put :update, id: registry.id + 1, registry: { use_ssl: true }
      end.to raise_error(ActiveRecord::RecordNotFound)
      expect(Registry.first.use_ssl).to be_falsey
    end

    it "does not allow to update if there are repos" do
      old = registry.hostname
      create(:repository)
      put :update, id: registry.id, registry: { hostname: "lala" }
      expect(Registry.first.hostname).to eq old
    end

    it "updates the registry" do
      put :update, id: registry.id, registry: { use_ssl: true, hostname: "lala" }
      reg = Registry.first
      expect(reg.use_ssl).to be_truthy
      expect(reg.hostname).to eq reg.hostname
    end
  end
end
