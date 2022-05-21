class AddTeamReferenceToNamespace < ActiveRecord::Migration
  def change
    add_belongs_to :namespaces, :team, index: true
  end
end
