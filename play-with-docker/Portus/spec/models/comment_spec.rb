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

require "rails_helper"

describe Comment do
  it { should belong_to(:repository) }
  it { should belong_to(:author) }

  it "has a valid factory" do
    expect { Factory.build(:comment).to be_valid }
  end
end
