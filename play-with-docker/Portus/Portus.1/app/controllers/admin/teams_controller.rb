class Admin::TeamsController < Admin::BaseController
  def index
    @teams = Team.all_non_special.page(params[:page])
  end
end
