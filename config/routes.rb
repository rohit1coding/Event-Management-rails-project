Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root to: 'home#index'
  root to:'events#index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  #Events
  # get 'events', to:'events#index'
  # get 'events/new', to: 'events#new'

  resources :users
  resources :events
end
