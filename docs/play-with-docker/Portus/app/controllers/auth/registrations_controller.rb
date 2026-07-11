class Auth::RegistrationsController < Devise::RegistrationsController
  layout "authentication", except: :edit

  include CheckLDAP
  include SessionFlash

  before_action :check_signup, only: [:new, :create]
  before_action :check_admin, only: [:new, :create]
  before_action :configure_sign_up_params, only: [:create]
  before_action :authenticate_user!, only: [:disable]

  # Re-implemented so the template has the auxiliary variables regarding if
  # there are more users on the system or this is the first user to be created.
  def new
    @have_users = User.not_portus.any?
    super
  end

  def create
    build_resource(sign_up_params)

    resource.save
    if resource.persisted?
      session_flash(resource, :signed_up)
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource), float: true
    else
      redirect_to new_user_registration_path,
        alert: resource.errors.full_messages
    end
  end

  def edit
    @admin_count = User.admins.count
    super
  end

  def update
    success =
      if password_update?
        succ = current_user.update_with_password(user_params)
        sign_in(current_user, bypass: true) if succ
        succ
      else
        current_user.update_without_password(params.require(:user).permit(:email, :display_name))
      end

    if success
      redirect_to edit_user_registration_path,
        notice: "Profile updated successfully!", float: true
    else
      redirect_to edit_user_registration_path,
        alert: resource.errors.full_messages, float: true
    end
  end

  # Enable/Disable a user.
  def toggle_enabled
    user = User.find(params[:id])

    if current_user.toggle_enabled!(user)
      sign_out user if current_user == user && !user.enabled?
      render template: "auth/registrations/toggle_enabled",
             locals:   { user: user, path: request.fullpath }
    else
      render nothing: true, status: 403
    end
  end

  # Devise does not allow to disable routes on purpose. Ideally, though we
  # could still be able to disable the `destroy` method through the
  # `routes.rb` file as described in the wiki (by disabling all the routes and
  # calling `devise_scope` manually). However, this solution has the caveat
  # that it would ignore some calls (e.g. the `layout` call above). Therefore,
  # the best solution is to just implement a `destroy` method that just returns
  # a 404.
  def destroy
    render nothing: true, status: 404
  end

  def check_admin
    @admin = User.admins.any?
    @first_user_admin = APP_CONFIG.enabled?("first_user_admin")
  end

  # Redirect to the login page if users cannot access the signup page.
  def check_signup
    redirect_to new_user_session_path unless APP_CONFIG.enabled?("signup")
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :email
    return if User.admins.any?
    devise_parameter_sanitizer.for(:sign_up) << :admin
  end

  protected

  # Returns true if the contents of the `params` hash contains the needed keys
  # to update the password of the user.
  def password_update?
    user = params[:user]
    !user[:current_password].blank? || !user[:password].blank? ||
      !user[:password_confirmation].blank?
  end

  # Returns the required parameters and the permitted ones for updating a user.
  def user_params
    params.require(:user)
          .permit(:password, :password_confirmation, :current_password)
  end

  # Prevents redirect loops
  def after_sign_up_path_for(resource)
    signed_in_root_path(resource)
  end
end
