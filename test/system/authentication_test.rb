require "application_system_test_case"

class AuthenticationTest < ApplicationSystemTestCase
  # in ApplicationSystemTestCase 
  # driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  test "LoginCorrectPassword" do
    visit '/main/login'
  end
end
