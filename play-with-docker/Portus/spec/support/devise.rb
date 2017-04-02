
# Setup devise for tests.
RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include Devise::TestHelpers, type: :helper

  # Needed for methods such as `login_as`.
  config.include Warden::Test::Helpers
  config.before(:suite) { Warden.test_mode! }
end
