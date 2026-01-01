module Books
  class BookList < ApplicationRecord
    broadcasts_refreshes

    belongs_to :user, class_name: "Books::User"
    has_many :book_list_entries, class_name: "Books::BookListEntry", dependent: :destroy
    has_many :books, class_name: "Books::Book", through: :book_list_entries

    validates :name, presence: true
    validates :list_type, presence: true
    validates :name, uniqueness: { scope: :user_id }

    enum :list_type, read: "read", to_read: "to_read"

    def stats
      Stats.new(self)
    end
  end
end
