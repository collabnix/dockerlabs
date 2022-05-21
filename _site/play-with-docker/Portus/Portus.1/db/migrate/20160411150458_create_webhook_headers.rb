class CreateWebhookHeaders < ActiveRecord::Migration
  def change
    create_table :webhook_headers do |t|
      t.references :webhook, index: true, foreign_key: true
      t.string :name
      t.string :value

      t.timestamps null: false
    end

    add_index :webhook_headers, [:webhook_id, :name], unique: true
  end
end
