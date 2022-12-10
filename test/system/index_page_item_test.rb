require "application_system_test_case"

class IndexPageItemTest < ApplicationSystemTestCase
    setup do
        login_as_admin
        @test_buyer_id = users(:buyer1).id
        @test_seller_id = users(:seller1).id
    end

    test "NoItemDisplay" do
        # if no item is added, the datatable must not be visible and only the "No data available in table" message is shown
        visit '/item'
        assert_selector "p", text: "No data available in table"
        assert_selector "a", text: "New"
        assert_selector "table", count: 0
    end
    
    test "AdminAddItems" do
        # test adding 2 items and check displayed results in the index table
        visit '/item'

        # add the first item
        click_on "New"
        fill_in "name", with: "test_name1"
        fill_in "category", with: "test_category1"
        click_on "Create"
        assert_selector "table", count: 1
        assert_selector "td", text: "1" # item id is correct
        assert_selector "td", text: "test_name1" # item name is correct
        assert_selector "td", text: "test_category1" # category is correct
        assert_selector "td", text: "true"  # enable is true
        
        # add the second item
        click_on "New"
        fill_in "name", with: "test_name2"
        fill_in "category", with: "test_category2"
        click_on "Create"
        assert_selector "td", text: "2" # item id is correct, auto increment
        assert_selector "td", text: "test_name2" # item name is correct
        assert_selector "td", text: "test_category2" # category is correct
        assert_selector "td", text: "true"  # enable is true
        
        assert_selector ".btn", {count: 2, text: "Disable"} # check that there are 2 disable buttons
        assert_selector ".btn", {count: 2, text: "Show"} # check that there are 2 show buttons
    end

    test "AdminEnableDisableItemBuyerView" do
        # setup
        @test_item = Item.create(                       # add 1 item
            name: "test_item_name",
            category: "test_item_category",
            enable: true
        )

        @test_market = Market.create(                   # add 1 market
            item_id: @test_item.id,
            price: 100,
            stock: 50,
            seller_id: @test_seller_id
            )
            
        # check that initially the buyer sees it
        login_as_buyer                                  # login as buyer
        visit '/my_market'                  
        assert_selector "td", text: "test_item_name"    # assert visibility in my_market
        assert_selector "td", text: "test_item_category"
        logout    # logout
        
        # admin then disable it
        login_as_admin                                  # login as admin
        visit '/item'                                   # visit item index page
        click_on "Disable"                              # click on disable
        assert_selector ".btn", text: "Enable"          # assert Enable button
        assert_selector "td", text: "false"             # assert Enable is set to false
        logout                                          # logout
        
        # check that the market with that item is now invisible to the buyer
        login_as_buyer                                                      # login as buyer
        visit '/my_market'    
        assert_selector "td", {count: 0, text: "test_item_name"}            # assert invisibility in my_market
        assert_selector "td", {count: 0, text: "test_item_category"}
        logout    # logout
        
        # admin enable it back
        login_as_admin                                  # login as admin
        visit '/item'                                   # visit item index page
        click_on "Enable"                               # click on Enable
        assert_selector ".btn", text: "Disable"         # assert Disable button
        assert_selector "td", text: "true"              # enable set to true
        logout                                          # logout
        
        # check that the market with that item is now visible to the buyer
        login_as_buyer                                  # login as buyer
        visit '/my_market'                              # visit my_market page
        assert_selector "td", text: "test_item_name"    # assert visibility in my_market
        assert_selector "td", text: "test_item_category"
    end
    
    test "AdminEnableDisableItemSellerView" do
        # setup
        @test_item = Item.create(                       # add 1 item
            name: "test_item_name",
            category: "test_item_category",
            enable: true
        )

        # at first the seller should see it in the All items table in /my_inventory page
        login_as_seller
        visit '/my_inventory'
        assert_selector "td", {count: 1, text: "test_item_name"}    # assert visibility in my_market
        assert_selector "td", {count: 1, text: "test_item_category"}
        logout

        # after the admin disabled the item, the seller shouldn't see it in the All items table in /my_inventory page
        login_as_admin
        visit '/item'
        click_on "Disable"
        logout

        login_as_seller
        visit '/my_inventory'
        assert_selector "td", {count: 0, text: "test_item_name"}    # assert invisibility in my_market
        assert_selector "td", {count: 0, text: "test_item_category"}
        logout
        
        # then after the admin enabled back the seller should be able to see and add it to their inventories (market model)
        login_as_admin
        visit '/item'
        click_on "Enable"
        logout
        
        login_as_seller
        visit '/my_inventory'
        assert_selector "td", {count: 1, text: "test_item_name"}    # assert visibility in my_market
        assert_selector "td", {count: 1, text: "test_item_category"}
        click_on "SELL THIS"

        fill_in "price", with: "64.55"
        fill_in "stock", with: "150"
        click_on "CONFIRM"

        assert_selector "table", {count: 2}
        assert_selector "td", {count: 2, text: "test_item_name"}    # assert visibility in my_market in the two tables
        assert_selector "td", {count: 2, text: "test_item_category"}
        logout
        
        # after the admin disabled the item
        login_as_admin
        visit '/item'
        click_on "Disable"
        logout

        # the seller shouldn't see it in both the All items & My Inventories table in /my_inventory page
        login_as_seller
        visit '/my_inventory'
        assert_selector "td", {count: 0, text: "test_item_name"}    # assert invisibility in my_market
        assert_selector "td", {count: 0, text: "test_item_category"}
    end
end