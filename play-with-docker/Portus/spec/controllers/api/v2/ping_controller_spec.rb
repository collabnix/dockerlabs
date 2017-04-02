require "rails_helper"

describe Api::V2::PingController do

  describe "#ping" do

    context "user authorized" do

      it "responds with 200" do
        sign_in(create(:user))
        get :ping
        expect(response.status).to eq 200
      end

    end

  end

end
