class FixIndexNameOnRepositories < ActiveRecord::Migration
  def change
    remove_index :repositories, column: :name
    add_index :repositories, [:name, :namespace_id], unique: true
  end
end
