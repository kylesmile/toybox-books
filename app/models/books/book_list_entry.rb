module Books
  class BookListEntry < ApplicationRecord
    belongs_to :book
    belongs_to :book_list

    validates :book, presence: true
    validates :book_list, presence: true
    validates :read_at, presence: true, if: -> { book_list&.list_type == "read" }
    validates :book_id, uniqueness: { scope: :book_list_id }, if: -> { book_list&.list_type == "to_read" }

    validate :book_and_list_belong_to_same_user

    private

    def book_and_list_belong_to_same_user
      return if book.nil? || book_list.nil?
      return if book.user_id == book_list.user_id

      errors.add(:base, "Book and book list must belong to the same user")
    end
  end
end 