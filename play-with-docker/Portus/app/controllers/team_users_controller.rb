# TeamUsersController manages the creation/removal/update of members of a team.
class TeamUsersController < ApplicationController
  before_action :set_team_user
  before_action :promoted_owner, only: [:create, :update]
  before_action :only_owner, only: [:update, :destroy]
  after_action :verify_authorized

  respond_to :js

  # POST /team_users
  def create
    # Promote this user if it is a Portus admin.
    @team_user.role = TeamUser.roles[:owner] if @promoted_role

    if @team_user.errors.empty? && @team_user.save
      @team_user.create_activity!(:add_member, current_user,
                                  team_user: @team_user.user.username,
                                  team:      @team_user.team.name)
      respond_with @team_user
    else
      respond_with @team_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /team_users/1
  def update
    # Send an error if an admin was about to get demoted.
    if @promoted_role
      @team_user.errors.add(:user, "cannot be demoted because it's a Portus admin")
      respond_with @team_user.errors, status: :unprocessable_entity
      return
    end

    team_user_params = params.require(:team_user).permit(:role)

    old_role = @team_user.role
    @team_user.update(team_user_params)
    @team_user.create_activity! :change_member_role, current_user,
                                old_role:  old_role,
                                new_role:  team_user_params["role"],
                                team:      @team_user.team.name,
                                team_user: @team_user.user.username

    respond_on_update_or_destroy!("/teams/#{@team_user.team.id}")
  end

  # DELETE /team_users/1
  def destroy
    @team_user.create_activity!(:remove_member, current_user,
                                team_user: @team_user.user.username,
                                team:      @team_user.team.name)
    @team_user.destroy

    respond_on_update_or_destroy!("/teams")
  end

  private

  # Both the update and the destroy methods have to redirect if users acted
  # upon themselves. Otherwise, the team_user object is returned.
  def respond_on_update_or_destroy!(redirect_path)
    if @team_user.user == current_user
      render js: "window.location = '#{redirect_path}'"
    else
      respond_with @team_user
    end
  end

  # Set the @team_user for any given method.
  def set_team_user
    # If :id is nil, then we are in the create method, and therefore the
    # team_user has to be created from the given parameters. Otherwise, just
    # find the team_user from the DB.
    if params[:id].nil?
      tu = params.require(:team_user)

      team = Team.find_by!(name: tu["team"])
      user = User.find_by(username: tu["user"])

      @team_user = TeamUser.new(team: team, user: user, role: tu["role"])
      @team_user.errors.add(:user, "cannot be found") if user.nil?
    else
      @team_user = TeamUser.find(params[:id])
    end

    authorize @team_user
  end

  # Sets the @promoted_role instance variable if a Portus admin is going to be
  # set a role other than owner.
  def promoted_owner
    return if @team_user.user.nil?

    tu   = params.require(:team_user).permit(:role)
    role = TeamUser.roles[tu["role"]]

    return if role == TeamUser.roles[:owner] || !@team_user.user.admin?
    @promoted_role = true
  end

  # Responds with an error if the client is trying to remove the only owner of
  # the team through either the update or the destroy methods.
  def only_owner
    return unless @team_user.only_owner?
    return unless params["team_user"].nil? || params["team_user"] != "owner"

    @team_user.errors.add(:base, "Cannot remove the only owner of the team")
    respond_with @team_user.errors, status: :unprocessable_entity
  end
end
