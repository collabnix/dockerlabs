# CatalogJob is a job that synchronizes the contents of the database with the
# contents of the registries. This is done by using the Catalog API.
class CatalogJob < ActiveJob::Base
  # This method will be called on each tic of the cron. It basically goes
  # through all the registries and calls `update_registry!` for each of them.
  # Any error will be logged.
  def perform
    Registry.find_each do |registry|
      begin
        cat = registry.client.catalog

        # Update the registry in a transaction, since we don't want to leave
        # the DB in an unknown state because of an update failure.
        ActiveRecord::Base.transaction { update_registry!(cat) }
      rescue StandardError => e
        Rails.logger.warn "Exception: #{e.message}"
      end
    end
  end

  protected

  # This method updates the database of this application with the given
  # registry contents.
  def update_registry!(catalog)
    dangling_repos = Repository.all.pluck(:id)

    # In this loop we will create/update all the repos from the catalog.
    # Created/updated repos will be removed from the "repos" array.
    catalog.each do |r|
      if r["tags"].blank?
        Rails.logger.debug "skip upload not finished repo #{r["name"]}"
      else
        repository = Repository.create_or_update!(r)
        dangling_repos.delete repository.id unless repository.nil?
      end
    end

    # At this point, the remaining items in the "repos" array are repos that
    # exist in the DB but not in the catalog. Remove all of them.
    portus = User.find_by(username: "portus")
    Tag.where(repository_id: dangling_repos).find_each { |t| t.delete_and_update!(portus) }
    Repository.where(id: dangling_repos).find_each { |r| r.delete_and_update!(portus) }
  end
end
