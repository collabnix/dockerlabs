class AddHiddenToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :hidden, :boolean, default: false
  end
end
