# We use our own error routes because we need to display pages for bad server
# configurations too. Moreover, this way we get richer pages while sharing as
# much code as possible.
class ErrorsController < ApplicationController
  respond_to :html, :csv

  skip_before_action :check_requirements
  skip_before_action :authenticate_user!
  skip_before_action :force_update_profile!
  skip_before_action :force_registry_config!

  # Common endpoint for all errors.
  def show
    @status = status_code
    render @status.to_s, status: @status, layout: "errors"
  end

  protected

  # Returns the status code to be displayed.
  def status_code
    if params[:fixes]
      @fix = fixes
      @fix[:database] = env["action_dispatch.exception"].class.name.starts_with? "ActiveRecord"
      500
    else
      status = params[:status]
      lookup_context.exists?("errors/#{status}") ? status.to_i : 500
    end
  end
end
