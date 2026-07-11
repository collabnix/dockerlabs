require "rails_helper"

describe RepositoriesController, type: :controller do
  let(:valid_session) { {} }
  let(:user) { create(:user) }
  let!(:public_namespace) do
    create(:namespace,
           visibility: Namespace.visibilities[:visibility_public],
           team:       create(:team))
  end
  let!(:visible_repository) { create(:repository, namespace: public_namespace) }
  let!(:private_namespace) do
    create(:namespace,
           visibility: Namespace.visibilities[:visibility_private],
           team:       create(:team))
  end
  let!(:invisible_repository) { create(:repository, namespace: private_namespace) }

  before :each do
    sign_in user
  end

  describe "GET #index" do
    it "assigns all repositories as @repositories" do
      get :index, {}, valid_session
      expect(assigns(:repositories)).to eq([visible_repository])
    end
  end

  describe "GET #show" do
    it "assigns the requested repository as @repository" do
      get :show, { id: visible_repository.to_param }, valid_session
      expect(assigns(:repository)).to eq(visible_repository)
    end
  end

  describe "POST #toggle_star" do
    it "Succeeds when calling star" do
      repository = create(:repository)
      post :toggle_star, { id: repository.to_param, format: :erb }, valid_session

      expect(assigns(:repository)).to eq(repository)
      expect(response.status).to eq 200
    end

    it "Succeeds when calling unstar" do
      repository = create(:repository, :starred)
      post :toggle_star, { id: repository.to_param, format: :erb }, valid_session

      expect(assigns(:repository)).to eq(repository)
      expect(response.status).to eq 200
    end
  end

  describe "DELETE #destroy" do
    let!(:registry)   { create(:registry, hostname: "registry.test.lan") }
    let!(:user)       { create(:admin) }
    let!(:repository) { create(:repository, namespace: registry.global_namespace, name: "repo") }
    let!(:repo)       { create(:repository, namespace: registry.global_namespace, name: "repo2") }
    let!(:tag1)       { create(:tag, name: "tag1", repository: repository, digest: "1") }
    let!(:tag2)       { create(:tag, name: "tag2", repository: repository, digest: "1") }
    let!(:tag3)       { create(:tag, name: "tag3", repository: repository, digest: "2") }
    let!(:tag4)       { create(:tag, name: "tag4", repository: repo, digest: "3") }

    before :each do
      sign_in user
      request.env["HTTP_REFERER"] = "/"
      APP_CONFIG["delete"] = { "enabled" => true }
    end

    it "removes the repository properly" do
      allow_any_instance_of(Tag).to receive(:fetch_digest, &:digest)
      allow_any_instance_of(Portus::RegistryClient).to receive(:delete).and_return(true)

      delete :destroy, { id: repository.id }, valid_session
      expect(flash[:notice]).to eq "Repository removed with all its tags"
      expect(flash[:float]).to eq true
      expect(response.status).to eq 302

      expect(Repository.find_by(id: repository.id)).to be_nil
    end

    it "describes a proper error if tags could not be removed" do
      allow_any_instance_of(Tag).to receive(:delete_by_digest!).and_return(true)

      delete :destroy, { id: repository.id }, valid_session
      expect(flash[:alert]).to eq "Could not remove all the tags"
      expect(flash[:float]).to eq true
      expect(response.status).to eq 302

      # Even if it fails in our tests, all tags should be "marked".
      Tag.where(repository: repository).each { |t| expect(t.marked).to be_truthy }
      Tag.where(repository: repo).each { |t| expect(t.marked).to be_falsey }
      expect(repository.reload.marked).to be_truthy
      expect(repo.reload.marked).to be_falsey
    end

    it "returns a 403 if deletes are not enabled" do
      APP_CONFIG["delete"] = { "enabled" => false }
      delete :destroy, { id: -1 }, valid_session
      expect(response.status).to eq 403
    end
  end
end
