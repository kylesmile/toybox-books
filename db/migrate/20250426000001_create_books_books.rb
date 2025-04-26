class CreateBooksBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books_books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.references :user, null: false, foreign_key: { to_table: "books_users" }

      t.timestamps
    end

    add_index :books_books, [:title, :author, :user_id], unique: true
  end
end
