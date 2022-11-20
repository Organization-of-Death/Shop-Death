class UserController < ApplicationController
  def main
    User.connection
    @all_user = User.all
    @size = @all_user.length-1
  end
  def user_manage
    if params['commit'] == 'Edit'
      redirect_to controller: 'user',action: 'edit',id:params[:id]
    elsif params['commit'] == 'Delete'
     user = User.find_by id:params[:id]
     if(user.username == session[:username])
      redirect_to user_main_path, notice: 'u cannot destroy yourself' and return
     end
      user.destroy
     redirect_to user_main_path
    elsif params['commit'] == 'Save'
      User.connection
      whoare = User.find_by username: params["username"]
      if whoare == nil
        same = User.find_by username: session[:username]
        haha = same.id
        user = User.find_by id: params[:id]
        user.name = params["name"]
        user.username = params["username"]
        user.password = params["password"]
        user.user_type = params['usertype'].to_i
        user.save
        if haha == params[:id].to_i
          puts 'dddddddddddddddddddddddddddd'
          session[:username] = params["username"]
          session[:usertype] = params["usertype"].to_i
        else
          puts 'aaaaaaaaaaaaaaaaaaaaaaaaaaa'
        end
        redirect_to user_main_path
      else 
        redirect_to user_main_path, notice:'This username is already used!!!'
      end
  
    elsif params['commit'] == 'New'
      redirect_to user_new_path
    elsif params['commit'] == 'Create'
      User.connection
      user = User.new
      user.name = params["name"]
      user.username = params["username"]
      user.password = params["password"]
      user.user_type = params['usertype'].to_i
      user.save
      redirect_to user_main_path
    end
  end

  def edit 
    @username = User.find_by id: params[:id]
  end
  def new
  end
end
