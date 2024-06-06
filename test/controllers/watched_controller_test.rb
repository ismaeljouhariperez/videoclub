require "test_helper"

class WatchedControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get watched_index_url
    assert_response :success
  end
end
