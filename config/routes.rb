Rails.application.routes.draw do
  root "top#index"
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'users/search/:key', to: 'users#index'
  resources :users do
    member do
      get :likes
    end
  end
  post '/users/:id', to: 'users#update'#patchをpostでやるため
  get '/users/:id/image', to: 'users#edit_image'
  patch '/users/:id/image', to: 'users#update_image'
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  post '/password_resets/:id', to: 'password_resets#update'
  resources :books, only: [:show, :create, :update, :destroy, :index]
  get '/books/search/:id', to: 'books#search'
  resources :likes, only: [:create, :destroy]
  resources :book_comments, only: [:destroy]
  post '/book_comments/:id', to: 'book_comments#update'
end
