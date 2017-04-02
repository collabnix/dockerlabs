require "rails_helper"

RSpec.describe SearchHelper, type: :helper do

  describe "build_search_category_url" do
    it "returns true if current user is an owner of the team" do
      expected = "#{search_index_path}?utf8=✓&search=&type=repositories"
      params = { utf8: "✓", search: "" }
      expect(helper.build_search_category_url(params, "repositories")).to eq expected
    end
  end
end
