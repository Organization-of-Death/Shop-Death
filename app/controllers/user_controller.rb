class UserController < ApplicationController
  def main
    User.connection
    @all_user = User.all
    @size = @all_user.length-1
  end
  def user_manage
    if params['commit'] == 'Edit'
      redirect_to  user_edit_path
    elsif params['commit'] == 'Delete'
     user = User.find_by id:params[:id]
     if(user.username == session[:username])
      redirect_to user_main_path, notice: 'u cannot destroy yourself' and return
     end
      user.destroy
     redirect_to user_main_path
    elsif params['commit'] == 'Save'
      User.connection
      user = User.find_by username: session[:username]
      user.name = params["name"]
      user.username = params["username"]
      user.password = params["password"]
      user.user_type = params['usertype'].to_i
      user.save

      session[:username] = params["username"]
      session[:usertype] = params["usertype"].to_i
        redirect_to user_main_path
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
    @username = User.find_by username: session[:username]
  end
  def new
  end
end
