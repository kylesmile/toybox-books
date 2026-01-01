Books::Engine.routes.draw do
  resource :session
  resources :passwords, param: :token

  resource :account, only: %i[new create edit destroy]

  get "/terms_of_use", to: "legalese#terms_of_use"
  get "/privacy_policy", to: "legalese#privacy_policy"

  resources :book_lists do
    resources :book_list_entries, as: "entries", only: [ :new, :create, :destroy ] do
      post :import, on: :collection
    end

    resource :stats, only: :show
  end

  root to: "book_lists#index"
end
