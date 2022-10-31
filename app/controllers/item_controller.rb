class ItemController < ApplicationController
  def new
    @User = params[:Username]
  end
  def edit
    @Item = params[:item_id]
    Item.connection
    item = Item.find_by id: params['item_id']
    @name = item.name
    @price = item.price
    @stock = item.stock

  end

end
