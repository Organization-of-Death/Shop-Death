class MyinvenController < ApplicationController
  def main
    Market.connection
    User.connection
    Item.connection
    @all_market = Market.all
    @size =@all_market.length-1
   
   
    
  end
  def buy1
    puts 'saaaaaaa'
    asize =(params[:size].to_i)
    jesus = false
    for i in 0..asize do
    
      if (params["amount#{i}"] != nil and params["amount#{i}"] != "")
        jesus = true
        
        market = Market.find_by id: params["market_id#{i}"]
        market.stock -= params["amount#{i}"].to_i
        market.save
      end
    end
    if jesus
      redirect_to myinven_main_path, notice:'Buy successfully!' and return
    else
      redirect_to myinven_main_path, notice: 'Buy something first' and return
    end
  end
end
