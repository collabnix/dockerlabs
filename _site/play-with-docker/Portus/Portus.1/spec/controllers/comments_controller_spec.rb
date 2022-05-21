require "rails_helper"

describe CommentsController, type: :controller do
  let(:admin) { create(:admin) }
  let(:owner) { create(:user) }
  let(:user) { create(:user) }
  let!(:team) { create(:team, owners: [owner]) }
  let!(:public_namespace) do
    create(:namespace,
           visibility: Namespace.visibilities[:visibility_public],
           team:       team)
  end
  let!(:visible_repository) { create(:repository, namespace: public_namespace) }
  let!(:protected_namespace) do
    create(:namespace,
           visibility: Namespace.visibilities[:visibility_protected],
           team:       team)
  end
  let!(:protected_repository) { create(:repository, namespace: protected_namespace) }
  let!(:private_namespace) do
    create(:namespace,
           visibility: Namespace.visibilities[:visibility_private],
           team:       team)
  end
  let!(:invisible_repository) { create(:repository, namespace: private_namespace) }
  let(:comment) { create(:comment, author: owner) }
  let!(:commented_repository) do
    create(:repository, comments: [comment], namespace: private_namespace)
  end

  let(:valid_attributes) do
    { body: "short test comment" }
  end

  let(:invalid_attributes) do
    { foo: "not valid" }
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new comment" do
        sign_in owner
        expect do
          repository_id = invisible_repository.id
          post :create, repository_id: repository_id, comment: valid_attributes, format: "js"
          expect(response.status).to eq 200
        end.to change(Comment, :count).by(1)
        expect(assigns(:comment).author.id).to eq owner.id
      end

      it "does allow everyone to write comments for a repository under a public namespace" do
        sign_in user
        post :create, repository_id: visible_repository.id, comment: valid_attributes, format: :js
        expect(response.status).to eq 200
      end

      it "allows logged-in users to write comments for a repository under a protected namespace" do
        sign_in user
        post :create, repository_id: protected_repository.id, comment: valid_attributes, format: :js
        expect(response.status).to eq 200
      end

      it "does allow the admin to write comments for every repository" do
        sign_in admin
        post :create, repository_id: invisible_repository.id, comment: valid_attributes, format: :js
        expect(response.status).to eq 200
      end

      it "does not allow a user who has no access to the repository to write comments" do
        sign_in user
        post :create, repository_id: invisible_repository.id, comment: valid_attributes, format: :js
        expect(response.status).to eq 401
      end
    end

    context "with invalid params" do
      it "does not allow invalid parameters" do
        sign_in owner
        repository_id = invisible_repository.id
        post :create, repository_id: repository_id, comment: invalid_attributes, format: :js
        expect(assigns(:comment)).to be_a_new(Comment)
        expect(response.status).to eq 422
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes a comment" do
      sign_in owner
      expect do
        delete :destroy, repository_id: commented_repository.id, id: comment.id, format: :js
      end.to change(Comment, :count).by(-1)
    end

    it "does allow to delete a comment if the user is admin" do
      sign_in admin
      expect do
        delete :destroy, repository_id: commented_repository.id, id: comment.id, format: :js
      end.to change(Comment, :count).by(-1)
    end

    it "does not allow to delete the comment if the user is not the author" do
      sign_in user
      expect do
        delete :destroy, repository_id: commented_repository.id, id: comment.id, format: :js
      end.to change(Comment, :count).by(0)
      expect(response.status).to eq 401
    end
  end
end
