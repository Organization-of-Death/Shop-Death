class ProfileController < ApplicationController
  before_action do
    login?
  end

  def main
    User.connection
    @user = User.find_by username:session[:username]
    if(params['something'] == 'else')
      @show = true
    else
      
    end
    if(params[:commit] == 'Confirm')
      if(!@user.authenticate(params[:oldpassword]))
        flash[:notice] = 'Wrong password!'
        redirect_to controller: 'profile', action: 'main' , something: 'else'
      elsif(@user.authenticate(params[:newpassword]))
        flash[:notice] = 'อย่าทำแบบนี้นะขอร้อง'
        redirect_to controller: 'profile', action: 'main' , something: 'else'
      else 
        @show = false
        @user.password = params[:newpassword] 
        @user.save
      end
    end
 
  end
  def password
    puts 'sasa'
    redirect_to controller: 'profile', action: 'main', something: 'else'
  end
end
