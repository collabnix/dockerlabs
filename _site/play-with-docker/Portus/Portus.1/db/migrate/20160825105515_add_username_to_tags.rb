class AddUsernameToTags < ActiveRecord::Migration
  def change
    add_column :tags, :username, :string
  end
end
