require "application_system_test_case"
class PurchaseHistoryTest < ApplicationSystemTestCase
  setup do
    @test_buyer_id = users(:buyer1).id
    @test_seller_id = users(:seller1).id

    @test_item = Item.create(                       # add 1 item
      name: "test_item_name",
      category: "test_item_category",
      enable: true
    )
    
  end
  test "testMarketDelete" do 
    login_as_seller #There is one item on sell in the first place, don't know why
    click_on "My Inventory"
    click_on "Delete"
 
    assert_selector ".my-2" , text: "No data available in table"
    
  end

  test "testMarketAdd" do
    login_as_seller

    click_on "My Inventory"
    #no on sell item for this user
    #add item to market
    click_on "Delete"
    assert_selector ".my-2" , text: "No data available in table"
    click_on "SELL THIS",:match => :first
    fill_in "Price", with: "1"
    fill_in "Stock", with: "50" 
    click_on "CONFIRM"
   
    #check the item added
    assert_selector ".table" do
        assert_selector "td",{count: 1, text: @test_item.id}
        assert_selector "td",{count:1,text: "50"}

        end
    end
    test "testMarketEdit" do
        login_as_seller
    
        click_on "My Inventory"
        click_on "EDIT"

        fill_in "Stock", with: "60" 
        click_on "CONFIRM"

        sleep(5)
        assert_selector ".table" do
            assert_selector "td",{count: 2, text: @test_item.id} # one more from item table
            assert_selector "td",{count:1,text: "60"}
    
            end
        end


        #no on sell item for this user
        #add item to market
       





   
end
