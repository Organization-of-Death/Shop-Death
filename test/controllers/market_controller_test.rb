require "test_helper"

class MarketControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get market_index_url
    assert_response :success
  end

  test "should get show" do
    get market_show_url
    assert_response :success
  end

  test "should get new" do
    get market_new_url
    assert_response :success
  end

  test "should get edit" do
    get market_edit_url
    assert_response :success
  end

  test "should get create" do
    get market_create_url
    assert_response :success
  end

  test "should get update" do
    get market_update_url
    assert_response :success
  end

  test "should get destroy" do
    get market_destroy_url
    assert_response :success
  end
end
