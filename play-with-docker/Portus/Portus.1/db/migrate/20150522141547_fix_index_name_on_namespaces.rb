class FixIndexNameOnNamespaces < ActiveRecord::Migration
  def change
    remove_index :namespaces, column: :name
    add_index :namespaces, [:name, :registry_id], unique: true
  end
end
