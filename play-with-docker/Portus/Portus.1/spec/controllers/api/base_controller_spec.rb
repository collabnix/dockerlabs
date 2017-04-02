require "rails_helper"

describe Api::BaseController do

  controller do

    def ping1
      raise Api::BaseController::ScopeNotHandled
    end

    def ping2
      raise Namespace::AuthScope::ResourceIsNotFound
    end

  end

  before do
    @routes.draw do
      get "/ping1", to: "api/base#ping1"
      get "/ping2", to: "api/base#ping2"
    end
  end

  describe ".?deny_access" do

    it "outputs empty body with 401 response status" do
      get :ping1
      expect(response.status).to eq 401
      expect(response.body).to be_empty
    end

  end

end
