class RemoveIndexOnLdapUsers < ActiveRecord::Migration
  def change
    remove_index "users", name: "index_users_on_ldap_name"
  end
end
