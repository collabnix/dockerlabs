class AddUseSslToRegistries < ActiveRecord::Migration
  def change
    add_column :registries, :use_ssl, :boolean
  end
end
