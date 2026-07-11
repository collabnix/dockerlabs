class AddIndexOnTagNameRepositoryId < ActiveRecord::Migration
  def change
    add_index :tags, [:name, :repository_id], unique: true
  end
end
