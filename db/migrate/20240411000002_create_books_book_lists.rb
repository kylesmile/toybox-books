class CreateBooksBookLists < ActiveRecord::Migration[7.1]
  def change
    create_table :books_book_lists do |t|
      t.string :name, null: false
      t.string :list_type, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :books_book_lists, [:name, :user_id], unique: true
  end
end 