require "test_helper"

module Books
  class UserTest < ActiveSupport::TestCase
    test "downcases and strips email_address" do
      user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
      assert_equal("downcased@example.com", user.email_address)
    end

    test "sets up default book lists on create" do
      user = User.new(email_address: "user@example.com", password: "password")
      user.save!
      assert_equal(user.book_lists.order(:name).pluck(:name), ["Read", "To Read"])
    end
  end
end
