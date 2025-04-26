module Books
  class Book < ApplicationRecord
    belongs_to :user, class_name: "Books::User"
    has_many :book_list_entries, class_name: "Books::BookListEntry", dependent: :destroy
    has_many :book_lists, class_name: "Books::BookList", through: :book_list_entries

    validates :title, presence: true
    validates :author, presence: true
    validates :title, uniqueness: { scope: [:author, :user_id] }
  end
end
