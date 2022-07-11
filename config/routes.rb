Rails.application.routes.draw do
  get "driver", to: "driver#index"
  devise_for :users, controllers: { sessions: "users/sessions" }
  root "home#index"
  resources :trips

  resources :users do
    resources :vehicles
  end
end
