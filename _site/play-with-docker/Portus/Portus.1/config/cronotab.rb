require "portus/migrate"

env = ENV["CATALOG_CRON"] || 10
value = Portus::Migrate.from_humanized_time(env, 10)
Crono.perform(CatalogJob).every value
