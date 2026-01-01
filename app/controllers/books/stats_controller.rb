# frozen_string_literal: true

module Books
  class StatsController < ApplicationController
    def show
      @book_list = Current.user.book_lists.find(params.expect(:book_list_id))
      @data = @book_list.stats.generate
    end
  end
end
