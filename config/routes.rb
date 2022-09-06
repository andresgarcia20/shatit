require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  root "home#index"

  get "stats", to: "stats#index"
  get "my_requests", to: "trip_join_requests#show_my_requests"
  get "driver_requests", to: "driver_requests#index"

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
    resources :driver_requests, except: :index do
      resource :accepted_driver_request, only: :update
      resource :rejected_driver_request, only: :update
    end
    get "driver_requests", to: "driver_requests#my_driver_requests"
    resources :companions
    resources :vehicles
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, controllers: { sessions: "api/v1/users/sessions",
                                        registrations: "api/v1/users/registrations" }

      resource :users, only: [:create, :update, :destroy], controller: "/users"
      resources :trips, only: [:index]
      resources :trip_join_requests, only: [:index]
      resources :vehicles, only: [:index]
      resources :companions, only: [:index]
      resources :my_requests, only: [:index]
    end
  end
end
