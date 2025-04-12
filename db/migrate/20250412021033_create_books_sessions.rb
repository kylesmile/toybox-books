class CreateBooksSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :books_sessions do |t|
      t.references :user, null: false, foreign_key: { to_table: :books_users }
      t.string :ip_address
      t.string :user_agent

      t.timestamps
    end
  end
end
