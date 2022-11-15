require "test_helper"

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get profile_main_url
    assert_response :success
  end
end
