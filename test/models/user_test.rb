require "test_helper"

module Books
  class UserTest < ActiveSupport::TestCase
    test "downcases and strips email_address" do
      user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
      assert_equal("downcased@example.com", user.email_address)
    end
  end
end
