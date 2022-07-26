Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  root "home#index"

  get "stats", to: "stats#index"

  resources :trips do
    resources :trip_join_requests do
      member do
        patch "accepted", to: "accepted#update"
        put "accepted", to: "accepted#update"
        patch "payment_in_progress", to: "payment_in_progress#update"
        put "payment_in_progress", to: "payment_in_progress#update"
        patch "paid", to: "paid#update"
        put "paid", to: "paid#update"
        patch "canceled", to: "canceled#update"
        put "canceled", to: "canceled#update"
        patch "rejected", to: "rejected#update"
        put "rejected", to: "rejected#update"
      end
    end
  end

  resources :users do
    member do
      get "driver", to: "driver#index"
    end
    resources :vehicles
  end
end
