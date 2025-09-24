module Books
  class BookListEntry < ApplicationRecord
    before_validation :find_existing_book
    after_create :broadcast_book_list_update

    belongs_to :book, class_name: "Books::Book"
    belongs_to :book_list, class_name: "Books::BookList"

    delegate :user, to: :book_list

    validates :book, presence: true
    validates :book_list, presence: true
    validates :read_at, presence: true, if: -> { book_list&.list_type == "read" }
    validates :book_id, uniqueness: { scope: :book_list_id }, if: -> { book_list&.list_type == "to_read" }

    validate :book_and_list_belong_to_same_user

    validates_associated :book

    def book=(attributes_or_instance)
      return super if attributes_or_instance.is_a?(Book)

      build_book(attributes_or_instance)
    end

    private

    def find_existing_book
      return unless new_record?

      existing_book = user.books.find_by(title: book.title, author: book.author)
      self.book = existing_book if existing_book
    end

    def book_and_list_belong_to_same_user
      return if book.nil? || book_list.nil?
      return if book.user_id == book_list.user_id

      errors.add(:base, "Book and book list must belong to the same user")
    end

    def broadcast_book_list_update
      Turbo.with_request_id(SecureRandom.uuid) do
        book_list.broadcast_refresh
      end
    end
  end
end
