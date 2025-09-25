Books::Engine.routes.draw do
  resources :passwords, param: :token
  resource :session

  resources :book_lists do
    resources :book_list_entries, as: "entries", only: [ :new, :create, :destroy ] do
      post :import, on: :collection
    end
  end

  root to: "book_lists#index"
end
