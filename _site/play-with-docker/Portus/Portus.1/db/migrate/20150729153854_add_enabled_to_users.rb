class AddEnabledToUsers < ActiveRecord::Migration
  def change
    add_column :users, :enabled, :bool, default: true
  end
end
