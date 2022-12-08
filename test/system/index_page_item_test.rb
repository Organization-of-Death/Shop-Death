require "application_system_test_case"
class IndexPageItemTest < ApplicationSystemTestCase
    setup do
        login_as_admin
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

        # testing enable item
        click_on "New"
        fill_in "name", with: "test_name1"
        fill_in "category", with: "test_category1"
        click_on "Create"

        
        assert_selector "td", text: "1" # item id is correct
        assert_selector "td", text: "test_name1" # item name is correct
        assert_selector "td", text: "test_category1" # category is correct
        assert_selector "td", text: "true"  # enable is true
        
        click_on "New"
        fill_in "name", with: "test_name2"
        fill_in "category", with: "test_category2"
        click_on "Create"

        assert_selector "td", text: "2" # item id is correct
        assert_selector "td", text: "test_name2" # item name is correct
        assert_selector "td", text: "test_category2" # category is correct
        assert_selector "td", text: "true"  # enable is true
        
        assert_selector ".btn", {count: 2, text: "Disable"}
        assert_selector ".btn", {count: 2, text: "Show"}
    end

    
end