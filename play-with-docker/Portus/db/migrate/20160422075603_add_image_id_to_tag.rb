class AddImageIdToTag < ActiveRecord::Migration
  def change
    add_column :tags, :image_id, :string, default: ""
  end
end
