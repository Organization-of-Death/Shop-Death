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
    
    @test_market = Market.create(                   # add 1 market
      item_id: @test_item.id,
      price: 100,
      stock: 50,
      seller_id: @test_seller_id
      )  
  end

  test "BuyAndUpdatePurchaseHistory" do
    login_as_buyer

    # before buying, assert that no purchase history exist
    click_on "Purchase History"
    assert_selector "p", text: "No data available in table"
    assert_selector "td", {count: 0, text: "test_item_name"}
    assert_selector "td", {count: 0, text: "test_item_category"}
    assert_selector "td", {count: 0, text: "7"}
    assert_selector "td", {count: 0, text: "100.0"}

    # buy 
    visit '/my_market'
    fill_in "amount0", with: "7"
    click_on "Buy"
    
    # after buying, assert notification and that a purchase history exist
    assert_selector ".alert", text: "Buy successfully!"
    click_on "Purchase History"
    assert_selector "td", {count: 1, text: "test_item_name"}
    assert_selector "td", {count: 1, text: "test_item_category"}
    assert_selector "td", {count: 1, text: "7"}
    assert_selector "td", {count: 1, text: "100.0"}





  end


end
