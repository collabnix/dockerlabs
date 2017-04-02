class AddAuthorToComment < ActiveRecord::Migration
  def change
    add_belongs_to :comments, :user, index: true
  end
end
