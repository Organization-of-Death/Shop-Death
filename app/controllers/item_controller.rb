class ItemController < ApplicationController
  before_action :set_item, only: %i[ show ]
  def new
    @User = params[:Username]
  end
  def edit
    @Item = params[:item_id]
    Item.connection
    item = Item.find_by id: params['item_id']

    @name = item.name
    @category = item.category
    # @price = @item.price
    # @stock = @item.stock

  end

  def index
    @items = Item.all
  end

  def show

  end

  private
  
  def set_item
    @item = Item.find(params[:id])
  end

end
