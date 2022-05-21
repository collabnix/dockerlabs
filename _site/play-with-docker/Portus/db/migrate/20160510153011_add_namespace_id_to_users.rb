class AddNamespaceIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :namespace, index: true, foreign_key: true, default: nil
  end
end
