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

require "rails_helper"

describe Star do

  it { should belong_to(:repository) }
  it { should belong_to(:user) }

  it "validates that a user does not star the same repository twice" do
    author = create(:user)
    repository = create(:repository)

    expect { FactoryGirl.create(:star, user: author, repository: repository) }.not_to raise_error
    expect do
      FactoryGirl.create(:star, user: author, repository: repository)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

end
