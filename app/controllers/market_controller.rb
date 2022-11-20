class MarketController < ApplicationController
  def index # for displaying /my_market
    @items = Item.all.select {|i| i.enable}

    whoare = User.find_by(username: session["username"]).id
    @markets = Market.where(seller_id: whoare).select {|m| m.is_enable}
  end

  def show
  end

  def new
    @item_for_new_market = Item.find(params[:item_id])
    
    # if admin has blocked
    if @item_for_new_market.enable == false
      redirect_to my_inventory_path, notice:'admin ห้ามขายแล้วจ้า ขอโทดน้า'
    end
  end

  def create
    # if not seller redirect to their home
    if session[:usertype] != 1
      redirect_to my_inventory_path, notice:'must be seller to add items for sell'
    end

    # if admin has blocked
    if Item.find(params[:item_id]).enable == false
      redirect_to my_inventory_path, notice:'admin ห้ามขายแล้วจ้า ขอโทดน้า'
      return
    end

    @market = Market.new(
      item_id: params[:item_id],
      price: params[:price].to_d,
      stock: params[:stock].to_i,
      seller_id: whoare = User.find_by(username: session["username"]).id
    )

    respond_to do |format|
      if @market.save
        format.html { redirect_to my_inventory_path, notice: "Market was successfully created." }
      else
        # format.html { render :index, status: :unprocessable_entity }
      end
    end

  end
  
  def edit
    @market = Market.find(params[:market_id])

    # if admin has blocked
    if @market.is_disable
      redirect_to my_inventory_path, notice:'admin ห้ามขายแล้วจ้า ขอโทดน้า'
      return
    end

    
  end

  def update
    @market = Market.find(params[:market_id])

    # if admin has blocked
    if @market.is_disable
      redirect_to my_inventory_path, notice:'admin ห้ามขายแล้วจ้า ขอโทดน้า'
      return
    end

    respond_to do |format|
      if @market.update(price: params[:price].to_d, stock: params[:stock].to_i)
        format.html { redirect_to my_inventory_path, notice: "Market was successfully updated." }
      else
        # format.html { render :index, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    puts 'in destroy'
    puts params.to_s

    @market = Market.find(params[:id])
    # if admin has blocked
    if @market.is_disable
      redirect_to my_inventory_path, notice:'admin ห้ามขายแล้วจ้า ขอโทดน้า'
      return
    end

    @market.destroy
    redirect_to my_inventory_path, notice: "Market was successfully destroyed."
  end

  

end
