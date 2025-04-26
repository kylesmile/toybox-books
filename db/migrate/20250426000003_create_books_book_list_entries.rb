class CreateBooksBookListEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :books_book_list_entries do |t|
      t.references :book, null: false, foreign_key: { to_table: :books_books }
      t.references :book_list, null: false, foreign_key: { to_table: :books_book_lists }
      t.datetime :read_at

      t.timestamps
    end

    add_index :books_book_list_entries, [:book_id, :book_list_id]
  end
end 