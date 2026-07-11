class NamespacePolicy
  attr_reader :user, :namespace

  def initialize(user, namespace)
    @user = user
    @namespace = namespace
  end

  def pull?
    # Even non-logged in users can pull from a public namespace.
    return true if namespace.visibility_public?

    # From now on, all the others require to be logged in.
    raise Pundit::NotAuthorizedError, "must be logged in" unless user

    # Logged-in users can pull from a protected namespace even if they are
    # not part of the team.
    return true if namespace.visibility_protected?

    # All the members of the team have READ access or anyone if
    # the namespace is public
    # Everybody can pull from the global namespace
    namespace.global? || user.admin? || namespace.team.users.exists?(user.id)
  end

  alias show? pull?

  def push?
    raise Pundit::NotAuthorizedError, "must be logged in" unless user

    # Only owners and contributors have WRITE access
    user.admin? ||
      namespace.team.owners.exists?(user.id) ||
      namespace.team.contributors.exists?(user.id)
  end

  def index?
    raise Pundit::NotAuthorizedError, "must be logged in" unless user

    user.admin? || namespace.team.users.exists?(user.id)
  end

  def create?
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    (APP_CONFIG.enabled?("user_permission.create_namespace") || user.admin?) && push?
  end

  def update?
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    (user.admin? || (APP_CONFIG.enabled?("user_permission.manage_namespace") &&
                     namespace.team.owners.exists?(user.id))) && push?
  end

  alias all? push?

  def change_visibility?
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    user.admin? || (APP_CONFIG.enabled?("user_permission.change_visibility") &&
                    !namespace.global? && namespace.team.owners.exists?(user.id))
  end

  # Only owners and admins can change the team ownership.
  def change_team?
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    user.admin? || (APP_CONFIG.enabled?("user_permission.manage_namespace") &&
                    namespace.team.owners.exists?(user.id))
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
        .joins(team: [:team_users])
        .where(
          "(namespaces.visibility = :public OR namespaces.visibility = :protected " \
          "OR team_users.user_id = :user_id) AND " \
          "namespaces.global = :global AND namespaces.name != :username",
          public: Namespace.visibilities[:visibility_public],
          protected: Namespace.visibilities[:visibility_protected],
          user_id: user.id, global: false, username: user.username
        )
        .distinct
    end
  end
end
