Rails.application.routes.draw do

  root 'gossip#index', as: '/home'

  get 'welcome/:welcome_user', to: 'welcome#welcome_user'

  get 'comments/:id/edit', to: 'comments#edit', as: 'edit/comment'
  post 'comments/create', to: 'comments#create'
  put 'comments/:id', to: 'comments#update', as: 'update/comment'
  delete 'comments/:id', to: 'comments#destroy', as: 'destroy/comment'

 
  resources :likes, only: [:create, :destroy]
  
  resources :sessions, only: [:new, :create, :destroy]

  resources :team

  resources :gossip

  resources :users

  resources :cities
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end