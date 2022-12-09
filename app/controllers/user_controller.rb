class UserController < ApplicationController
  before_action :must_logged_in_as_admin, only: [:main, :new, :edit]

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
     if user.nil?
        redirect_to user_main_path, notice: 'while you were blinking, some admin already deleted the user' and return
     end
     if(user.username == session[:username])
      redirect_to user_main_path, notice: 'u cannot destroy yourself' and return
     end

      user.destroy
      redirect_to user_main_path, notice: 'destroyed user successfully' and return
    elsif params['commit'] == 'Save'
      User.connection
      # check first if the lock_version is okay, otherwise notify the admin of the updated value
      user = User.find_by id: params[:id]
      if user.lock_version == params[:lock_version].to_i
        whoare = User.find_by username: params["username"]
        if whoare == nil
          # user.name = params["name"]
          # user.username = params["username"]
          # user.password = params["password"]
          # user.user_type = params['usertype'].to_i
          # user.save
          
          user.update(name: params["name"], username: params["username"], password: params["password"], user_type: params["usertype"].to_i, lock_version: params[:lock_version])

          same = User.find_by username: session[:username]
          haha = same.id
          if haha == params[:id].to_i # if the user being edited is the one being logged in, update the session
            puts 'dddddddddddddddddddddddddddd'
            session[:username] = params["username"]
            session[:usertype] = params["usertype"].to_i
          else
            puts 'aaaaaaaaaaaaaaaaaaaaaaaaaaa'
          end
          redirect_to user_main_path, notice:'Updated User Success'
        else 
          redirect_to user_main_path, notice:'This username is already used!!!'
        end
      else
        flash[:notice] = "other admins are also editing, please check the updated value first"
        redirect_to controller: 'user', action: 'edit', id: params['id']
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
