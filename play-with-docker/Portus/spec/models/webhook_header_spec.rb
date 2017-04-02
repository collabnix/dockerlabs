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

require "rails_helper"

RSpec.describe WebhookHeader, type: :model do
  subject { create(:webhook_header, webhook: create(:webhook)) }

  it { should belong_to(:webhook) }
  it { should validate_uniqueness_of(:name).scoped_to(:webhook_id) }
end
