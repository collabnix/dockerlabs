
require "database_cleaner"

# DatabaseCleaner has been configured like this:
#
#   - The database gets truncated before starting the test suite.
#   - The cleaning strategy for the tests is by transaction, but tests dealing
#     with the UI have to go with truncation. This is a requirement from the
#     Poltergeist gem.

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.cleaning do
      factories_to_lint = FactoryGirl.factories.reject do |factory|
        factory.name =~ /raw_.*_event/
      end
      FactoryGirl.lint factories_to_lint
    end
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
