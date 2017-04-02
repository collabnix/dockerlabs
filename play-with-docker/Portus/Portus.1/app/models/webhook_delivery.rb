# == Schema Information
#
# Table name: webhook_deliveries
#
#  id              :integer          not null, primary key
#  webhook_id      :integer
#  uuid            :string(255)
#  status          :integer
#  request_header  :text(65535)
#  request_body    :text(65535)
#  response_header :text(65535)
#  response_body   :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_webhook_deliveries_on_webhook_id           (webhook_id)
#  index_webhook_deliveries_on_webhook_id_and_uuid  (webhook_id,uuid) UNIQUE
#

# A WebhookDelivery is created once a webhook has been triggered. They hold
# information regarding both the request and the response.  Webhook deliveries
# can also be retrigged.
class WebhookDelivery < ActiveRecord::Base
  belongs_to :webhook

  validates :uuid, uniqueness: { scope: :webhook_id }

  # success? returns whether or not the request was successful (status 200).
  def success?
    status == 200
  end

  # Retrigger a webhook unconditionally.
  def retrigger
    args = {
      method:  webhook.request_method,
      headers: webhook.process_headers,
      body:    JSON.generate(JSON.load(request_body)),
      timeout: 60,
      userpwd: webhook.process_auth
    }

    request = Typhoeus::Request.new(webhook.url, args)

    request.on_complete do |response|
      update_attributes status:          response.response_code,
                        response_header: response.response_headers,
                        response_body:   response.response_body
      # update `updated_at` field
      touch
    end

    request.run
  end
end
