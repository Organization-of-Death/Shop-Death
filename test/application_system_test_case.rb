require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def register (name:, username:, password:, user_type:)
    # visit register page
    visit '/main/register'
  
    # fill in user info
    fill_in "name", with: name
    fill_in "username", with: username
    fill_in "password", with: password
    fill_in "usertype", with: user_type
    
    # click on the Register button
    click_on "Register"
  end
  
  def login (username:, password:)
    # visit the login page
    visit 'main/login'
    
    # fill in user info
    fill_in "username", with: username
    fill_in "password", with: password

    # click on the Login button
    click_on "Login"
  end
end
