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

class Comment < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :repository
  belongs_to :author, class_name: "User", foreign_key: "user_id"

  validates :body, presence: true

  # Returns true if the user is the author of the comment
  def author?(user)
    user_id == user.id
  end
end
