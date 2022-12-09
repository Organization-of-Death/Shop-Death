require "test_helper"

class TopsellerControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get topseller_main_url
    assert_response :success
  end
end
