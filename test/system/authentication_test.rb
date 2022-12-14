require "application_system_test_case"
class AuthenticationTest < ApplicationSystemTestCase
  test "RegisterValidNewUser" do
    # call the super class method's register a new user that doesn't exist in the users.yml fixtures
    register name: "jesus1", username: "jesus1@mail.com", password: "jesus", user_type: "0"
    
    # assert the contents on the /main/home page
    assert_selector "h1", text: "HOME"
    assert_selector "p", text: "Signed in as jesus1@mail.com"
  end
  
  test "RegisterExistingUsername" do
    # register an existing username (email)
    register name: "invalidJesus", username: "test_ad1@mail.com", password: "jesus", user_type: "0"
  
    # assert by css class = "alert" the notification text
    assert_selector ".alert", text: "This username is already used!!!"
  end
  
  test "LoginCorrectPassword" do
    # call the super class method's login to test the user in the fixtures users.yml
    login username: users(:admin1).username, password: "test_password1"
    
    # assert the contents on the /main/home page
    assert_selector "h1", text: "HOME"
    assert_selector "p", text: users(:admin1).username
  end
  
  test "LoginIncorrectPassword" do
    # call the super class method's login to test the user in the fixtures users.yml but with wrong password
    login username: users(:admin1).username, password: "invalid_password_jesus"
    
    # assert by css class = "alert" the notification text
    assert_selector ".alert", text: "Wrong password or username!"
  end
  
  test "LoginNonExistingUsername" do
    # call super class method's login, and pass in non-existing username
    login username: "jesusjaja", password: "randompw"

    # assert by css class = "alert" the notification text
    assert_selector ".alert", text: "This username is not exist"
  end
  
  test "NotLoginCantGetRoutes" do
    # these routes must not be accessible if not log in
    unaccessible_routes = [
      'main/home',
      'my_market',
      'purchase_history',
      'sale_history',
      'my_inventory',
      'topseller/main',
      'user/main',
      'item',
      'profile/main',
    ]
    
    # visit each route in the array and assert alert notifications that is shown on the /main/login page
    unaccessible_routes.each do |route|
      visit route
      assert_selector ".alert", text: "you must login first"
      assert_selector "h1", text: "Welcome Please Login"
    end
  end
end
