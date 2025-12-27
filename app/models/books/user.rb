
module Books
  class User < ApplicationRecord
    has_secure_password
    has_many :sessions, dependent: :destroy

    has_many :books, class_name: "Books::Book", dependent: :destroy
    has_many :book_lists, class_name: "Books::BookList", dependent: :destroy

    normalizes :email_address, with: ->(e) { e.strip.downcase }

    after_create :create_default_book_lists

    validate :allow_beta_access, on: :create

    private

    def create_default_book_lists
      book_lists.create!(name: "To Read", list_type: "to_read")
      book_lists.create!(name: "Read", list_type: "read")
    end

    def allow_beta_access
      allowed_beta_email = ENV.fetch("BOOKS_BETA_EMAIL", "example.com")
      return if email_address.ends_with?("@#{allowed_beta_email}")

      attempted_domain = email_address.split("@").last
      errors.add(:beta_access, "Sign ups are not enabled for #{attempted_domain} emails during beta")
    end
  end
end
