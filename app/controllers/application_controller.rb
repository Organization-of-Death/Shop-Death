class ApplicationController < ActionController::Base
    def login?
        if(session[:username] != nil)
            return true
        else
            redirect_to main_login_path, notice:'you must login first'
        end
    end
end
