module Books
  class ApplicationController < ActionController::Base
    include Books::Authentication
  end
end
