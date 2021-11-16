require "test_helper"

class AuthenticateControllerTest < ActionDispatch::IntegrationTest
  test "should get signup" do
    get authenticate_signup_url
    assert_response :success
  end
end
