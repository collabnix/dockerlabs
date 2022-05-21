class CreateRegistries < ActiveRecord::Migration
  def change
    create_table :registries do |t|
      t.string :name, null: false
      t.string :hostname, null: false

      t.timestamps null: false
    end
    add_index :registries, :name, unique: true
    add_index :registries, :hostname, unique: true
  end
end
