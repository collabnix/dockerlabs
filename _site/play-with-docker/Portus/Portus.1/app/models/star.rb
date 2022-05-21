# == Schema Information
#
# Table name: stars
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  repository_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_stars_on_repository_id  (repository_id)
#  index_stars_on_user_id        (user_id)
#

class Star < ActiveRecord::Base
  belongs_to :repository
  belongs_to :user

  validates :repository, presence: true
  validates :user, presence: true, uniqueness: { scope: :repository }
end
