Rails.application.routes.draw do
  namespace :api do
    resources :authors do
      resources :books, only: [ :index ]
    end

    resources :publishers do
      resources :books, only: [ :index ]
    end

   resources :books, only: [ :index, :show, :create, :update, :destroy ] do
      collection do
        get "search"
        get "validate_isbn"
      end
    end
  end
end
