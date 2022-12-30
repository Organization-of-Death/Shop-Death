require "application_system_test_case"
class MarketTest < ApplicationSystemTestCase
  setup do
    @test_seller_id = users(:seller1).id

    @test_item = Item.create(                       # add 1 item
      name: "test_item_name",
      category: "test_item_category",
      enable: true
    )
    
  end
  test "testMarketAdd" do
    login_as_seller

    click_on "My Inventory"
    #no on sell item for this user
    #add item to market
    # click_on "Delete"
    # assert_selector ".my-2" , text: "No data available in table"
    click_on "SELL THIS",:match => :first
    fill_in "Price", with: "9"
    fill_in "Stock", with: "49" 
    click_on "CONFIRM"
   
    #check the item added
   
    assert_selector ".table" do
        assert_selector "td",{count: 2, text: @test_item.id}
        assert_selector "td",{count:1,text: "49"}

        end
    end
    test "testMarketEdit" do
        login_as_seller

        @test_market = Market.create(                       # add 1 market model instance first
          price: 50,
          stock: 40,
          item_id: @test_item.id,
          seller_id: @test_seller_id
        )

        click_on "My Inventory"
        assert_selector "td", {count:1,text: "40"}  #before editing the stock
        click_on "EDIT"

        fill_in "Stock", with: "60" 
        click_on "CONFIRM"

    
        assert_selector ".table" do
            assert_selector "td",{count: 2, text: @test_item.id} # one more from item table
            assert_selector "td",{count:1,text: "60"} # after editing the stock
    
            end
        end


        test "testMarketDelete" do 
          login_as_seller 

          @test_market = Market.create(                       # add 1 market model instance first
            price: 50,
            stock: 40,
            item_id: @test_item.id,
            seller_id: @test_seller_id
          )

          click_on "My Inventory"
          click_on "Delete"
       
          assert_selector ".my-2" , text: "No data available in table"
          
        end

       





   
end
