class CreateWebhooks < ActiveRecord::Migration
  def change
    create_table :webhooks do |t|
      t.references :namespace, index: true, foreign_key: true
      t.string :url
      t.string :username
      t.string :password
      t.integer :request_method
      t.integer :content_type
      t.boolean :enabled, default: false

      t.timestamps null: false
    end
  end
end
