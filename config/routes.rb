Rails.application.routes.draw do
  get 'profile/main'
  post 'profile/main'
  root 'main#welcome'
  #root 'main#login'
  post 'profile/password'

  get 'main/home'
  post 'main/home'
  post 'main/log_out'
  post 'shop/item_manage'
  get 'shop/main'
  post 'shop/main'
  get 'main/inventories'
  post 'main/inventories'
  get 'item/new'
  get 'item/edit'
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
