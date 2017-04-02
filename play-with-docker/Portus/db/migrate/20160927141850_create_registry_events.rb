class CreateRegistryEvents < ActiveRecord::Migration
  def change
    create_table :registry_events do |t|
      t.string :event_id, default: ""
      t.string :repository, default: ""
      t.string :tag, default: ""

      t.timestamps null: false
    end
  end
end
