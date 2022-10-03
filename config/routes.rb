Rails.application.routes.draw do
  get 'welcome', to: 'welcome#index'
  root to: 'welcome#index'

  get 'register', to: 'registrations#new'
  post 'register', to: 'registrations#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  namespace 'api' do
    namespace 'v1' do
      post 'login', to: 'sessions#create'
      post 'register', to: 'registrations#create'
      resources :containers, only: [:index]
    end
  end

  resources :containers, only: [:new, :create, :index, :show] do
    member do
      patch 'store_container', to: 'containers#store_container'
    end
  end
end
