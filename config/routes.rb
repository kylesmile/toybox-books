Books::Engine.routes.draw do
  resources :passwords, param: :token
  resource :session

  root to: "sessions#new"
end
