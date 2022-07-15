Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }
  root "home#index"
  resources :trips

  get "stats", to: "stats#index"

  resources :users do
    member do
      get "driver", to: "driver#index"
    end
    resources :vehicles
  end
end
