module Books
  class BookListEntriesController < ApplicationController
    before_action :set_book_list
    before_action :set_entry, only: [:destroy]

    def new; end

    def create
      @entry = @book_list.book_list_entries.build(entry_params)

      if @entry.save
        redirect_to book_list_path(@book_list)
      else
        @entries = @book_list.book_list_entries.includes(:book)
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @entry.destroy
      redirect_to books_book_list_path(@book_list)
    end

    private

    def set_book_list
      @book_list = Current.user.book_lists.find(params.expect(:book_list_id))
    end

    def set_entry
      @entry = @book_list.book_list_entries.find(params.expect(:id))
    end

    def entry_params
      params.expect(book_list_entry: [:read_at, { book: [:title, :author] }])
    end
  end
end
