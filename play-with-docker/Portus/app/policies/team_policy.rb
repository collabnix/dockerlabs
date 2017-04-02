class TeamPolicy
  attr_reader :user, :team

  def initialize(user, team)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @team = team
  end

  def member?
    user.admin? || @team.users.exists?(user.id)
  end

  def owner?
    user.admin? || @team.owners.exists?(user.id)
  end

  def create?
    APP_CONFIG.enabled?("user_permission.create_team") || user.admin?
  end

  def update?
    (APP_CONFIG.enabled?("user_permission.manage_team") || user.admin?) && !@team.hidden? && owner?
  end

  alias show? member?
  alias typeahead? owner?

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      user.teams.where(hidden: false)
    end
  end
end
