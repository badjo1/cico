Rails.application.routes.draw do
  

  get 'schedule/show'

  get 'password_resets/new'

  get 'password_resets/edit'

  root 'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'signup'  => 'venue_users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  resources :schedule, only: [:show] do 
    resources :events, only: [:show, :new, :create, :destroy]
    resources :space_entries, only: [:edit, :update]
    get ':unix', :to => 'schedule#show', as: 'on', :on => :member
  end

  resources :venues, only: [:new, :create, :current]
  resources :users, only: [:show, :edit, :update]
  resources :venue_users , only: [:index, :new, :create, :destroy] do
    get 'archived_events', :to => 'venue_users#archived_events', :on => :member
    get 'planned_events', :to => 'venue_users#planned_events', :on => :member
    get 'set_current', :to => 'venue_users#set_current', as: 'set_current', :on => :member
    get 'assign_role/:role', :to => 'venue_users#assign_role', as: 'assign_role' , :on => :member
    resources :account_activations, only: [:new]
  end
  resources :spaces

  resources :events, only: [:new, :create, :destroy, :edit, :update] do
    get 'ical' , :on => :member, :format => :ics
    resources :space_entries, only: [:new, :create]
    resources :frequencies, only: [:new, :create]
  end
  resources :space_entries, only: [:edit, :update, :destroy]
  resources :account_activations, only: [:edit, :update]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
end
