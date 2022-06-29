Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  resources :trips
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users do
    resources :vehicles
  end
end
