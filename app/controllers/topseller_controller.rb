class TopsellerController < ApplicationController
  before_action do
    must_logged_in_as_one_of [0, 1] # must be roles admin(0), or seller(1) to access
  end

  def main
    Inventory.connection
    User.connection
    Item.connection
    Market.connection
    dp = Array.new(10000,0) #by money made
    ap = Array.new(10000,0) #by quantity 
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
      dp[sort[i].seller_id] += sort[i].qty * sort[i].price
      ap[sort[i].seller_id] += sort[i].qty
    end 
    newdp = dp.sort {|x, y| y <=> x} # sort descending

    @listtopbyPrice = Array.new
    @listtopPrice = Array.new
    if (dp.max()>0 ) #need everyone to show 
      @topsellername = "down below"
      @num = ""
      i = 0
      while newdp[i]>0 do
        topseller = User.find_by id: dp.rindex(newdp[i])
        @listtopbyPrice.push(topseller)
        @listtopPrice.push(newdp[i])
        dp[dp.rindex(newdp[i])] = 0; # in case someone have the same sold total 
        i+=1
      end
    else
      @topsellername = 'no record yet'
      @num = 0
    end
    
    newap = ap.sort {|x, y| y <=> x} # sort descending
    @listtopbyQuantity = Array.new
    @listtopQuantity = Array.new
    # puts 'sssssssss'
    if(ap.max()>0)
      @topsellername2 = "down below"
      @num2 = ""
      i = 0
      while newap[i]>0 do
        topseller = User.find_by id: ap.rindex(newap[i])
        @listtopbyQuantity.push(topseller)
        @listtopQuantity.push(newap[i])
        ap[ap.rindex(newap[i])] = 0; # in case someone have the same sold total 
        i+=1
      end
    else 
      @topsellername2 = 'no record yet'
      @num2 = 0
    end
    # puts ap.max()
    # puts 'sssssssssssssss'
    
  end
  def organ
    redirect_to controller: 'topseller', action: 'main', start: params[:start], end:params[:end]
  end
end
