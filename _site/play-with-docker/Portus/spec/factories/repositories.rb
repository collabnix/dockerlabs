# == Schema Information
#
# Table name: repositories
#
#  id           :integer          not null, primary key
#  name         :string(255)      default(""), not null
#  namespace_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  marked       :boolean          default("0")
#
# Indexes
#
#  fulltext_index_repositories_on_name          (name)
#  index_repositories_on_name_and_namespace_id  (name,namespace_id) UNIQUE
#  index_repositories_on_namespace_id           (namespace_id)
#

FactoryGirl.define do
  factory :repository do
    sequence :name do |n|
      "repository#{n}"
    end

    trait :starred do
      stars { |t| [t.association(:star)] }
    end
  end
end
