require 'test_helper'

class LandingPageControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get landing_page_welcome_url
    assert_response :success
  end

end
