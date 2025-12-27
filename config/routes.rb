Books::Engine.routes.draw do
  resource :session
  resources :passwords, param: :token

  get "/sign_up", to: "users#new", as: :sign_up
  post "/sign_up", to: "users#create"

  resources :book_lists do
    resources :book_list_entries, as: "entries", only: [ :new, :create, :destroy ] do
      post :import, on: :collection
    end
  end

  root to: "book_lists#index"
end
