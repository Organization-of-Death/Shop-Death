require "test_helper"

class MyinvenControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get myinven_main_url
    assert_response :success
  end
end
