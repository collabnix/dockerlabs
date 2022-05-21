class CommentPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  # Allows the admin to write comments
  # Allows all members of a team to comment on their repos
  # Allows all users to comment on repos under a protected or public namespace
  def create?
    @user.admin? ||
      @comment.repository.namespace.visibility_public? ||
      @comment.repository.namespace.visibility_protected? ||
      @comment.repository.namespace.team.team_users.where(user_id: @user.id).any?
  end

  # Allows only the admin and author to delete comments
  def destroy?
    @user.admin? || @comment.author?(@user)
  end
end
