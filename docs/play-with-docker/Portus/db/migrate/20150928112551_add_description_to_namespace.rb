class AddDescriptionToNamespace < ActiveRecord::Migration
  def change
    add_column :namespaces, :description, :text
  end
end
