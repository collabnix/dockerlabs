# Policy for team members. It does not authorize anything unless the author of
# the action is an owner. An owner is either an admin of Portus or an owner of
# the team itself.
class TeamUserPolicy
  attr_reader :user, :team_user

  def initialize(user, team_user)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user

    @user      = user
    @team_user = team_user
  end

  def owner?
    user.admin? || @team_user.team.owners.exists?(user.id)
  end

  alias destroy? owner?
  alias update? owner?
  alias create? owner?
end
