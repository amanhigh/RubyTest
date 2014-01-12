RubyTest::Application.routes.draw do
  root to: 'pages#home'
  match '/contact', to: 'pages#contact', via: 'get'
  match '/help', to: 'pages#help', via: 'get'
  match '/about', to: 'pages#about', via: 'get'

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :sessions, :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
end
