require "application_system_test_case"
class NavBarDisplayTest < ApplicationSystemTestCase
    test "NavbarByUserType" do
        # setup constants for each roles
        ADMIN = 0
        BUYER = 1
        SELLER = 2
        
        # define which links in the navbar should be visible to what roles
        link_visible_by_usertype = {
            "Profile" => [ADMIN, BUYER, SELLER],
            "My Market" => [ADMIN, BUYER],
            "Purchase History" => [ADMIN, BUYER],
            "Sale History" => [ADMIN, SELLER],
            "My Inventory" => [ADMIN, SELLER],
            "Top Seller" => [ADMIN, SELLER],
            "User Info" => [ADMIN],
            "Item Info" => [ADMIN]
        }
        
        # define the three types of test users
        test_users = [
            {"username" => users(:buyer1).username, "password" => "test_password2", "usertype" => BUYER},
            {"username" => users(:seller1).username, "password" => "test_password3", "usertype" => SELLER},
            {"username" => users(:admin1).username, "password" => "test_password1", "usertype" => ADMIN}
        ]

        # for each users, check every anchor in the link_visible_by_usertype
        test_users.each do |test_user|
            login username: test_user["username"], password: test_user["password"]

            # the navbar once they logged in should show appropriate navigation links according to their roles
            link_visible_by_usertype.each do |link_text, visible_by|
                count_value = (visible_by.include? test_user["usertype"]) ? 1 : 0 
                assert_selector "a", {count: count_value, text: link_text}
            end

            # every role should also see a logout button
            assert_selector "button", text: "Logout"
        end
    end
end