module Books
  class BookListsController < ApplicationController
    before_action :set_book_list, only: [:show, :destroy]
    before_action :ensure_not_default_list, only: [:destroy]

    def index
      @book_lists = Current.user.book_lists
    end

    def show
      @entries = @book_list.book_list_entries.order(read_at: :desc).includes(:book)
      @entry = @book_list.book_list_entries.build
      @entry.build_book(user: @book_list.user)
    end

    def new
      @book_list = Current.user.book_lists.build
    end

    def create
      @book_list = Current.user.book_lists.build(book_list_params)

      if @book_list.save
        redirect_to books_book_list_path(@book_list), notice: "Book list was successfully created."
      else
        render :new, status: :unprocessable_content
      end
    end

    def destroy
      @book_list.destroy
      redirect_to books_book_lists_path, notice: "Book list was successfully deleted."
    end

    private

    def set_book_list
      @book_list = Current.user.book_lists.find(params[:id])
    end

    def book_list_params
      params.require(:book_list).permit(:name, :list_type)
    end

    def ensure_not_default_list
      if @book_list.name.in?(["To Read", "Read"])
        redirect_to books_book_lists_path, alert: "Cannot delete default book lists."
      end
    end
  end
end
