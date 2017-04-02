require "rails_helper"

RSpec.describe RepositoriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/repositories").to route_to("repositories#index")
    end

    it "routes to #show" do
      expect(get: "/repositories/1").to route_to("repositories#show", id: "1")
    end

    it "routes to #toggle_star" do
      expect(post: "/repositories/1/toggle_star")
        .to route_to("repositories#toggle_star", id: "1")
    end
  end
end
