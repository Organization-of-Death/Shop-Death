require "test_helper"

class ShopControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get shop_main_url
    assert_response :success
  end
end
