class MyinvenController < ApplicationController
  def main
    Market.connection
    User.connection
    Item.connection
    @all_market = Market.all
    @size =@all_market.length-1
    Inventory.connection
   
   
    
  end
  def buy1

    puts 'saaaaaaa'
    asize =(params[:size].to_i)
    jesus = false
    for i in 0..asize do
    
      if (params["amount#{i}"] != nil and params["amount#{i}"] != "")
        jesus = true
        
        market = Market.find_by id: params["market_id#{i}"]
        puts 'dddddddddddddddddddddd'
        puts market.stock
        if( market.stock - params["amount#{i}"].to_i <= 0)
          redirect_to myinven_main_path, notice:'Buy Unsuccesfully, please refresh page' and return
        
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
    
      redirect_to myinven_main_path, notice:'Buy successfully!' and return
    else
      redirect_to myinven_main_path, notice: 'Buy something first' and return
    end
  end
end
