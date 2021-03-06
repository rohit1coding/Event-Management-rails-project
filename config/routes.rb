Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root to: 'home#index'
  root to:'events#index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'notifications', to: 'users#notifications'
  get 'mark_all_as_read', to: 'users#mark_all_as_read'
  get 'assigned_task', to:'users#assigned_task'
  resources :users
  # resources :events
  # resources :tasks

  resources :events do
    resources :tasks do
      get 'form_deadline', to: 'tasks#form_deadline'
      get 'is_completed', to: 'tasks#is_completed'
      get 'allocate', to: 'tasks#allocate'
      get 'deallocate_user', to: 'tasks#deallocate_user'
      get 'change', to: 'tasks#change'
      get 'self_assign', to: 'tasks#self_assign_task'
    end
    resources :expenses do 
      get 'allocate_task', to: 'expenses#allocate_task'
      get 'deallocate_task', to: 'expenses#deallocate_task'
    end
  end
end
