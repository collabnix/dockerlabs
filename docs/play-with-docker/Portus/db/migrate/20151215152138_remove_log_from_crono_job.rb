class RemoveLogFromCronoJob < ActiveRecord::Migration
  def change
    remove_column :crono_jobs, :log, :text
  end
end
