class Admin::DashboardController < Admin::BaseController
  def index
    @recent_activities = PublicActivity::Activity
                         .order("created_at DESC")
                         .limit(20)
    @portus_exists = User.where(username: "portus").any?
  end
end
