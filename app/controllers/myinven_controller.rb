# this class handles the /my_market routes && purchase_history
# but handles the Inventory Model

class MyinvenController < ApplicationController
  before_action only: [:main, :buy1, :purchase_history] do
    must_logged_in_as_one_of [0, 2] # must be roles admin(0), or buyer(2) to access
  end

  before_action only: [:sale_history] do
    must_logged_in_as_one_of [0, 1] # must be roles admin(0), or buyer(2) to access
  end

  def main  # this is for /my_market page
    Market.connection
    User.connection
    Item.connection
    @all_market = Market.all.select {|m| m.is_enable}
    @size =@all_market.length-1
    Inventory.connection
   
   
    
  end
  def buy1

    # puts 'saaaaaaa'
    asize =(params[:size].to_i)
    jesus = false
    for i in 0..asize do
    
      if (params["amount#{i}"] != nil and params["amount#{i}"] != "")
        jesus = true
        
        market = Market.find_by id: params["market_id#{i}"]
        # puts 'dddddddddddddddddddddd'
        # puts market.stock
        if( market.stock - params["amount#{i}"].to_i < 0)
          redirect_to my_market_main_path, notice:'Buy Unsuccesfully, please refresh page' and return
        
        end
        market.stock -= params["amount#{i}"].to_i
        market.save
        inven = Inventory.new
        market = Market.find_by id: params["market_id#{i}"]
        inven.item_id =  market.item_id
        inven.price = market.price
        inven.qty = params["amount#{i}"].to_i
        iid =User.find_by username:session[:username]
        inven.buyer_id = iid.id
        inven.seller_id = market.seller_id
        inven.save

      end
    end
    if jesus
    
      redirect_to my_market_main_path, notice:'Buy successfully!' and return
    else
      redirect_to my_market_main_path, notice: 'Buy something first' and return
    end
  end

  def purchase_history
    whoare = User.find_by(username: session["username"]).id
    if (session[:usertype] == 2) # for buyer view
      @inventories = Inventory.where(buyer_id: whoare)
    elsif (session[:usertype] == 0) # for admin view
      @inventories = Inventory.all
    end
  end

  def sale_history
    whoare = User.find_by(username: session["username"]).id
    if (session[:usertype] == 1) # for seller view
      @inventories = Inventory.where(seller_id: whoare)
    elsif (session[:usertype] == 0) # for admin view
      @inventories = Inventory.all
    end
  end

end
