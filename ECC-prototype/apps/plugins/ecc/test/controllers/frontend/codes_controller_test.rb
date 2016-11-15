require 'test_helper'

class Frontend::CodesControllerTest < ActionDispatch::IntegrationTest
  test "should get display" do
    get frontend_codes_display_url
    assert_response :success
  end

end
