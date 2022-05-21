
# Theoretically, Capybara is clever enough to wait for asynchronous events to
# happen (e.g. AJAX). Sadly, this is not always true. For more, read:
#
#   https://robots.thoughtbot.com/automatically-wait-for-ajax-with-capybara
#
# Therefore, we add some methods for waiting that will be used for these
# corner cases. All the public methods respect a timeout of
# `Capybara.default_wait_time`.
module WaitForEvents
  # Wait for all the AJAX requests to have concluded.
  def wait_for_ajax
    wait_until_zero("jQuery.active")
  end

  # Wait for all the effects on the given selector to have concluded.
  def wait_for_effect_on(selector)
    wait_until_zero("$('#{selector}').queue().length")
  end

  # This method will loop until the given block evaluates to true. It will
  # respect to default timeout as specifyied by Capybara.
  def wait_until
    Timeout.timeout(Capybara.default_wait_time) do
      loop until yield
    end
  end

  private

  # Wait until the given JS snippet evaluates to zero. This is done while
  # respecting the set `Capybara.default_wait_time` timeout.
  def wait_until_zero(js)
    wait_until { page.evaluate_script(js).zero? }
  end
end

RSpec.configure do |config|
  config.include WaitForEvents, type: :feature
end
