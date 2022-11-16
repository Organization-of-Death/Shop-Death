require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get user_main_url
    assert_response :success
  end
end
