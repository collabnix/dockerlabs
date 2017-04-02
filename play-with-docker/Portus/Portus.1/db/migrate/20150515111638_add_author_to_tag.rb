class AddAuthorToTag < ActiveRecord::Migration
  def change
    add_belongs_to :tags, :user, index: true
  end
end
