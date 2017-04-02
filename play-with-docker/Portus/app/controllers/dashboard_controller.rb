class DashboardController < ApplicationController
  def index
    @recent_activities = policy_scope(PublicActivity::Activity)
                         .limit(20)
                         .order("created_at desc")
    @repositories = policy_scope(Repository)

    # The personal namespace could not exist, that happens when portus
    # does not have a registry associated yet (right after the initial setup)
    personal_namespace = current_user.namespace
    @personal_repositories = personal_namespace ? personal_namespace.repositories : []

    @stars = current_user.stars.order("updated_at desc")
  end
end
