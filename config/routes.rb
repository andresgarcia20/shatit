require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }
  mount Sidekiq::Web => "/sidekiq"

  root "home#index"

  get "stats", to: "stats#index"
  get "my_requests", to: "trip_join_requests#show_my_requests"

  resources :trips do
    resource "end_trip", only: :update
    resources :trip_join_requests do
      resources :checkouts, only: [:index, :update, :new] do
        get "payment_receipt", on: :collection
      end
      member do
        resource :accepted, only: :update
        resource :payment_failed, only: :update
        resource :payment_in_progress, only: :update
        resource :paid, only: :update
        resource :canceled, only: :update
        resource :rejected, only: :update
      end
    end
  end

  resources :users do
    member do
      get "driver", to: "driver#index"
    end
    resources :companions
    resources :vehicles
  end
end
