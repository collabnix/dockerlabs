# PasswordsController is a Devise controller that takes care of the "password
# forgotten" mechanism.
class PasswordsController < Devise::PasswordsController
  layout "authentication"

  include CheckLDAP

  # Re-implemented from Devise to respond with a proper message on error.
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      redirect_to new_user_password_path, alert: resource.errors.full_messages, float: true
    end
  end

  # Re-implemented from Devise to respond with a proper message on error.
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      update_success
    else
      token = params[:user][:reset_password_token]
      redirect_to "/users/password/edit?reset_password_token=#{token}",
        alert: resource.errors.full_messages, float: true
    end
  end

  protected

  def update_success
    resource.unlock_access! if unlockable?(resource)

    flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
    set_flash_message(:notice, flash_message) if is_flashing_format?
    sign_in(resource_name, resource)

    respond_with resource, location: after_resetting_password_path_for(resource), float: true
  end

  # Prevents redirect loops
  def after_resetting_password_path_for(resource)
    signed_in_root_path(resource)
  end
end
