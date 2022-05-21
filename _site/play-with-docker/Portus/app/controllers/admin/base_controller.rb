class Admin::BaseController < ApplicationController
  before_action :ensure_admin!

  protected

  def ensure_admin!
    deny_access unless current_user.admin?
  end
end
