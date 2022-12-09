class ItemController < ApplicationController
  before_action :must_logged_in_as_admin
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
    @enable = item.enable
    # @price = @item.price
    # @stock = @item.stock

  end

  def index
    @items = Item.all
    # puts '-indexjaaa'
  end

  def set_enable
    item = Item.find_by id: params['item_id']

    if item.update(enable: params['enable'].to_s)
      # index
      redirect_to item_index_path, notice: "Update success"
      return
    else
      redirect_to item_index_path, notice: "Update Error."
      return
    end
  end

  def show

  end

  private
  
  def set_item
    @item = Item.find(params[:id])
  end

end
