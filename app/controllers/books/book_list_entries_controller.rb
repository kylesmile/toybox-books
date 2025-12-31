require 'csv'

module Books
  class BookListEntriesController < ApplicationController
    before_action :set_book_list
    before_action :set_entry, only: [:destroy]

    def new
      @entry = @book_list.book_list_entries.build
      @entry.build_book(user: @book_list.user)
      render turbo_stream: turbo_stream.prepend("book_list", partial: "form")
    end

    def create
      @entry = @book_list.book_list_entries.build(entry_params)

      if @entry.save
        head :created
      else
        Rails.logger.info { @entry.errors.full_messages }
        render turbo_stream: turbo_stream.replace("new_book_list_entry", partial: "form")
      end
    end

    def import
      user = @book_list.user

      books_attributes = []
      book_list_entries_attributes = []

      CSV.foreach(params.expect(:import), headers: true) do |row|
        title = row['title']
        author = row['author']
        date = Time.zone.parse(row['date'])

        books_attributes << { title:, author: }
        book_list_entries_attributes << { read_at: date, title:, author: }
      end

      user.books.upsert_all(books_attributes, unique_by: %i[ title author user_id ])

      books_data = user.books.pluck(:author, :title, :id).to_h { [it[0..1], it[2]] }

      book_list_entries_attributes.each do |entry_attributes|
        author = entry_attributes.delete(:author)
        title = entry_attributes.delete(:title)
        book_id = books_data[[author, title]]
        entry_attributes[:book_id] = book_id
      end

      @book_list.book_list_entries.insert_all(book_list_entries_attributes)

      redirect_to book_list_path(@book_list)
    end

    def destroy
      @entry.destroy
      redirect_to book_list_path(@book_list)
    end

    private

    def set_book_list
      @book_list = Current.user.book_lists.find(params.expect(:book_list_id))
    end

    def set_entry
      @entry = @book_list.book_list_entries.find(params.expect(:id))
    end

    def entry_params
      params.expect(book_list_entry: [ :read_at, { book: [ :title, :author, :user_id ] } ])
    end
  end
end
