# Adding the Portus user.

if User.count > 0
  Rails.logger.fatal "The DB is not empty! Only seed for kick-starting your DB"
  exit(-1)
end

Rails.logger.info "Adding the \"portus\" user"
User.create!(
  username: "portus",
  password: Rails.application.secrets.portus_password,
  email:    "portus@portus.com",
  admin:    true
)

# Adding a user and a registry for integration tests.
if ENV["INTEGRATION_TESTS"]
  Rails.logger.info "Adding user username31"
  if User.find_by_username("username31")
    Rails.logger.fatal "User already exists. Please drop the database first"
    exit(-1)
  end

  User.create(
    username: "username31",
    email:    "a1@b.com",
    password: "test-password",
    admin:    true
  )

  Rails.logger.info "Adding registry portus.suse.example.com:5000"
  Registry.create(
    name:     "portus.suse.example.com:5000",
    hostname: "portus.suse.example.com:5000"
  )
end
