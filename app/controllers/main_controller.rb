class MainController < ApplicationController
  def login
  end
  def user_item
    a = 'sa'
    #testing
    if params['commit'] == 'Login'
      User.connection
      puts 'aaaaaaaaaaaaaaaaaaaa'
      neware = User.new
      whoare = User.find_by username: params["username"]
      if whoare == nil
        redirect_to main_login_path, notice:'This username is not exist'
      else 
        if whoare.password != params["password"]
          redirect_to main_login_path, notice:'Wrong password or username!'
        else #normal case
          @Name = whoare.username
          @Username = whoare.username
          session[:username] = whoare.username
          Item.connection
          User.connection
          whoare = User.find_by username: params["username"]
          @all_item = Item.where(User_id: whoare)
        
          @size =  (@all_item.size-1)
        
        end
      end
    elsif params['commit'] == 'Register'
      User.connection
      puts 'aaaaaaaaaaaaaaaaaaaa'
      neware = User.new
      whoare = User.find_by username: params["username"]
      if whoare == nil # normal case
        neware.name = params["name"]
        neware.username = params["username"]
        neware.password = params["password"]
        neware.save
        @Name = params['username']
        @Username = params['username']
        session[:username] = params['username']
        Item.connection
        User.connection
        whoare = User.find_by username: params["username"]
         @all_item = Item.where(User_id: whoare)
         @size =  (@all_item.size-1)
      else 
        redirect_to main_register_path, notice:'This username is already used!!!'
      end
    else 
      if(session[:username] == nil)
        return redirect_to main_login_path, notice:'you must login first'
      end
        Item.connection
        User.connection
        whoare = User.find_by username: session["username"]
        @Name = whoare.username
        @all_item = Item.where(User_id: whoare)
        @size =  (@all_item.size-1)
    end
  end
  def register
  end
  def user_manage
    if params['commit'] == 'New'
      redirect_to controller:'item',action:'new', Username: session['username']
    elsif params['commit'] == 'Create'
      Item.connection
      User.connection
      puts 'aaaaaaaaaaaaaaaaaaaa'
      newitem = Item.new
      whoare = User.find_by username: params["username"]
      newitem.name = params['name']
      newitem.price = params['price']
      newitem.stock = params['stock']
      newitem.User_id = whoare.id
      newitem.save
      redirect_to controller:'main',action:'user_item', Username: session['username']
    elsif params['commit'] == 'Edit'
      
      redirect_to controller:'item',action:'edit', item_id: params['item_id']
    elsif params['commit'] == 'Done'
      Item.connection
      User.connection
      item = Item.find_by id: params['item_id']
      item.name = params['name']
      item.price = params['price']
      item.stock = params['stock']
      item.save
      redirect_to controller:'main',action:'user_item', Username: session['username']
    elsif params['commit'] == 'Delete'
      Item.connection
      User.connection
      item = Item.find_by id:params['item_id']
      item.destroy
      redirect_to controller:'main',action:'user_item'
    else
    end
  end
  def inventories
    if(session[:username] == nil)
      return redirect_to main_login_path, notice:'you must login first'
    end
    Item.connection
    User.connection
    Inventory.connection
    if params['item_id'] != nil
      inin = Item.find_by id: params['item_id']
      item = params['item_id']
      whoare = User.find_by id: inin.User_id
      newin = Inventory.new
      newin.Item = item
      newin.seller = whoare.username 
      newin.name = inin.name
      newin.price = inin.price
      whoare2 = User.find_by username: session["username"]
      newin.User_id = whoare2.id #owner id
      newin.save
    end
    if params['commit'] == 'Remove'
      ok = Inventory.find_by id:params[:all_id]
      ok.destroy
    end
    whoare = User.find_by username: session["username"]
    @all_in = Inventory.where(User_id: whoare.id)
  
  end
  def log_out
    puts 'ggggggggggggg'
    puts session[:username]
    reset_session
    redirect_to main_login_path
    puts 'ggggggggggggg'
    puts session[:username]
  end
  
end

