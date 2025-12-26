require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :playwright, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  setup do
    Capybara.always_include_port = true
    Capybara.app_host = "http://books.toybox.localhost"
  end
end
