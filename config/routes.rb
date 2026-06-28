Rails.application.routes.draw do
  get "users/index"
  get "users/show"
  get "users/create"
  get "users/update"
  get "users/destroy"
  get "auth/login"
  get "auth/pin_login"
  get "site_settings/show"
  get "site_settings/update"
  get "themes/show"
  get "themes/update"
  
  resources :users

  namespace :auth do
    post :login
    post :pin_login
    post :register
    post :customer_login
    get :me
  end

  resource :theme, only: [:show, :update]
  resource :site_settings, only: [:show, :update]
  resources :screens do
    resource :seat_map, only: [:show, :create, :update] do
      resources :seat_map_rows, only: [:create] do
        resources :seats, only: [:update], shallow: true
      end
    end
  end

  resources :seat_map_rows, only: [:update, :destroy]
  resources :seats, only: [:update]

  resources :movies do
    collection do
      get :now_showing
      get :coming_soon
    end
    resources :screenings, shallow: true do
      resources :tickets, shallow: true do
        member do
          post :book
        end
      end
    end
  end
end
