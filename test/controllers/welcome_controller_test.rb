require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome_user" do
    get welcome_welcome_user_url
    assert_response :success
  end

end
