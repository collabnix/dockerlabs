class WebhookDeliveryPolicy < WebhookPolicy
  attr_reader :webhook_delivery

  def initialize(user, webhook_delivery)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user

    @user = user
    @webhook_delivery = webhook_delivery

    @webhook = webhook_delivery.webhook
    @namespace = @webhook.namespace
  end
end
