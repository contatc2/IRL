require 'test_helper'

class FriendInvitationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get friend_invitations_index_url
    assert_response :success
  end

  test "should get new" do
    get friend_invitations_new_url
    assert_response :success
  end

end
