# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  body          :text(65535)
#  repository_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#
# Indexes
#
#  index_comments_on_repository_id  (repository_id)
#  index_comments_on_user_id        (user_id)
#

FactoryGirl.define do
  factory :comment do
    sequence :body do |b|
      "a short comment #{b}"
    end

    association :author, factory: :user
  end
end
