class AddGlobalFlagToNamespaces < ActiveRecord::Migration
  def change
    add_column :namespaces, :global, :boolean, default: false
  end
end
