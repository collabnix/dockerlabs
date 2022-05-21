class WebhookHeaderPolicy < WebhookPolicy
  attr_reader :webhook_header

  def initialize(user, webhook_header)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user

    @user = user
    @webhook_header = webhook_header

    @webhook = webhook_header.webhook
    @namespace = @webhook.namespace
  end
end
