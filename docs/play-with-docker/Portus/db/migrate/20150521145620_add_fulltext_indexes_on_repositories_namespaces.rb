class AddFulltextIndexesOnRepositoriesNamespaces < ActiveRecord::Migration
  def change
    add_index :namespaces, :name, type: :fulltext, name: 'fulltext_index_namespaces_on_name'
    add_index :repositories, :name, type: :fulltext, name: 'fulltext_index_repositories_on_name'
  end
end
