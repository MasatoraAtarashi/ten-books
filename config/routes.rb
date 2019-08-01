Rails.application.routes.draw do
  root "top#index"
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  post 'users/:id', to: 'users#update'#あとでRESTfulに直す
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  post 'password_resets/:id', to: 'password_resets#update'
end
