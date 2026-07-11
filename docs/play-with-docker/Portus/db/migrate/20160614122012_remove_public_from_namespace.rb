class RemovePublicFromNamespace < ActiveRecord::Migration
  def up
    remove_column :namespaces, :public, :boolean
  end

  def down
    add_column :namespaces, :public, :boolean
  end
end
