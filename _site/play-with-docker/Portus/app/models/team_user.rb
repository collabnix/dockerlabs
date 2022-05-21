# == Schema Information
#
# Table name: team_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role       :integer          default("0")
#
# Indexes
#
#  index_team_users_on_team_id  (team_id)
#  index_team_users_on_user_id  (user_id)
#

# Class describing a member of a team
#
# Meaning of the role column:
#   * viewer: has RO access to the namespaces associated with the team
#   * contributor: has RW access to the namespaces associated with the team
#   * owner: like contributor, but can also manage the team
class TeamUser < ActiveRecord::Base
  enum role: [:viewer, :contributor, :owner]

  scope :enabled, -> { joins(:user).merge(User.enabled).distinct }
  scope :owner, -> { where(role: roles[:owner]) }
  scope :contributor, -> { where(role: roles[:contributor]) }
  scope :viewer, -> { where(role: roles[:viewer]) }

  validates :team, presence: true
  validates :user, presence: true, uniqueness: { scope: :team }

  belongs_to :team
  belongs_to :user

  # Create the activity regarding this team member. If no parameters are
  # specified, then it's assumed: { role: role }.
  def create_activity!(type, owner, parameters = nil)
    params = parameters ? parameters.merge(role: role) : { role: role }
    team.create_activity type, owner: owner, recipient: user, parameters: params
  end

  # Returns all team IDs which are manageable by one user
  def self.get_valid_team_ids(id)
    owner.where(user_id: id).pluck(:team_id)
  end

  # Returns true if the member of this team is the only owner of it.
  def only_owner?
    team.owners.exists?(user.id) && team.owners.count == 1
  end
end
