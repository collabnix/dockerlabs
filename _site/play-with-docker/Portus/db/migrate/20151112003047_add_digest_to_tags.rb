class AddDigestToTags < ActiveRecord::Migration
  def change
    add_column :tags, :digest, :string
  end
end
