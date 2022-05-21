class AddVisibilityToNamespace < ActiveRecord::Migration
  def up
    add_column :namespaces, :visibility, :integer
  end

  def down
    remove_column :namespaces, :visibility, :integer
  end
end
