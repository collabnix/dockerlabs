class Api::V2::PingController < Api::BaseController
  def ping
    authenticate_user!
    head :ok
  end
end
