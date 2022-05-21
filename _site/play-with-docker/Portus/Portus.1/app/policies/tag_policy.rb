# Defines the policy for the tag object.
class TagPolicy
  attr_reader :user, :tag

  def initialize(user, tag)
    @user = user
    @tag = tag
  end

  # Returns true if the tag can be destroyed.
  def destroy?
    raise Pundit::NotAuthorizedError, "must be logged in" unless @user
    @user.admin? || @tag.repository.namespace.team.owners.exists?(user.id)
  end
end
