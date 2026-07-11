class CreateApplicationTokens < ActiveRecord::Migration
  def change
    create_table :application_tokens do |t|
      t.string :application, null: false
      t.string :token_hash, null:false
      t.string :token_salt, null:false
      t.integer :user_id, null:false
    end

    add_index :application_tokens, :user_id
  end
end
