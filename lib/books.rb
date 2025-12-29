require "books/version"
require "books/subdomain"
require "books/engine"

module Books
  GUEST_INFO = {
    public: true,
    title: "Books",
    description: "A simple reading tracker that isn't a social network.",
    source_url: "https://github.com/kylesmile/toybox-books"
  }.freeze
end
