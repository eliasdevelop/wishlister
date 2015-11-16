Wishlister::Application.routes.draw do
  root "sessions#new"

  resources :users
  resources :wishes

  get '/sessions/callback', to: "sessions#callback"
end
