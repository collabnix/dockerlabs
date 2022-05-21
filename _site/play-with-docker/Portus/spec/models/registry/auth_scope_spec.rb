require "rails_helper"

describe Registry::AuthScope, type: :model do
  describe "registries" do
    it "raises an exception if there's no registry" do
      reg = Registry.new(hostname: "host", name: "name")
      scope = Registry::AuthScope.new(reg, "scope:string:lala")
      expect do
        scope.resource
      end.to raise_error(Registry::AuthScope::ResourceNotFound)
    end

    it "returns the current registry" do
      reg = create(:registry)
      scope = Registry::AuthScope.new(reg, "scope:string:lala")
      res = scope.resource
      expect(reg.hostname).to eq res.hostname
      expect(reg.name).to eq res.name
    end
  end

  describe "scopes" do
    let!(:registry) { create(:registry) }

    it "returns an invalid scope for incomplete scope strings" do
      ["scope", "scope:lala"].each do |sc|
        scope = Registry::AuthScope.new(registry, sc)
        expect(scope.scopes).to match_array([])
      end
    end

    it "returns an invalid scope for an unknown scope string" do
      # The resource type is guaranteed to equal "registry" by the caller.
      ["registry:cata:aa", "registry:catalog:lala", "registry:lala:*"].each do |sc|
        scope = Registry::AuthScope.new(registry, sc)
        expect(scope.scopes).to match_array([])
      end
    end

    it 'returns "all" for a valid scope' do
      scope = Registry::AuthScope.new(registry, "registry:catalog:*")
      expect(scope.scopes).to match_array(["all"])
    end
  end
end
