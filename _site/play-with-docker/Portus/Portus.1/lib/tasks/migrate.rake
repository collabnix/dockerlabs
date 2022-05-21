# :nocov:
namespace :migrate do
  # NOTE: this is only available from 2.0.x -> 2.1.x.
  # TODO: (mssola) prevent in the future to execute this if the version of
  # Portus is higher than 2.1.x. (should be deprecated in 2.2, and removed later
  # on).
  desc "Update personal namespaces"
  task update_personal_namespaces: :environment do
    ActiveRecord::Base.transaction do
      User.all.find_each do |u|
        namespace = Namespace.find_by(name: u.username)
        raise "There is no valid personal namespace for #{u.username}!" if namespace.nil?
        u.update_attributes(namespace: namespace)
      end
    end
  end

  # NOTE: this is only available from 2.0.x -> 2.1.x.
  # TODO: (mssola) prevent in the future to execute this if the version of
  # Portus is higher than 2.1.x. (should be deprecated in 2.2, and removed later
  # on).
  desc "Update LDAP user names"
  task update_ldap_names: :environment do
    unless APP_CONFIG.enabled?("ldap")
      puts "This only applies to LDAP setups..."
      exit 0
    end

    puts "Users to be updated:"
    count = 0
    User.all.find_each do |u|
      if !u.ldap_name.blank? && u.ldap_name != u.username
        puts "- username: #{u.username}\t<=>\tldapname: #{u.ldap_name}"
        count += 1
      end
    end

    if count == 0
      puts "None. Doing nothing..."
      exit 0
    end

    unless ENV["PORTUS_FORCE_LDAP_NAME_UPDATE"]
      print "Are you sure that you want to proceed with this ? (y/N) "
      opt = $stdin.gets.strip
      exit 0 if opt != "y" && opt != "Y" && opt != "yes"
    end

    ActiveRecord::Base.transaction do
      User.all.find_each do |u|
        if !u.ldap_name.blank? && u.ldap_name != u.username
          u.update_attributes!(username: u.ldap_name)
        end
      end
    end
  end
end
# :nocov:
