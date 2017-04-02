# SessionFlash adds the `session_flash` method which deals with flashy messages
# on signup/login, while notifying users about their personal namespace.
module SessionFlash
  extend ActiveSupport::Concern

  # Sets the flash object accordingly for the given authenticated user. The
  # method is the Devise method to be used for greeting the user (e.g.
  # `:signed_up`). If method is nil, then a generic greeting will be set. This
  # method also notifies users about their personal namespace (and whether it
  # changed or not).
  def session_flash(user, method)
    # First of all we've got a greeting.
    if method.nil?
      flash[:notice] = "Welcome!"
    else
      set_flash_message :notice, method unless method.nil?
    end

    # This will happen for the first user, which is the admin that has to
    # configure the registry.
    return if user.namespace.nil?

    # Now inform the user
    ns = user.namespace.name
    str = " Your personal namespace is '#{ns}'"
    str += if user.username == ns
      "."
    else
      " (your username was not a valid Docker namespace, so we had to tweak it)."
    end
    flash[:notice] << str
  end
end
