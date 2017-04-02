class AddMarkedToRepositoriesAndTags < ActiveRecord::Migration
  def change
    add_column :repositories, :marked, :boolean, default: false
    add_column :tags, :marked, :boolean, default: false
  end
end
