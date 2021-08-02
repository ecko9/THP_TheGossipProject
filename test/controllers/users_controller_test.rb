require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show_user" do
    get users_show_user_url
    assert_response :success
  end

end
