rails_env = new_resource.environment["RAILS_ENV"]
secret_key = new_resource.environment["SECRET_KEY_BASE"]
Chef::Log.info("Precompiling assets for RAILS_ENV=#{rails_env}...")
execute "rake assets:precompile" do
  cwd release_path
  command "bundle exec rake assets:precompile"
  environment "RAILS_ENV" => rails_env
  environment "SECRET_KEY_BASE" => secret_key
end
