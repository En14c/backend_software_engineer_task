Rails.application.routes.draw do
  root to: 'application#app_root'

  namespace :api do
    namespace :v1 do
      resources :recipes, only: [:index, :search] do
        get "search", to: :search, on: :collection
      end
    end
  end
end
