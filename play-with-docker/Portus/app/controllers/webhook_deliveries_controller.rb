# WebhookDeliveriesController manages the updates of webhook deliveries.
class WebhookDeliveriesController < ApplicationController
  respond_to :html, :js

  after_action :verify_authorized

  # PATCH/PUT /namespaces/1/webhooks/1/deliveries/1
  def update
    namespace = Namespace.find(params[:namespace_id])
    webhook = namespace.webhooks.find(params[:webhook_id])
    webhook_delivery = webhook.deliveries.find(params[:id])

    authorize webhook_delivery

    webhook_delivery.retrigger
    render template: "webhooks/retrigger", locals: { webhook_delivery: webhook_delivery }
  end
end
