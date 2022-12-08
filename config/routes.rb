Rails.application.routes.draw do

  get '/api/v1/items/find_all', to: 'search#index'
  get '/api/v1/merchants/find', to: 'merchants_search#show'

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        scope module: 'merchants' do
          resources :items, only: [:index]
        end
      end
      resources :items, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
