require "rails_helper"

RSpec.describe NamespacesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/namespaces").to route_to("namespaces#index")
    end

    it "routes to #show" do
      expect(get: "/namespaces/1").to route_to("namespaces#show", id: "1")
    end
  end
end
