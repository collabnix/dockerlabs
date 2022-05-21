require "set"
require "pty"

module Portus
  # This class is the one responsible for generating new development data.
  class TestData
    # The number of users to be created.
    NUSERS = 100

    # Name of the only user that is not created with a random name.
    SPECIAL_USER = "admin".freeze

    # Teams to be created.
    TEAM_NAMES = [
      "bigdata",
      "containers",
      "dev",
      "hardware",
      "networking",
      "ops",
      "qa",
      "security",
      "sitereliability",
      "ui"
    ].freeze

    # Create some random users + the admin.
    def create_users!
      logins = Set.new

      while logins.size < NUSERS
        first_name  = FFaker::Name.first_name
        last_name   = FFaker::Name.last_name
        username    = "#{first_name[0]}#{last_name}".downcase

        next if username =~ /\W/ || username == SPECIAL_USER
        next if logins.include? username

        User.create!(
          username: username,
          password: "12341234",
          email:    "#{username}@portusexample.com"
        )
        logins << username
      end

      User.create!(
        username: SPECIAL_USER,
        password: "12341234",
        email:    "admin@portusexample.com",
        admin:    true
      )
    end

    # Create the needed teams. Each team will have between 5 to 20 members and
    # between 2 to 5 namespaces.
    def create_teams_and_namespaces!
      users = User.all

      TEAM_NAMES.each do |team|
        members = users.sample(rand(5..20))
        t = Team.create!(
          name:         team,
          owners:       members.pop(rand(1..4)),
          contributors: members.pop(rand(0..members.size)),
          viewers:      members
        )

        rand(2..5).times do
          name = FFaker::Food.ingredient.downcase.gsub(/[^#{Namespace::NAME_REGEXP}]/, "")
          name += rand(0..1000).to_s

          Namespace.create!(
            name:       name,
            team:       t,
            visibility: Namespace.visibilities.values.sample,
            registry:   Registry.get
          )
        end
      end
    end

    # Push images to the registry.
    def push_images!
      hostname = Registry.get.hostname

      `docker logout #{hostname}`
      `docker pull library/alpine:latest`

      puts "Pushing images. This could take a while..."

      namespaces = Namespace.all.sample(rand(User.count..Namespace.count))
      namespaces.each do |n|
        user = n.global? ? User.find_by(username: "admin") : n.team.owners.first
        name = user.username

        s = system("docker login -u #{name} -e #{name}@portusexample.com -p 12341234 #{hostname}")
        unless s
          puts "Could not log in!"
          exit 1
        end

        final = "#{hostname}/#{n.name}/alpine"
        `docker tag alpine:latest #{final}`
        `docker push #{final}`
        `docker rmi #{final}`
        `docker logout #{hostname}`
      end
    end
  end
end

#
# Initial checks.
#

if ARGV.size != 2
  puts <<HERE
usage: rails runner bin/generate_test_data.rb <hostname> <ssl>

Where <hostname> is the hostname of your private registry, and <ssl> is a
boolean that determines whether the registry is using SSL or not.

Also, note that the Docker daemon must be accessible from this machine and that
the user running this script must have the required privileges to interact with
it. If the Docker daemon is not running locally, use the `DOCKER_HOST`
environment variable.
HERE
  exit 1
end

hostname = ARGV.first.chomp
ssl = ARGV.last.chomp.downcase
ssl = ssl == "y" || ssl == "yes" || ssl == "t" || ssl == "true"

unless Rails.env.development?
  puts "You are not allowed to run this in '" + Rails.env + "'."
  exit 0
end

print "This will effectively wipe out your DB and feed it with some data that "\
  "is useful for development purposes.\nDo you really want to proceed with "\
  "this? (y/N) "
opt = $stdin.gets.chomp.downcase
exit 0 if opt != "y" && opt != "yes"

#
# Reset the DB.
#

require "database_cleaner"
DatabaseCleaner.clean_with :truncation
User.create!(
  username: "portus",
  password: Rails.application.secrets.portus_password,
  email:    "portus@portus.com",
  admin:    true
)

#
# Generate test data.
#

r = Registry.create!(name: "registry", hostname: hostname, use_ssl: ssl)
unless r.client.reachable?
  puts "The given registry is not reachable..."
  exit 1
end

td = Portus::TestData.new
ActiveRecord::Base.transaction do
  td.create_users!
  td.create_teams_and_namespaces!
end
td.push_images!
