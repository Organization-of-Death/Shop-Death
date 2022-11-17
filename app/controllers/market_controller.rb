class MarketController < ApplicationController
  def index # for displaying /my_market
    @items = Item.all
    @markets = Market.all
  end

  def show
  end

  def new
    @items = Item.all
    @markets = Market.all

    @item_for_new_market = Item.find(params[:item_id])
  end

  def create
    # if not seller redirect to their home
    puts 'in create ja'
    if session[:usertype] != 1
      redirect_to my_market_path, notice:'must be seller to add items for sell'
    end

    

    @market = Market.new(
      item_id: params[:item_id],
      price: params[:price].to_d,
      stock: params[:stock].to_i,
      seller_id: whoare = User.find_by(username: session["username"]).id
    )

    respond_to do |format|
      if @market.save
        puts 'save success ja'
        format.html { redirect_to my_market_path, notice: "Market was successfully created." }
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end

  end
  
  def edit
  end

  def update
  end

  def destroy
  end

end
