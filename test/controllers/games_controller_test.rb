require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest

  test "should get upload" do
    get games_upload_url
    assert_response :success
  end
end
