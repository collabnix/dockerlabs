require "csv"

class Admin::ActivitiesController < Admin::BaseController
  respond_to :html, :csv

  def index
    respond_to do |format|
      format.html do
        @activities = PublicActivity::Activity.order("created_at DESC").page(params[:page])
      end
      format.csv do
        @activities = PublicActivity::Activity.order("created_at DESC")
        headers["Content-Disposition"] = 'attachment; filename="activities.csv"'
        headers["Content-Type"] = "text/csv"
      end
    end
  end
end
