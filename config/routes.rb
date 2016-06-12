Rails.application.routes.draw do
  
  get 'venue_users/new'

  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'signup'  => 'venue_users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users, only: [:show, :edit, :update]
  resources :venue_users , only: [:index, :show, :new, :create, :destroy]

end
