# CheckLDAP redirects the user to the new_user_session_path if LDAP support is
# enabled. A `before_action` will be created for the :new and the :create
# methods.
module CheckLDAP
  extend ActiveSupport::Concern

  included do
    before_action :check_ldap, only: [:new, :create]
  end

  # Redirect to the login page if LDAP is enabled.
  def check_ldap
    redirect_to new_user_session_path if Portus::LDAP.enabled?
  end
end
