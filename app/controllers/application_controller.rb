class ApplicationController < ActionController::Base
    def login?
        if(session[:username] != nil)
            return true
        else
            redirect_to main_login_path, notice:'you must login first'
        end
    end
    
    def must_logged_in_as_admin
        if login?
            if session[:usertype] == 0
                true
            else
                redirect_to main_home_path, notice:'no permission'
            end
        else
            redirect_to main_login_path, notice:'you must login first'
        end
    end
    
    def must_logged_in_as_seller
        if login?
            if session[:usertype] == 1
                true
            else
                redirect_to main_home_path, notice:'no permission'
            end
        else
            redirect_to main_login_path, notice:'you must login first'
        end
    end
    
    def must_logged_in_as_buyer
        if login?
            if session[:usertype] == 2
                true
            else
                redirect_to main_home_path, notice:'no permission'
            end
        else
            redirect_to main_login_path, notice:'you must login first'
        end
    end
    
    def must_logged_in_as_one_of roles_array
        if login?
            if roles_array.include? session[:usertype]
                true
            else
                redirect_to main_home_path, notice:'no permission'
            end
        else
            redirect_to main_login_path, notice:'you must login first'
        end
    end
end
