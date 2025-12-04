module Books
  def self.table_name_prefix
    ""
  end

  class Engine < ::Rails::Engine
    isolate_namespace Books

    initializer "books.mount" do |app|
      app.routes.prepend do
        constraints subdomain: SUBDOMAIN do
          mount Books::Engine => "/"
        end
      end
    end

    initializer "books.host" do |app|
      app.config.hosts << "#{SUBDOMAIN}.#{app.config.root_host}"
    end

    initializer "books.assets.precompile" do |app|
      app.config.assets.precompile += %w( books/application.css )
    end
  end
end
