# ApplicationTokensController manages the creation/removal of application tokens
class ApplicationTokensController < ApplicationController
  respond_to :js

  # POST /application_tokens
  def create
    @plain_token = Devise.friendly_token

    @application_token = ApplicationToken.new(create_params)
    @application_token.user = current_user
    @application_token.token_salt = BCrypt::Engine.generate_salt
    @application_token.token_hash = BCrypt::Engine.hash_secret(
      @plain_token,
      @application_token.token_salt
    )

    if @application_token.save
      @application_token.create_activity!(:create, current_user)
      respond_with @application_token
    else
      respond_with @application_token.errors, status: :unprocessable_entity
    end
  end

  # DELETE /application_token/1
  def destroy
    @application_token = ApplicationToken.find(params[:id])
    @application_token.create_activity!(:destroy, current_user)
    @application_token.destroy

    respond_with @application_token
  end

  private

  def create_params
    permitted = [:application]
    params.require(:application_token).permit(permitted)
  end
end
