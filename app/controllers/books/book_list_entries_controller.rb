module Books
  class BookListEntriesController < ApplicationController
    before_action :set_book_list
    before_action :set_entry, only: [:destroy]

    def new
      @entry = @book_list.book_list_entries.build
      @entry.build_book(user: @book_list.user)
      render turbo_stream: turbo_stream.prepend("book_list_table", partial: "form")
    end

    def create
      @entry = @book_list.book_list_entries.build(entry_params)

      if @entry.save
        head :created
      else
        Rails.logger.info { @entry.errors.full_messages }
        render turbo_stream: turbo_stream.replace("new_book_list_entry_row", partial: "form")
      end
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
      params.expect(book_list_entry: [:read_at, { book: [:title, :author, :user_id] }])
    end
  end
end
