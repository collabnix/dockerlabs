class Admin::UsersController < Admin::BaseController
  respond_to :html, :js
  before_action :another_user_access, only: [:edit, :update, :destroy]

  def index
    @users = User.not_portus.order(:username).page(params[:page])
    @admin_count = User.admins.count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_create_params)

    if @user.persisted?
      flash[:notice] = "User '#{@user.username}' was created successfully"
      flash[:float] = true
      redirect_to admin_users_path
    else
      flash[:alert] = @user.errors.full_messages
      flash[:float] = true
      render "new"
    end
  end

  # GET /admin/user/1/edit
  def edit
  end

  # PATCH/PUT /admin/user/1
  def update
    return if @user.nil?

    attr = params.require(:user).permit([:email, :display_name])

    if @user.update_attributes(attr)
      redirect_to admin_users_path,
                  notice: "User '#{@user.username}' was updated successfully",
                  float:  true
    else
      redirect_to edit_admin_user_path(@user),
                  alert: @user.errors.full_messages,
                  float: true
    end
  end

  # DELETE /admin/user/:id
  def destroy
    return if @user.nil?

    @user.update_activities!(current_user)
    @user.destroy!

    redirect_to admin_users_path,
                notice: "User '#{@user.username}' was removed successfully",
                float:  true
  end

  # PATCH/PUT /admin/user/1/toggle_admin
  def toggle_admin
    user = User.find(params[:id])

    if user == current_user
      render nothing: true, status: 403
    else
      user.toggle_admin!
      render template: "admin/users/toggle_admin", locals: { user: user }
    end
  end

  private

  def user_create_params
    permitted = [:username, :email, :password, :password_confirmation]
    params.require(:user).permit(permitted)
  end

  # Sets the @user instance variable if the current user is different from the
  # one specified in params[:id]. Moreover, if the current user is the same as
  # the targeted one, then a 403 response is rendered.
  def another_user_access
    @user = User.find(params[:id])
    return if !@user.nil? && @user != current_user

    @user = nil
    render nothing: true, status: 403
  end
end
