
module Books
  class User < ApplicationRecord
    has_secure_password
    has_many :sessions, dependent: :destroy

    has_many :books, class_name: "Books::Book", dependent: :destroy
    has_many :book_lists, class_name: "Books::BookList", dependent: :destroy

    normalizes :email_address, with: ->(e) { e.strip.downcase }

    after_create :create_default_book_lists

    private

    def create_default_book_lists
      book_lists.create!(name: "To Read", list_type: "to_read")
      book_lists.create!(name: "Read", list_type: "read")
    end
  end
end
