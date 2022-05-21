module NamespacesHelper
  def can_manage_namespace?(namespace)
    current_user.admin? || (owner?(namespace) &&
                            APP_CONFIG.enabled?("user_permission.manage_namespace"))
  end

  def can_create_namespace?
    current_user.admin? || APP_CONFIG.enabled?("user_permission.create_namespace")
  end

  def can_change_visibility?(namespace)
    current_user.admin? || (owner?(namespace) &&
                            APP_CONFIG.enabled?("user_permission.change_visibility"))
  end

  def owner?(namespace)
    namespace.team.owners.exists?(current_user.id)
  end

  def contributor?(namespace)
    namespace.team.contributors.exists?(current_user.id)
  end

  def viewer?(namespace)
    namespace.team.viewers.exists?(current_user.id)
  end

  def can_pull?(namespace)
    NamespacePolicy.new(current_user, namespace).pull?
  end

  def can_push?(namespace)
    NamespacePolicy.new(current_user, namespace).push?
  end
end
