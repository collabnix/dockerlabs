# WebhookHeadersController manages the creation/removal of webhook headers.
class WebhookHeadersController < ApplicationController
  respond_to :html, :js

  before_action :set_namespace
  before_action :set_webhook

  after_action :verify_authorized

  # POST /namespaces/1/webhooks/1/headers
  # POST /namespaces/1/webhooks/1/headers.json
  def create
    @webhook_header = @webhook.headers.build(webhook_header_params)
    authorize @webhook_header

    if @webhook_header.save
      respond_with @namespace, @webhook, @webhook_header
    else
      respond_with @webhook_header.errors, status: :unprocessable_entity
    end
  end

  # DELETE /namespaces/1/webhooks/1/headers/1
  # DELETE /namespaces/1/webhooks/1/headers/1.json
  def destroy
    @webhook_header = @webhook.headers.find(params[:id])

    authorize @webhook_header

    @webhook_header.destroy
    respond_with @namespace, @webhook, @webhook_header
  end

  private

  def set_namespace
    @namespace = Namespace.find(params[:namespace_id])
  end

  def set_webhook
    @webhook = @namespace.webhooks.find(params[:webhook_id])
  end

  def webhook_header_params
    params.require(:webhook_header).permit(:name, :value)
  end
end
