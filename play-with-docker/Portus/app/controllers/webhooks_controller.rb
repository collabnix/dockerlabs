# WebhooksController manages the creation/removal/update of webhooks.
# Also, it manages their state, i.e. enabled/disabled.
class WebhooksController < ApplicationController
  respond_to :html, :js

  before_action :set_namespace
  before_action :set_webhook, only: [:update, :show, :destroy, :toggle_enabled]

  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: :index

  # GET /namespaces/1/webhooks
  # GET /namespaces/1/webhooks.json
  def index
    authorize @namespace
    @webhooks = policy_scope(Webhook).where(namespace: @namespace).page(params[:page])

    respond_with(@namespace, @webhooks)
  end

  # POST /namespaces/1/webhooks
  # POST /namespaces/1/webhooks.json
  def create
    @webhook = @namespace.webhooks.build(webhook_params)
    authorize @webhook

    if @webhook.save
      @webhook.create_activity :create, owner: current_user
      respond_with @namespace, @webhook
    else
      respond_with @webhook.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /namespaces/1/webhooks/1/1
  # PATCH/PUT /namespaces/1/webhooks/1/1.json
  def update
    authorize @webhook

    if @webhook.update(webhook_params)
      @webhook.create_activity :update, owner: current_user
      respond_with @namespace, @webhook
    else
      respond_with @webhook.errors, status: :unprocessable_entity
    end
  end

  # GET /namespaces/1/webhooks/1
  # GET /namespaces/1/webhooks/1.json
  def show
    authorize @webhook

    @deliveries = @webhook.deliveries.page(params[:page])
    respond_with(@namespace, @webhook)
  end

  # DELETE /namespaces/1/webhooks/1
  # DELETE /namespaces/1/webhooks/1.json
  def destroy
    authorize @webhook

    @webhook.create_activity :destroy, owner: current_user
    @webhook.destroy

    respond_with @namespace, @webhook
  end

  # PATCH/PUT /namespace/1/webhooks/1/toggle_enabled
  def toggle_enabled
    authorize @webhook
    @webhook.update_attribute(:enabled, !@webhook.enabled?)

    if @webhook.enabled?
      @webhook.create_activity :enabled, owner: current_user
    else
      @webhook.create_activity :disabled, owner: current_user
    end

    render template: "webhooks/toggle_enabled", locals: { namespace: @namespace, webhook: @webhook }
  end

  private

  def set_namespace
    @namespace = Namespace.find(params[:namespace_id])
  end

  def set_webhook
    @webhook = @namespace.webhooks.find(params[:id])
  end

  def webhook_params
    params.require(:webhook).permit(:url, :request_method, :content_type, :username, :password)
  end
end
