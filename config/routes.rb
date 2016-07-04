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
  resources :venue_users , only: [:index, :show, :new, :create, :destroy] do
    get 'archive', :to => 'venue_users#archive', :on => :member
    get 'set_current', :to => 'venue_users#set_current', as: 'set_current', :on => :member
  end
  resources :spaces
  resources :space_entries, only: [:edit, :update]
  resources :events, only: [:new, :create, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  


end
