class TopsellerController < ApplicationController
  def main
    Inventory.connection
    User.connection
    Item.connection
    Market.connection
    dp = Array.new(1000,0)
    ap = Array.new(1000,0)
    all_inven = Inventory.all
    @show = false
    if(params[:start] != nil )
      sort = all_inven.where(created_at: params[:start]..params[:end])
      @show = true
    else
      sort = all_inven.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
      @show = false
    end
      long = (sort.length) - 1
    for i in 0..long do
      ap[sort[i].seller_id] += sort[i].qty * sort[i].price
      dp[sort[i].seller_id] += sort[i].qty
    end 
    puts dp.max()
    if (dp.max()>0 )
      topseller = User.find_by id: dp.rindex(dp.max)
      @topsellername = topseller.username
      @num = dp.max()
    else
      @topseller = no record yet
      @num = 0
    end
    if(ap.max()>0)
      topseller2 = User.find_by id: ap.rindex(ap.max)
      @topsellername2 = topseller2.username
      @num2 = ap.max()
    else 
      @topseller2 = no record yet
      @num2 = 0
    end

    puts 'sssssssssssssss'
    
  end
  def organ
    redirect_to controller: 'topseller', action: 'main', start: params[:start], end:params[:end]
  end
end
