class RemoveOwnerIdFromTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :owner_id, :integer
  end
end
