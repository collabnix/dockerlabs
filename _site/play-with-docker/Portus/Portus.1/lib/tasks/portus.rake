require "pty"

# Spawn a new command and return its exit status. It will print to stdout on
# real time.
def spawn_cmd(cmd)
  status = 0

  PTY.spawn(cmd) do |stdout, _, pid|
    # rubocop:disable Lint/HandleExceptions
    begin
      stdout.each { |line| print line }
    rescue Errno::EIO
      # End of output
    end
    # rubocop:enable Lint/HandleExceptions

    Process.wait(pid)
    status = $CHILD_STATUS.exitstatus
  end
  status
end

namespace :portus do
  desc "Create the account used by Portus to talk with Registry's API"
  task create_api_account: :environment do
    User.create!(
      username: "portus",
      password: Rails.application.secrets.portus_password,
      email:    "portus@portus.com",
      admin:    true
    )
  end

  desc "Create a registry"
  task :create_registry, [:name, :hostname, :use_ssl, :external] => :environment do |_, args|
    if args.count != 3 && args.count != 4
      puts "There are 3 required arguments and an optional one"
      exit(-1)
    end

    args.each do |k, v|
      if v.empty? && k != :external
        puts "You have to provide a value for `#{k}'"
        exit(-1)
      end
    end

    if Registry.count > 0
      puts "There is already a registry configured!"
      exit(-1)
    end

    registry = Registry.new(
      name:              args[:name],
      hostname:          args[:hostname],
      use_ssl:           args[:use_ssl],
      external_hostname: args[:external]
    )
    msg = registry.reachable?
    unless msg.empty?
      puts "\nRegistry not reachable:\n#{registry.inspect}\n#{msg}\n"
      exit(-1)
    end
    registry.save
  end

  desc "Create a user"
  task :create_user, [:username, :email, :password, :admin] => :environment do |_, args|
    if args.count != 4
      puts "There are 4 required arguments"
      exit(-1)
    end

    args.each do |k, v|
      if v.empty?
        puts "You have to provide a value for `#{k}'"
        exit(-1)
      end
    end

    unless Registry.any?
      puts <<HERE

ERROR: There is no registry on the DB! You can either call the portus:create_registry
task, or log in as an administrator into Portus and fill in the form that
will be presented to you.
HERE
      exit(-1)
    end

    u = User.create!(
      username: args["username"],
      password: args["password"],
      email:    args["email"],
      admin:    args["admin"]
    )

    if u.username != u.namespace.name
      puts <<HERE

NOTE: the user you just created contained characters that are not accepted for
naming namespaces. Because of this, you've got the following:

  * User name: '#{u.username}'
  * Personal namespace: '#{u.namespace.name}'
HERE
    end
  end

  desc "Give 'admin' role to a user"
  task :make_admin, [:username] => [:environment] do |_, args|
    unless args[:username]
      puts "Specify a username, as in"
      puts " rake portus:make_admin[username]"
      puts "valid usernames are"
      puts User.pluck(:username).to_s
      exit(-1)
    end
    u = User.find_by_username(args[:username])
    if u.nil?
      puts "#{args[:username]} not found in database"
      puts "valid usernames are"
      puts User.pluck(:username).to_s
      exit(-2)
    end
    u.admin = true
    u.save
    if u.nil?
      puts "Sorry something went wrong and I couldn't set this user as admin."
      exit(-3)
    end
  end

  desc "Update the manifest digest of tags"
  task :update_tags, [:update] => [:environment] do |_, args|
    # Warning
    puts <<HERE
This rake task may take a while depending on how many images have been stored
in your private registry. If you are running this in production it's
recommended that the registry is running in "readonly" mode, so there are no
race conditions with concurrent accesses.

HERE

    unless ENV["PORTUS_FORCE_DIGEST_UPDATE"]
      print "Are you sure that you want to proceed with this ? (y/N) "
      opt = $stdin.gets.strip
      exit 0 if opt != "y" && opt != "Y" && opt != "yes"
    end

    # Fetch the tags to be updated.
    update = args[:update] == "true" || args[:update] == "t"
    tags = if update
      Tag.all
    else
      Tag.where("tags.digest='' OR tags.image_id=''")
    end

    # Some information on the amount of tags to be updated.
    if tags.empty?
      puts "There are no tags to be updated."
      exit 0
    else
      puts "Updating a total of #{tags.size} tags..."
    end

    # And for each tag fetch its digest and update the DB.
    client = Registry.get.client
    tags.each_with_index do |t, index|
      repo_name = t.repository.name
      puts "[#{index + 1}/#{tags.size}] Updating #{repo_name}/#{t.name}"

      begin
        id, digest, = client.manifest(t.repository.full_name, t.name)
        t.update_attributes(digest: digest, image_id: id)
      rescue StandardError => e
        puts "Could not get the manifest for #{repo_name}: #{e.message}"
      end
    end
    puts
  end

  desc "Properly test Portus"
  task :test do |_, args|
    tags = args.extras.map { |a| "--tag #{a}" }
    tags << "--tag ~integration" if ENV["TRAVIS"] == "true"

    # Run normal tests + integration.
    ENV["INTEGRATION_LDAP"] = nil
    status = spawn_cmd("rspec spec #{tags.join(" ")}")
    exit(status) if status != 0
    exit(0) if ENV["TRAVIS"] == "true"

    # Run LDAP integration tests.
    ENV["INTEGRATION_LDAP"] = "t"
    tags << "--tag integration" unless args.extras.include?("integration")
    status = spawn_cmd("rspec spec #{tags.join(" ")}")
    exit(status)
  end
end
