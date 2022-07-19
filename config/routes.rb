Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  root "home#index"

  get "stats", to: "stats#index"

  resources :trips do
    resources :trip_join_requests
  end

  resources :users do
    member do
      get "driver", to: "driver#index"
    end
    resources :vehicles
  end
end
