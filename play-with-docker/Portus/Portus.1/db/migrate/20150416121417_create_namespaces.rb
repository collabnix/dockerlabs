class CreateNamespaces < ActiveRecord::Migration
  def change
    create_table :namespaces do |t|
      t.string :name, default: nil

      t.timestamps null: false
    end
    add_index :namespaces, :name, unique: true
  end
end
