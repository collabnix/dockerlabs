require "rails_helper"

describe TeamUsersController do
  let(:owner)       { create(:user) }
  let(:contributor) { create(:user) }
  let(:team)        { create(:team, owners: [owner], contributors: [contributor]) }

  describe "as an owner of the team" do
    before :each do
      sign_in owner
    end

    describe "DELETE #destroy" do
      it "does not allow to remove the only owner of the team" do
        owner_role = TeamUser.roles["owner"]
        delete :destroy, id: team.team_users.find_by(role: owner_role).id, format: "js"
        expect(team.owners.exists?(owner.id)).to be true
      end

      it "removes a team user" do
        user = create(:user)
        team.viewers << user

        viewer = TeamUser.roles["viewer"]
        delete :destroy, id: team.team_users.find_by(role: viewer).id, format: "js"
        expect(team.viewers.exists?(user.id)).to be false
      end

      it "redirects to the teams page when the user removes himself" do
        user = create(:user)
        team.owners << user

        delete :destroy, id: team.team_users.find_by(user_id: owner.id).id, format: "js"
        expect(team.owners.exists?(owner.id)).to be false
        expect(response.body).to eq("window.location = '/teams'")
      end
    end

    describe "PUT #update" do
      it "does not allow to change the role of the only owner of the team" do
        put :update, id: team.team_users.find_by(role: TeamUser.roles["owner"]).id,
                     team_user: { role: "viewer" }, format: "js"
        expect(team.owners.exists?(owner.id)).to be true
        expect(assigns(:team_user).errors.full_messages)
          .to match_array(["Cannot remove the only owner of the team"])
      end

      it "changes the roles of a team user" do
        user = create(:user)
        team.viewers << user

        put :update, id: team.team_users.find_by(role: TeamUser.roles["viewer"]).id,
                     team_user: { role: "contributor" }, format: "js"
        expect(team.contributors.exists?(user.id)).to be true
        expect(assigns(:team_user).errors).to be_empty
      end

      it "does not allow an admin to be demoted" do
        user = create(:admin)
        team.owners << user

        put :update, id: team.team_users.find_by(user: user).id,
                     team_user: { role: "contributor" }, format: "js"
        expect(response.status).to eq 422
        expect(team.owners.exists?(user.id)).to be true
      end

      it "forces a page reload when the current user changes his role" do
        user = create(:user)
        team.owners << user

        put :update, id: team.team_users.find_by(user_id: owner.id).id,
                     team_user: { role: "contributor" }, format: "js"
        expect(team.contributors.exists?(owner.id)).to be true
        expect(assigns(:team_user).errors).to be_empty
        expect(response.body).to eq("window.location = '/teams/#{team.id}'")
      end
    end

    describe "POST #create" do
      it "adds a new member to the team" do
        new_user = create(:user)
        post :create,
             team_user: { team: team.name, user: new_user.username, role: TeamUser.roles["owner"] },
             format:    "js"
        expect(team.owners.exists?(new_user.id)).to be true
      end

      it "sets admins as owners always" do
        new_user = create(:admin)
        post :create,
             team_user: {
               team: team.name,
               user: new_user.username,
               role: TeamUser.roles["viewer"]
             },
             format:    "js"
        expect(team.owners.exists?(new_user.id)).to be true
      end

      it "returns an error if the user is not found" do
        post :create,
             team_user: { team: team.name, user: "ghost", role: TeamUser.roles["owner"] },
             format:    "js"
        expect(assigns(:team_user).errors.full_messages).to match_array(["User cannot be found"])
        expect(response.status).to eq 422
      end

      it "returns an error if the user has already a role inside of the team" do
        owner_role = TeamUser.roles["owner"]
        post :create,
             team_user: { team: team.name, user: contributor.username, role: owner_role },
             format:    "js"
        expect(assigns(:team_user).errors.full_messages)
          .to match_array(["User has already been taken"])
        expect(response.status).to eq 422
      end
    end

  end

  describe "as an unprivileged member of the team" do
    before :each do
      sign_in contributor
    end

    describe "POST #create" do
      it "raises an unauthorized access error" do
        new_user = create(:user)
        post :create,
             team_user: { team: team.name, user: new_user.username, role: TeamUser.roles["owner"] },
             format:    "js"
        expect(response.status).to eq 401
      end
    end

    describe "DELETE #destroy" do
      it "raises an unauthorized access error" do
        delete :destroy, id: team.team_users.find_by(role: TeamUser.roles["owner"]).id, format: "js"
        expect(response.status).to eq 401
      end
    end

    describe "PUT #update" do
      it "raises an unauthorized access error" do
        put :update, id: team.team_users.find_by(role: TeamUser.roles["owner"]).id,
                     team_user: { role: "viewer" }, format: "js"
        expect(response.status).to eq 401
      end
    end
  end

  describe "activity tracking" do
    before :each do
      sign_in owner
    end

    it "tracks addition a team member" do
      new_user = create(:user)
      new_user_role = "owner"

      expect do
        tu = { team: team.name, user: new_user.username, role: TeamUser.roles[new_user_role] }
        post :create, team_user: tu, format: "js"
      end.to change(PublicActivity::Activity, :count).by(1)

      activity = PublicActivity::Activity.last
      expect(activity.key).to eq("team.add_member")
      expect(activity.owner).to eq(owner)
      expect(activity.trackable).to eq(team)
      expect(activity.recipient).to eq(new_user)

      params = activity.parameters
      expect(params.size).to eq 3
      expect(params[:role]).to eq new_user_role
      expect(params[:team_user]).to eq new_user.username
      expect(params[:team]).to eq team.name
    end

    it "tracks removal of team members" do
      user = create(:user)
      team.viewers << user

      expect do
        viewer = TeamUser.roles["viewer"]
        delete :destroy, id: team.team_users.find_by(role: viewer).id, format: "js"
      end.to change(PublicActivity::Activity, :count).by(1)

      activity = PublicActivity::Activity.last
      expect(activity.key).to eq("team.remove_member")
      expect(activity.owner).to eq(owner)
      expect(activity.trackable).to eq(team)
      expect(activity.recipient).to eq(user)

      params = activity.parameters
      expect(params.size).to eq 3
      expect(params[:role]).to eq "viewer"
      expect(params[:team_user]).to eq user.username
      expect(params[:team]).to eq team.name
    end

    it "tracks changes of role" do
      user = create(:user)
      team.viewers << user

      expect do
        put :update, id: team.team_users.find_by(role: TeamUser.roles["viewer"]).id,
                     team_user: { role: "contributor" }, format: "js"
      end.to change(PublicActivity::Activity, :count).by(1)

      activity = PublicActivity::Activity.last
      expect(activity.key).to eq("team.change_member_role")
      expect(activity.owner).to eq(owner)
      expect(activity.trackable).to eq(team)
      expect(activity.recipient).to eq(user)

      params = activity.parameters
      expect(params.size).to eq 5
      expect(params[:role]).to eq "contributor"
      expect(params[:team_user]).to eq user.display_username
      expect(params[:team]).to eq team.name
      expect(params[:old_role]).to eq "viewer"
      expect(params[:new_role]).to eq "contributor"
    end

    it "tracks changes on the name of the team" do
      oname = team.name

      # Add team member
      new_user = create(:user)
      post :create,
           team_user: { team: team.name, user: new_user.username, role: TeamUser.roles["viewer"] },
           format:    "js"

      # Update team member
      put :update, id: team.team_users.find_by(user: new_user.id).id,
          team_user: { role: "contributor" }, format: "js"

      # Remove team member
      delete :destroy, id: team.team_users.find_by(user: new_user.id).id, format: "js"

      team.update(name: "new-name")

      PublicActivity::Activity.all.each { |a| expect(a.parameters[:team]).to eq oname }
    end
  end
end
