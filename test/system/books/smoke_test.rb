require "application_system_test_case"

module Books
  class SmokeTest < ApplicationSystemTestCase
    test "sign up" do
      visit books.root_path
      click_on "Sign up"

      assert_link "Sign in"
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "password"
      fill_in "Confirm password", with: "password"
      check "I agree"

      click_on "Sign up"

      assert_text "Account created successfully"
      assert_link "To Read"
      assert_link "Read"

      click_on "Read"
      assert_text "No books in this list yet"
    end

    class WhenSignedIn < SmokeTest
      setup do
        @user = User.take

        visit books.root_path

        fill_in "Email", with: @user.email_address
        fill_in "Password", with: "password"
        click_on "Sign in"
      end

      test "Read list" do
        click_on "Read"
        assert_text "No books in this list yet"

        click_on "Add"
        fill_in "Date Read", with: "2025-02-02"
        fill_in "Title", with: "The Hobbit"
        fill_in "Author", with: "J.R.R. Tolkien"
        click_on "Save"

        assert_button "Remove"
        assert_text "The Hobbit"
        assert_text "J.R.R. Tolkien"
        assert_text "Feb 02, 2025"

        click_on "Remove"
        click_on "Yes, I'm sure"
        refute_text "The Hobbit"
        refute_text "J.R.R. Tolkien"
        refute_text "Feb 02, 2025"
      end

      test "To Read list" do
        click_on "To Read"

        refute_text "Date Read"

        click_on "Add"
        refute_field "Date Read"

        fill_in "Title", with: "The Hobbit"
        fill_in "Author", with: "J.R.R. Tolkien"
        click_on "Save"
        assert_button "Remove"
        assert_text "The Hobbit"
        assert_text "J.R.R. Tolkien"

        click_on "Remove"
        click_on "Yes, I'm sure"
        refute_text "The Hobbit"
        refute_text "J.R.R. Tolkien"
      end
    end
  end
end
