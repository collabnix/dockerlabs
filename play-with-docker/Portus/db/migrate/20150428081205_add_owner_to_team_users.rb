class AddOwnerToTeamUsers < ActiveRecord::Migration
  def change
    add_column :team_users, :owner, :boolean, default: false
  end
end
