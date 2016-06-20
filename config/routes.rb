Rails.application.routes.draw do
  

  root 'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'signup'  => 'venue_users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  #get    'book(/:unix)'   => 'venues#show' , as: 'book'
  match 'book(/:unix)' => 'venues#show', via: [:get, :post], as: 'book'

  get    'bookedspaces'   => 'venues#booked'
  
  get    'schedule/day(/:unix)'   => 'venues#day'
  get    'schedule/week(/:unix)'   => 'venues#week', as: 'schedule_week'
  

  resources :users, only: [:show, :edit, :update]
  resources :venue_users , only: [:index, :show, :new, :create, :destroy]
  resources :spaces
  resources :space_entries, only: [:edit, :update]
  resources :events, only: [:new, :create]


end
