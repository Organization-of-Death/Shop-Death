class MarketController < ApplicationController
  def index # for displaying /my_market
    @items = Item.all
    @markets = Market.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
