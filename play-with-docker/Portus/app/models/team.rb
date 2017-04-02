# == Schema Information
#
# Table name: teams
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  hidden      :boolean          default("0")
#  description :text(65535)
#
# Indexes
#
#  index_teams_on_name  (name) UNIQUE
#

class Team < ActiveRecord::Base
  include PublicActivity::Common
  include SearchCop

  search_scope :search do
    attributes :name, :description
  end

  # Returns all the teams that are not special. By special team we mean:
  #   - It's the global namespace (see: Registry#create_namespaces!).
  #   - It's a personal namespace (see: User#create_personal_namespace!).
  #
  # Right now, all the special namespaces are simply marked as hidden.
  scope :all_non_special, -> { where(hidden: false) }

  validates :name, presence: true, uniqueness: true
  validates :owners, presence: true
  has_many :namespaces

  has_many :team_users
  has_many :users, through: :team_users
  has_many :owners, -> { merge TeamUser.owner },
    through: :team_users, source: :user
  has_many :contributors, -> { merge TeamUser.contributor },
    through: :team_users, source: :user
  has_many :viewers, -> { merge TeamUser.viewer },
    through: :team_users, source: :user

  # Returns all the member-IDs
  def member_ids
    team_users.pluck(:user_id)
  end

  # Returns all teams whose name match the query
  def self.search_from_query(valid_teams, query)
    all_non_special.where(id: valid_teams).where(arel_table[:name].matches(query))
  end
end
