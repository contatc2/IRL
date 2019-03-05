require 'test_helper'

class UserAdjectivesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_adjectives_index_url
    assert_response :success
  end

end
