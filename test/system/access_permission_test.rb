require "application_system_test_case"
class AccessPermissionTest < ApplicationSystemTestCase

    test "testAuthRouteMyMarket1" do 
        login username: "buyer1@mail.com", password: "test_password2"
    
        visit 'my_market'
        assert_selector "h1",text: "Market"
        
    
    end
  
  test "testAuthRouteMyMarket2" do 
    login username: "test_ad1@mail.com", password: "test_password1"
  
    visit 'my_market'
    assert_selector "h1",text: "Market"
    
   
  end

  test "testAuthRoutePurchaseHistory1" do 
    login username: "buyer1@mail.com", password: "test_password2"
  
    visit 'purchase_history'
    assert_selector "h1",text: "Purchase History"
    
  end

  
  
  test "testAuthRoutePurchaseHistory2" do 
    login username: "test_ad1@mail.com", password: "test_password1"
  
    visit 'purchase_history'
    assert_selector "h1",text: "Purchase History"
  
   
  end
  test "testAuthRouteMyInventory1" do 
    login username: "seller1@mail.com", password: "test_password3"
  
    visit 'my_inventory'
    assert_selector "h2",text: "All Items"
    
   
  end
  
  test "testAuthRouteMyInventory2" do 
    login username: "test_ad1@mail.com", password: "test_password1"
  
    visit 'my_inventory'
    assert_selector "h2",text: "All Items"
  
   
  end
  test "testAuthRouteTopSeller1" do 
    login username: "test_ad1@mail.com", password: "test_password1"
  
    visit 'topseller/main'
    assert_selector "h1",text: "Topseller#main"
  end
  test "testAuthRouteTopSeller2" do 
    login username: "seller1@mail.com", password: "test_password3"
  
    visit 'topseller/main'
    assert_selector "h1",text: "Topseller#main"
  end

  test "testAuthRouteUserPages1" do 
    login username: "test_ad1@mail.com", password: "test_password1"
  
    visit 'user/main'
    assert_selector "h1",text: "User"
    visit 'user/edit?id=1'  # careful, u might need some user in db who have id=1 (Should have test admin
    #at the first test)
    assert_selector "p",text:"Find me in app/views/user/edit.html.erb"
    visit 'user/new'
    assert_selector 'h1',text:"New User"
  end

  test "testAuthRouteUserPages2" do 
    login username: "buyer1@mail.com", password: "test_password2"
    unaccessible_routes = [
      'user/main',
      'user/new',
      'user/edit'
    ]
    #test can't access
    # visit each route in the array and assert alert notifications that is shown on the /main/login page
    unaccessible_routes.each do |route|
      visit route
      
      assert_selector ".alert",text: "no permission"
    end
  end

  
  test "testAuthRouteItemPages1" do 
    login username: "buyer1@mail.com", password: "test_password2"
    unaccessible_routes = [
      'item/main',
      'item/new',
      'item/edit',
      'item/1'
    ]
    #test can't access
    # visit each route in the array and assert alert notifications that is shown on the /main/login page
    unaccessible_routes.each do |route|
      visit route
      
      assert_selector ".alert",text: "no permission"
    end
  end
  
  test "testAuthRouteItemPage2" do 
    login username: "test_ad1@mail.com", password: "test_password1"
  
    visit 'item'
    assert_selector "h1",text: "All Items"
    visit 'item/new'
    assert_selector "h1",text: "New Item"
    # fill in item info
    fill_in "Name", with: "item1"
    fill_in "Category", with: "type1"
    click_on "Create"


    visit 'item/edit?item_id=1'
    assert_selector "h1",text: "Item Edit"
    visit 'item/1'
    assert_selector 'strong',text:"ID:"
  end
end