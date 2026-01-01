# frozen_string_literal: true

module Books
  class BookList
    class Stats
      attr_reader :book_list

      def initialize(book_list)
        @book_list = book_list
      end

      def generate
        book_list
          .book_list_entries
          .group('extract(year from "book_list_entries"."read_at")')
          .order(Arel.sql('extract(year from "book_list_entries"."read_at")'))
          .pluck(Arel.sql('extract(year from "book_list_entries"."read_at")::int'), Arel.sql('count("book_list_entries"."id")'))
      end
    end
  end
end
