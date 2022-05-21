# == Schema Information
#
# Table name: registry_events
#
#  id         :integer          not null, primary key
#  event_id   :string(255)      default(""), not null
#  repository :string(255)      default("")
#  tag        :string(255)      default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# RegistryEvent represents an event coming from the Registry. This model stores
# events that are being handled by Portus or that have been handled before. This
# way we avoid duplication of registry events
class RegistryEvent < ActiveRecord::Base
end
