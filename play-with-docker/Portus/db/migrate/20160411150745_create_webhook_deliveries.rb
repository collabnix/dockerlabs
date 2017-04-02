class CreateWebhookDeliveries < ActiveRecord::Migration
  def change
    create_table :webhook_deliveries do |t|
      t.references :webhook, index: true, foreign_key: true
      t.string :uuid
      t.integer :status
      t.text :request_header
      t.text :request_body
      t.text :response_header
      t.text :response_body

      t.timestamps null: false
    end

    add_index :webhook_deliveries, [:webhook_id, :uuid], unique: true
  end
end
