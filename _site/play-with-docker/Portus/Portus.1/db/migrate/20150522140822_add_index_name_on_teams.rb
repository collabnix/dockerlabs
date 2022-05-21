class AddIndexNameOnTeams < ActiveRecord::Migration
  def change
    add_index :teams, :name, unique: true
  end
end
