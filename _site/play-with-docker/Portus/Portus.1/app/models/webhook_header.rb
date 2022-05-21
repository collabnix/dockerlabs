# == Schema Information
#
# Table name: webhook_headers
#
#  id         :integer          not null, primary key
#  webhook_id :integer
#  name       :string(255)
#  value      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_webhook_headers_on_webhook_id           (webhook_id)
#  index_webhook_headers_on_webhook_id_and_name  (webhook_id,name) UNIQUE
#

# A WebhookHeader is a key value pair, and describes a HTTP header which is
# to be included in a webhook request.
class WebhookHeader < ActiveRecord::Base
  belongs_to :webhook

  validates :name, uniqueness: { scope: :webhook_id }
end
