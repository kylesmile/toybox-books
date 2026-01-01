require "test_helper"

module Books
  class BookListStatsTest < ActiveSupport::TestCase
    test "generates yearly stats for a book list" do
      user = books_users(:one)
      book_list = books_book_lists(:user_one_read)

      # Two books read in 2024
      book_list.book_list_entries.create!(
        book: {
          user_id: user.id,
          title: "The Hobbit",
          author: "J.R.R. Tolkien"
        },
        read_at: "2024-03-01"
      )
      book_list.book_list_entries.create!(
        book: {
          user_id: user.id,
          title: "The Fellowship of the Ring",
          author: "J.R.R. Tolkien"
        },
        read_at: "2024-04-01"
      )

      # Three books read in 2025 (including 1 re-read)
      book_list.book_list_entries.create!(
        book: {
          user_id: user.id,
          title: "Prince Caspian",
          author: "C.S. Lewis"
        },
        read_at: "2025-03-01"
      )
      book_list.book_list_entries.create!(
        book: {
          user_id: user.id,
          title: "The Red House Mystery",
          author: "A. A. Milne"
        },
        read_at: "2025-03-15"
      )
      book_list.book_list_entries.create!(
        book: {
          user_id: user.id,
          title: "The Hobbit",
          author: "J.R.R. Tolkien"
        },
        read_at: "2025-04-01"
      )

      stats = BookList::Stats.new(book_list)
      assert_equal stats.generate, [
        [ 2024, 2 ],
        [ 2025, 3 ]
      ]
    end
  end
end
