class MainController < ApplicationController
  def login
  end
  def welcome # two root direction
    if(session[:username] != nil)
      puts 'd'
      redirect_to main_home_path,hi:'yo' and return
    else
      redirect_to main_login_path,hi:'yo' and return
    end
   
  end
  def home
    if params['hi'] == 'yo'
      puts 'x'
      return
    end
    if params['commit'] == 'Login'
      User.connection
      puts 'aaaaaaaaaaaaaaaaaaaa'
      neware = User.new
      whoare = User.find_by username: params["username"]
      if whoare == nil
        redirect_to main_login_path, notice:'This username is not exist'
      else 
        if (!whoare.authenticate(params[:password]))
          puts 'sssssssssssssssssssss'
          redirect_to main_login_path, notice:'Wrong password or username!'
        else #normal case
          @Name = whoare.username
          
          session[:username] = whoare.username
          session[:usertype] = whoare.user_type
        
     
          Item.connection
          User.connection
      

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
        neware.user_type = params['usertype'].to_i
        neware.save
        @Name = params['username']
        
        session[:username] = params['username']
        session[:usertype] = params['usertype'].to_i
        Item.connection
        User.connection
 
      else 
        redirect_to main_register_path, notice:'This username is already used!!!'
      end
    else 
      puts'sdssd'
      if(session[:username] == nil)
        return redirect_to main_login_path, notice:'you must login first'
      end
        Item.connection
        User.connection
        whoare = User.find_by username: session["username"]
        if(whoare == nil)
          return redirect_to main_login_path, notice:'you must login first'
        end
        @Name = whoare.username
  
    end
  end
  def user_item
   
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
      newitem.category = params['category']
      if params['enable'] == 'yes'
        newitem.enable = true
      else
        newitem.enable = false
      end

      if params[:picture]
        newitem.picture.attach(params[:picture])
      end

      newitem.save
      redirect_to controller: 'item', action: 'index'
      # redirect_to controller:'main',action:'user_item', Username: session['username']
    elsif params['commit'] == 'Edit'
      puts '===================='
      puts params['item_id']
      puts '===================='
      redirect_to controller:'item',action:'edit', item_id: params['item_id']
    elsif params['commit'] == 'Done'
      Item.connection
      User.connection
      item = Item.find_by id: params['item_id']
      item.name = params['name']
      item.category = params['category']
      if params['enable'] == 'yes'
        item.enable = true
      else
        item.enable = false
      end
      # item.price = params['price']
      # item.stock = params['stock']
      item.save
      redirect_to controller: 'item', action: 'index'
      # redirect_to controller:'main',action:'user_item', Username: session['username']
    elsif params['commit'] == 'Delete'
      Item.connection
      User.connection
      item = Item.find_by id:params['item_id']
      item.destroy
      redirect_to controller: 'item', action: 'index'
      # redirect_to controller:'main',action:'user_item'
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

