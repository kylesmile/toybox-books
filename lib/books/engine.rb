module Books
  def self.table_name_prefix
    ""
  end

  class Engine < ::Rails::Engine
    isolate_namespace Books
    initializer "books.assets.precompile" do |app|
      app.config.assets.precompile += %w( books/application.css )
    end
  end
end
