require "rails_helper"

describe TagsController, type: :controller do
  let(:valid_session) { {} }

  describe "DELETE #destroy" do
    let!(:registry)   { create(:registry, hostname: "registry.test.lan") }
    let!(:user)       { create(:admin) }
    let!(:repository) { create(:repository, namespace: registry.global_namespace, name: "repo") }
    let!(:tag)        { create(:tag, name: "tag", repository: repository) }

    before :each do
      sign_in user
      request.env["HTTP_REFERER"] = "/"
      APP_CONFIG["delete"] = { "enabled" => true }
    end

    it "removes a tag" do
      allow_any_instance_of(Tag).to receive(:delete_by_digest!).and_return(true)
      delete :destroy, { id: tag.id }, valid_session
      expect(flash[:notice]).to eq "Tag removed successfully"
      expect(flash[:float]).to eq true
      expect(response.status).to eq 302
    end

    it "also removes the repo if there are no more tags" do
      allow_any_instance_of(Tag).to receive(:delete_by_digest!) do
        Tag.destroy_all
      end

      delete :destroy, { id: tag.id }, valid_session
      expect(flash[:notice]).to eq "Image removed with all its tags"
      expect(flash[:float]).to eq true
      expect(response.status).to eq 302
    end

    it "responds accordingly on error" do
      allow_any_instance_of(Tag).to receive(:delete_by_digest!).and_return(false)

      delete :destroy, { id: tag.id }, valid_session
      expect(flash[:alert]).to eq "Tag could not be removed"
      expect(flash[:float]).to eq true
      expect(response.status).to eq 302
    end

    it "raises the proper exception when a tag cannot be found" do
      expect do
        delete :destroy, { id: -1 }, valid_session
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "returns a 403 if deletes are not enabled" do
      APP_CONFIG["delete"] = { "enabled" => false }
      delete :destroy, { id: -1 }, valid_session
      expect(response.status).to eq 403
    end
  end
end
