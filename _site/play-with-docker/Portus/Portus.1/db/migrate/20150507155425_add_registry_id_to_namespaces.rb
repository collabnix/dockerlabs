class AddRegistryIdToNamespaces < ActiveRecord::Migration
  def change
    add_belongs_to :namespaces, :registry, index: true
  end
end
