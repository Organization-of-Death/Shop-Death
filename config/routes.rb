Rails.application.routes.draw do
  get 'profile/main'
  post 'profile/main'
  root 'main#welcome'
  #root 'main#login'
  post 'profile/password'

  get 'user/main'
  post 'user/user_manage'
  get 'user/user_manage'
  get 'user/edit'
  get 'user/new'

  get 'main/home'
  post 'main/home'
  post 'main/log_out'
  post 'shop/item_manage'
  get 'shop/main'
  post 'shop/main'
  get 'main/inventories'
  post 'main/inventories'

  get 'item', to: 'item#index', as: 'item_index'
  get 'item/new', as: 'new_item'
  get 'item/edit', as: 'edit_item'
  get 'item/:id', to: 'item#show', as: 'show_item'

  get 'main/login'
  post 'main/login'
  get 'main/user_item'
  post 'main/user_item'
  post 'main/register'
  get 'main/register'
  post 'main/user_manage'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
