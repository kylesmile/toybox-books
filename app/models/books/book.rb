module Books
  class Book < ApplicationRecord
    belongs_to :user
    has_many :book_list_entries, dependent: :destroy
    has_many :book_lists, through: :book_list_entries

    validates :title, presence: true
    validates :author, presence: true
    validates :title, uniqueness: { scope: [:author, :user_id] }
  end
end 