
require "capybara/rails"
require "capybara/rspec"
require "capybara/poltergeist"

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    js_errors:         false,
    phantomjs_options: ["--load-images=no"]
  )
end

Capybara.javascript_driver = :poltergeist

Capybara.configure do |config|
  config.javascript_driver = :poltergeist
  config.default_wait_time = 5
  config.match = :one
  config.exact_options = true
  config.ignore_hidden_elements = true
  config.visible_text_only = true
  config.default_selector = :css
end
