require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get my_profile" do
    get home_my_profile_url
    assert_response :success
  end
end
