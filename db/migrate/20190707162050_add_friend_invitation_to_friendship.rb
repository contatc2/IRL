class AddFriendInvitationToFriendship < ActiveRecord::Migration[5.2]
  def change
    add_reference :friendships, :friend_invitation, foreign_key: true
  end
end
