module Books
  class BookList < ApplicationRecord
    belongs_to :user
    has_many :book_list_entries, dependent: :destroy
    has_many :books, through: :book_list_entries

    validates :name, presence: true
    validates :list_type, presence: true
    validates :name, uniqueness: { scope: :user_id }

    enum :list_type, read: 'read', to_read: 'to_read'
  end
end 