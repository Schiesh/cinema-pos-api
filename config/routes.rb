Rails.application.routes.draw do
  get "themes/show"
  get "themes/update"
  resource :theme, only: [:show, :update]
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
    resources :screenings, shallow: true do
      resources :tickets, shallow: true do
        member do
          post :book
        end
      end
    end
  end
end
