class Api::BaseController < ActionController::Base
  class ScopeNotHandled < StandardError; end
  class RegistryNotHandled < StandardError; end

  include Pundit

  respond_to :json

  rescue_from Pundit::NotAuthorizedError, with: :deny_access
  rescue_from ScopeNotHandled, with: :deny_access
  rescue_from RegistryNotHandled, with: :deny_access
  rescue_from Portus::AuthScope::ResourceNotFound, with: :deny_access

  protected

  # It logs the exception message and sends a 401.
  def deny_access(exception)
    logger.info "Denied access on these grounds: #{exception.message}"
    head :unauthorized
  end
end
