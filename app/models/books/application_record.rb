module Books
  class ApplicationRecord < ApplicationRecord
    self.abstract_class = true

    connects_to shards: {
      books: { writing: :books, reading: :books }
    }
  end
end
