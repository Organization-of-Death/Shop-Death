class ShopController < ApplicationController
  def main
    @user = session[:username]
    Item.connection
    User.connection
    @name = Array.new
    @price = Array.new
    @stock = Array.new
    @seller = Array.new
    @id = Array.new
    @all_item = Item
    @all_item.all.each do |all_item|
      @id.push(all_item.id)
      @name.push(all_item.name)
      @price.push(all_item.price)
      @stock.push(all_item.stock)
      who = User.find_by id: all_item.User_id
      @seller.push(who.username)
    end
    @size = @name.size - 1
   
  end
  def item_manage
    Item.connection
    User.connection
    item = Item.find_by id: params['item_id']
    item.stock = item.stock - 1
    if item.stock < 0
      redirect_to shop_main_path, notice:'Item is out of stock'
    else
      item.save
      redirect_to controller:'main',action:'inventories',item_id: params['item_id']
    end
  end
end
