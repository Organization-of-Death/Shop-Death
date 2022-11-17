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
        format.html { redirect_to my_market_path, notice: "Market was successfully created." }
      else
        # format.html { render :index, status: :unprocessable_entity }
      end
    end

  end
  
  def edit
    @market = Market.find(params[:market_id])
  end

  def update
    @market = Market.find(params[:market_id])

    respond_to do |format|
      if @market.update(price: params[:price].to_d, stock: params[:stock].to_i)
        format.html { redirect_to my_market_path, notice: "Market was successfully updated." }
      else
        # format.html { render :index, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    puts 'in destroy'
    puts params.to_s

    @market = Market.find(params[:id])
    @market.destroy
    redirect_to my_market_path, notice: "Market was successfully destroyed."
    
  end

end
