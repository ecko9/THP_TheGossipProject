require 'test_helper'

class GossipControllerTest < ActionDispatch::IntegrationTest
  test "should get show_gossip" do
    get gossip_show_gossip_url
    assert_response :success
  end

end
