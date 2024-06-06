require "test_helper"

class WatchLaterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get watch_later_index_url
    assert_response :success
  end
end
