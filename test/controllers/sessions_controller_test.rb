require "test_helper"

module Books
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    setup do
      host! "books.example.com"
      @user = User.take
    end

    test "new" do
      get books.new_session_path
      assert_response :success
    end

    test "create with valid credentials" do
      post books.session_path, params: { books_session: { email_address: @user.email_address, password: "password" } }

      assert_redirected_to books.root_path
      assert cookies[:session_id]
    end

    test "create with invalid credentials" do
      post books.session_path, params: { books_session: { email_address: @user.email_address, password: "wrong" } }

      assert_redirected_to books.new_session_path
      assert_nil cookies[:session_id]
    end

    test "destroy" do
      sign_in_as(User.take)

      delete books.session_path

      assert_redirected_to books.new_session_path
      assert_empty cookies[:session_id]
    end
  end
end
