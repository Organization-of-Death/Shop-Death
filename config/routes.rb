Rails.application.routes.draw do
  get 'topseller/main'
  post 'topseller/main'
  post 'topseller/organ'
  
  get 'my_market', to: 'myinven#main', as: 'my_market_main'
  # post 'my_market'
  post 'my_market/buy1', to: 'myinven#buy1'
  # get 'my_market/buy1'
  
  get '/purchase_history', to: 'myinven#purchase_history'

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
  post 'item/set_enable', to: 'item#set_enable', as: 'set_enable'

  get 'my_inventory', to: 'market#index', as: 'my_inventory'
  get 'my_inventory/new', to: 'market#new', as: 'new_my_inventory'
  post 'my_inventory/create', to: 'market#create', as: 'create_my_inventory'
  get 'my_inventory/edit', to: 'market#edit', as: 'edit_my_inventory'
  post 'my_inventory/update', to: 'market#update', as: 'update_my_inventory'
  delete 'my_inventory/destroy/:id', to: 'market#destroy', as: 'destroy_my_inventory'
  # get 'market/show'

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
