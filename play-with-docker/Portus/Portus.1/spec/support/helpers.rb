
# A simple module containing some helper methods for acceptance tests.
module Helpers
  # Login the given user and visit the root url.
  def login(user)
    login_as user, scope: :user
    visit root_url
  end

  # Returns a String containing the id of the currently active element.
  def focused_element_id
    page.evaluate_script("document.activeElement.id")
  end

  # Returns a boolean regarding whether the given selector matches an element
  # that is currently disabled.
  def disabled?(selector)
    page.evaluate_script("$('#{selector}').attr('disabled')") == "disabled"
  end

  # Creates the Portus user. The Portus user cannot be created with neither the
  # "user" factory nor the "admin" one. This is because in the application this
  # same user is created in a special way (directly, without associating a
  # namespace to it, etc.).
  def create_portus_user!
    User.create!(
      username: "portus",
      password: Rails.application.secrets.portus_password,
      email:    "portus@portus.com",
      admin:    true
    )
  end
end

RSpec.configure { |config| config.include Helpers, type: :feature }
