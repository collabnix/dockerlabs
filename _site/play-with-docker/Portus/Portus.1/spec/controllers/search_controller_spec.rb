require "rails_helper"

RSpec.describe SearchController, type: :controller do
  let(:registry)    { create(:registry) }
  let(:user)        { create(:user) }
  let(:team)        { create(:team, owners: [user]) }

  before :each do
    sign_in user

    namespace = create(:namespace, team: team, registry: registry)
    @repository = create(:repository, namespace: namespace)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, search: @repository.name
      expect(response).to have_http_status(:success)
    end
  end
end
