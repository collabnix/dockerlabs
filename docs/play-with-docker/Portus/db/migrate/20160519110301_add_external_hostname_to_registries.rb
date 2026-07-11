class AddExternalHostnameToRegistries < ActiveRecord::Migration
  def change
    add_column :registries, :external_hostname, :string
  end
end
