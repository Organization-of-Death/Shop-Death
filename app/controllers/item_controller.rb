class ItemController < ApplicationController
  before_action :must_logged_in_as_admin
  before_action :set_item, only: %i[ show ]
  def new
    @User = params[:Username]
  end
  def edit
    @Item = params[:item_id]
    Item.connection
    @item = Item.find_by id: params['item_id']

    @name = @item.name
    @category = @item.category
    @enable = @item.enable
    @lock_version = @item.lock_version
    # @price = @item.price
    # @stock = @item.stock

  end

  def index
    @items = Item.all
    # puts '-indexjaaa'
  end

  def set_enable
    item = Item.find_by id: params['item_id']
    if item.nil?
      redirect_to item_index_path, notice: "The item no longer existed" and return
    end

    # check first if the lock_version is okay, otherwise notify the admin of the updated value
    if item.lock_version == params[:lock_version].to_i
      item.update(enable: params['enable'].to_s)
      redirect_to item_index_path, notice: "Update success"
      return
    else
      redirect_to item_index_path, notice: "Update Error. Other admins are also editing, please check the updated value first"
      return
    end
  end

  def show

  end

  private
  
  def set_item
    @item = Item.find_by id:params[:id]
    if @item.nil?
      redirect_to item_index_path, notice: "The item no longer existed"
    end
  end

end
